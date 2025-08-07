import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/auth_service.dart';
import 'package:food_fly/framework/service/fire_base_singleton.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

final orderControllerProvider =
    ChangeNotifierProvider((ref) => OrderController());

class OrderController extends ChangeNotifier {
  TextEditingController reviewController = TextEditingController();
  double rating = 3.0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  clearData() {
    reviewController.clear();
    rating = 3.0;
    notifyListeners();
  }

  Future<void> submitReview(FoodDataModel foodDataModel, String orderId) async {
    final review = RatingDataModel(
      uid: AuthService.authService.auth.currentUser!.uid,
      rating: rating,
      orderId: orderId,
      remarks: reviewController.text,
    ).toJson();

    final docRef = FirebaseSingleTon.firebaseSingleTon.fireStore
        .collection('Foods')
        .doc(foodDataModel.foodId);

    // Fetch the existing ratings list
    final docSnapshot = await docRef.get();
    final existingRatingsList = docSnapshot.data()?['ratingsList'] ?? [];

    // Append the new review to the existing list
    final updatedRatingsList = List.from(existingRatingsList)..add(review);

    // Update the document with the updated ratings list
    await docRef.update({
      'ratingsList': updatedRatingsList,
    });
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
