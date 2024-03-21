import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:food_fly/framework/controller/cart_controller/cart_controller.dart';
import 'package:food_fly/framework/model/food_cart_model/food_cart_model.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../../framework/model/food_data_model/food_data_model.dart';
import '../../../../../framework/model/payment_model/payment_model.dart';
import '../../../../../framework/service/auth_service.dart';
import '../../../../../framework/service/fire_store_service.dart';
import '../../../../utils/theme/app_routes.dart';
import '../../../../utils/widgets/common_button.dart';
import '../cart_tile.dart';
import "package:http/http.dart" as http;

class CartCartTile extends ConsumerStatefulWidget {
  final FoodDataModel foodData;
  final FoodCartModel order;
  final BuildContext parenteContext;
  const CartCartTile( {super.key,required this.foodData,required this.order,required this.parenteContext});

  @override
  ConsumerState createState() => _CartCartTileState();
}

class _CartCartTileState extends ConsumerState<CartCartTile> {


  String msg = '';
  Razorpay razorpay = Razorpay();

  void initRazorpay() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async{
    msg = "SUCCESS: ${response.paymentId}";
    Navigator.pop(context);
    double productPrice = widget.foodData.price! - widget.foodData.offPrice!;
    double driver = 50.0;
    double productTax = productPrice*widget.order.quantity!*(widget.foodData.tax!/100);
    double totalPrice =productTax+driver+productPrice*widget.order.quantity!;

    await ref.watch(cartController).postUserFoodOrder(quantity: widget.order.quantity!, foodId: widget.foodData.foodId!, paidOrNot: true);
    await ref.watch(cartController).removeCartDataFromFirebase(widget.order.uOrderId!);
    String uid = AuthService.authService.auth.currentUser!.uid;
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    PaymentModel paymentModel = PaymentModel(amount: totalPrice, foodId: widget.foodData.foodId, payType: "online", paymentId: response.paymentId, time: formatter.format(now), transactionId: response.paymentId, userId: uid);
    await FireStoreService.fireStoreService.setPaymentToFirebase(paymentModel: paymentModel);
    if(context.mounted){
      Navigator.pushNamed(context, AppRoutes.successOrder);
    }
    print(msg);
  }


  void handlerErrorFailure(PaymentFailureResponse response) {
    msg = "ERROR: ${response.code} - ${jsonDecode(response.message ?? '')['error']['description']}";
    print(msg);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    msg = "EXTERNAL_WALLET: ${response.walletName}";
    print(msg);
  }

  String keyId = 'rzp_test_8scgsuUjP8IMjA';
  String keySecret = 'G3muDsXMGPXf1IU20CdfZKQb';

  Map<String, String> getAuth() {
    String auth = base64Encode(utf8.encode('$keyId:$keySecret'));
    Map<String, String> authMap = ({
      'Content-Type': 'application/json',
      'Authorization': 'Basic $auth',
    });
    return authMap;
  }

  Map<String, dynamic> getOrder(double amount) {
    Map<String, dynamic> orderMap = ({
      'amount': amount*100,
      'currency': 'INR',
      'receipt': 'rcptid_11',
    });
    return orderMap;
  }

  Future<void> placeOrder(double amount) async{
    http
        .post(
      Uri.parse('https://api.razorpay.com/v1/orders'),
      headers: getAuth(),
      body: jsonEncode(getOrder(amount)),
    )
        .then((value) {
      if (value.statusCode == 200) {
        print("data ${value.body}");
        openGateway(jsonDecode(value.body)['id']);
      }
    });
  }

  void openGateway(String orderId) {
    var option = ({
      'key': 'rzp_test_8scgsuUjP8IMjA',
      'amount': 100,
      'name': 'Premium for news app',
      'order_id': orderId,
      'timeout': 120,
    });
    razorpay.open(option);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init call");
    initRazorpay();
  }

  @override
  Widget build(BuildContext context) {
    final cartWatch = ref.watch(cartController);
    double productPrice = widget.foodData.price! - widget.foodData.offPrice!;
    double driver = 50.0;
    double productTax = productPrice*widget.order.quantity!*(widget.foodData.tax!/100);
    double totalPrice =productTax+driver+productPrice*widget.order.quantity!;
    return  CartTile(
      buttonText: "Order now",
      iconWidget: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
          onPressed: ()async{
            await cartWatch.removeCartDataFromFirebase(widget.order.uOrderId!);
            commonToast("Removed ${widget.foodData.name}");
          },
          icon: const Icon(Icons.delete,color:AppColors.orangeColor ,),
          label: Text("Remove",style: AppTextStyle.w5.copyWith(color: AppColors.orangeColor),)),
      quantity: widget.order.quantity!,
      dateTime: widget.order.dateTime,
      onButtonTap: (){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          ///===================== Online payment=================///
          btnOk: CommonButton(onTap: () async{
            await placeOrder(totalPrice);
            // if(context.mounted){
            //   Navigator.pushNamed(context, AppRoutes.successOrder);
            // }
            commonToast("${widget.foodData.name} Ordered Successfully");
          },padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 20.w),child: const Text("Pay UPI"),),
          ///======================= Cash on delivery ============///
          btnCancel:  CommonButton(onTap: () async{
            Navigator.pop(context);
            await cartWatch.postUserFoodOrder(quantity: widget.order.quantity??1, foodId: widget.order.foodId!, paidOrNot: false);
            await cartWatch.removeCartDataFromFirebase(widget.order.uOrderId!);
            // if(context.mounted){
            //   Navigator.pushNamed(context, AppRoutes.successOrder);
            // }
            commonToast("${widget.foodData.name} Ordered Successfully");

          },padding: EdgeInsets.symmetric(vertical: 6.h,),child: const Text("Cash on delivery"),),
          title: 'Payment',
          desc: 'Choose your payment type',
        ).show();
      },
      backgroundColor: AppColors.orangeColor,
      foodData: widget.foodData,
      orderStatusText: "Order this food",
      orderStatusColor: AppColors.orangeColor,
    );
  }
}
