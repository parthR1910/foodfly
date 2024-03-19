import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controller/payment_order_detail_controller/payment_order_detail_controller.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/payment/mobile/helper/payment_order_detail.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends ConsumerStatefulWidget {
  final FoodDataModel foodData;
  final int quantity;
  const Payment({super.key,required this.foodData,required this.quantity});

  @override
  ConsumerState<Payment> createState() => _PaymentMobileState();
}

class _PaymentMobileState extends ConsumerState<Payment> {

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
    await ref.watch(paymentOrderDetailController).postUserFoodOrder(quantity: widget.quantity, foodId: widget.foodData.foodId!);
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
    initRazorpay();
  }
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfig(context);
    final paymentOrderDetailWatch = ref.watch(paymentOrderDetailController);
    double productPrice = widget.foodData.price! - widget.foodData.offPrice!;
    double driver = 50.0;
    double productTax = productPrice*widget.quantity*(widget.foodData.tax!/100);
    double totalPrice =productTax+driver+productPrice*widget.quantity;
    return CommonLoading(
      show: paymentOrderDetailWatch.isLoadingOverlay,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 48.h,
              ),
              PaymentOrderDetail(foodData: widget.foodData,quantity: widget.quantity),
              SizedBox(
                height: 64.h,
              ),
              CommonButton(
                onTap: () async {
                  await paymentOrderDetailWatch.postUserFoodCartOrder(quantity: widget.quantity, foodId: widget.foodData.foodId!);
                  if(context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.dashBoard, (route) => false);
                  }
                  },
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text("Add To Cart",
                  style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 10.h,),
              CommonButton(
                onTap: () async{
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                    ///===================== Online payment=================///
                    btnOk: CommonButton(onTap: (){
                      placeOrder(totalPrice);
                    },padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 20.w),child: const Text("Pay UPI"),),
                    ///======================= Cash on delivery ============///
                    btnCancel:  CommonButton(onTap: () async{
                      Navigator.pop(context);
                      await paymentOrderDetailWatch.postUserFoodOrder(quantity: widget.quantity, foodId: widget.foodData.foodId!);
                      if(context.mounted){
                        Navigator.pushNamed(context, AppRoutes.successOrder);
                      }
                    },padding: EdgeInsets.symmetric(vertical: 6.h,),child: const Text("Cash on delivery"),),
                      title: 'Payment',
                      desc: 'Choose your payment type',
                  ).show();


                },
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  ref.watch(appStringController).keyCheckoutNow,
                  style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                ),
              ),


            ],
          ),
        ) ,
      ),
    );
  }

  get appBar => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppAssets.arrowBackSvg,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ref.watch(appStringController).keyPayment,
                style: AppTextStyle.w5
                    .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
            Text(ref.watch(appStringController).keyYouDeserveBetterMeal,
                style: AppTextStyle.w3
                    .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
          ],
        ),
      );
}
