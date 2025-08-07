import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/framework/service/storage_service.dart';
import 'package:uuid/uuid.dart';

final foodController = ChangeNotifierProvider((ref) => FoodController());

class FoodController extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;
  File? imageFile;
  String selectedCategory = '';
  String selectedTax = "";
  String selectedOffPrice = "";
  String urlFormDataBase = "";
  String foodId = "";

  updateSelectedCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  updateSelectedTax(String value) {
    selectedTax = value;
    notifyListeners();
  }

  updateSelectedOffPrice(String value) {
    selectedOffPrice = value;
    notifyListeners();
  }

  Future<void> pickImageFromMedia() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      final PlatformFile file = result.files.first;
      imageFile = File(file.path!);
      notifyListeners();
      print(imageFile!.path);
    }
    notifyListeners();
  }

  addFoodToFireStore({int? nFlag = 0, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final String imgUrl =
        await StorageService.service.upLoadFoodImage(imageFile!);
    Uuid uuid = const Uuid();
    String uniqueId = uuid.v4();
    final foodData = FoodDataModel(
        foodId: uniqueId,
        name: nameController.text,
        description: descriptionController.text,
        categoryId: selectedCategory,
        price: int.parse(priceController.text),
        image: imgUrl,
        tax: double.parse(selectedTax),
        deliveredCnt: 0,
        offPrice: selectedOffPrice != "" ? double.parse(selectedOffPrice) : 0);
    await FireStoreService.fireStoreService.addFoodToFirebase(foodData);
    isLoading = false;
    if (context.mounted) {
      Navigator.pop(context);
    }
    clearFormData();
    notifyListeners();
  }

  updateFoodToFireStore({
    int? nFlag = 0,
    required BuildContext context,
  }) async {
    isLoading = true;
    notifyListeners();
    String uploadImg = "";
    if (imageFile != null) {
      final String imgUrl =
          await StorageService.service.upLoadFoodImage(imageFile!);
      uploadImg = imgUrl;
    }
    final foodData = FoodDataModel(
        foodId: foodId,
        name: nameController.text,
        description: descriptionController.text,
        categoryId: selectedCategory,
        price: int.parse(priceController.text),
        image: imageFile != null ? uploadImg : urlFormDataBase,
        tax: double.parse(selectedTax),
        offPrice: selectedOffPrice != "" ? double.parse(selectedOffPrice) : 0);
    await FireStoreService.fireStoreService.updateFoodToFirebase(foodData);
    isLoading = false;
    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
    clearFormData();
    notifyListeners();
  }

  deleteFood({required String id, required BuildContext context}) async {
    await FireStoreService.fireStoreService.deleteFoodToFirebase(id: id);
    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  clearFormData() {
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    imageFile = null;
    urlFormDataBase = "";
    selectedCategory = '';
    selectedTax = '';
    selectedOffPrice = '';
    isUpdateButton = false;
    foodId = "";
    notifyListeners();
  }

  bool isUpdateButton = false;

  addExistingDataToFields(FoodDataModel foodData, bool updateButtonValue) {
    nameController.text = foodData.name!;
    descriptionController.text = foodData.description!;
    priceController.text = foodData.price.toString();
    urlFormDataBase = foodData.image!;
    selectedCategory = foodData.categoryId!;
    selectedOffPrice =
        foodData.offPrice! > 0 ? foodData.offPrice!.toString() : "";
    selectedTax = foodData.tax.toString();
    isUpdateButton = updateButtonValue;
    foodId = foodData.foodId!;
    notifyListeners();
  }

  double calculateAverageRating(List<RatingDataModel> ratings) {
    if (ratings.isEmpty) {
      return 0.0; // Return 0 if there are no ratings
    }

    double totalRating = 0.0;
    for (var rating in ratings) {
      totalRating += rating.rating;
    }

    return totalRating / ratings.length;
  }
}
