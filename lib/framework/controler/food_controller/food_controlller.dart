import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';
import 'package:food_fly/framework/service/storage_service.dart';
import 'package:uuid/uuid.dart';


final foodController = ChangeNotifierProvider((ref) => FoodController());


class FoodController extends ChangeNotifier{

  final GlobalKey<FormState> formKey = GlobalKey();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isLoading = false;
  File? imageFile;
  String selectedCategory = '';
  String selectedTax ="";
  String selectedOffPrice ="";
  bool isLive = false;
  String urlFormDataBase = "";
  String newsId= "";

  updateIsLive(){
    isLive = !isLive;
    notifyListeners();
  }
  updateSelectedCategory(String value){
    selectedCategory = value;
    notifyListeners();
  }
  updateSelectedTax(String value){
    selectedTax = value;
    notifyListeners();
  }
  updateSelectedOffPrice(String value){
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

  addFoodToFireStore({int? nFlag =0,required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final String imgUrl = await StorageService.service.upLoadFoodImage(imageFile!);
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
      offPrice:selectedOffPrice!=""? double.parse(selectedOffPrice):0
    );
    await FireStoreService.fireStoreService.addFoodToFirebase(foodData);
    isLoading = false;
    if(context.mounted){
      Navigator.pop(context);}
    clearFormData();
    notifyListeners();
  }


  // updateNewsToFireStore({int? nFlag =0,required BuildContext context,}) async {
  //   isLoading = true;
  //   notifyListeners();
  //   String uploadImg = "";
  //   if(imageFile!=null){
  //     final String imgUrl = await StorageService().upLoadImage(imageFile!);
  //     uploadImg = imgUrl;
  //   }
  //   final newsTable = NewsTable(
  //       id: newsId,
  //       title: titleController.text,
  //       subtitle: subtitleController.text,
  //       description: descriptionController.text,
  //       image: imageFile!=null? uploadImg :urlFormDataBase,
  //       liveFlag:isLive?1:0,
  //       category: selectedCategory,
  //       nFlag: nFlag
  //   );
  //   await FireStoreService.fireStoreService.updateNewsToFirebase(newsTable);
  //   isLoading = false;
  //   if(context.mounted){
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //   }
  //   clearFormData();
  //   notifyListeners();
  // }
  //
  // deleteNews({required String id,required BuildContext context})async{
  //   await FireStoreService.fireStoreService.deleteNewsToFirebase(id: id);
  //   if(context.mounted){
  //     Navigator.pop(context);
  //     Navigator.pop(context);
  //   }
  // }

  clearFormData(){
    nameController.clear();
    priceController.clear();
    descriptionController.clear();
    imageFile = null;
    isLive = false;
    urlFormDataBase = "";
    selectedCategory = '';
    selectedTax = '';
    isUpdateButton = false;
    newsId= "";
    notifyListeners();
  }

  bool isUpdateButton = false;

  // addExistingDataToFields(NewsTable newsTable,bool updateButtonValue){
  //   titleController.text = newsTable.title!;
  //   subtitleController.text = newsTable.subtitle!;
  //   descriptionController.text = newsTable.description!;
  //   urlFormDataBase = newsTable.image!;
  //   isLive = newsTable.liveFlag ==1?true:false;
  //   selectedCategory = newsTable.category!;
  //   isUpdateButton = updateButtonValue;
  //   newsId= newsTable.id!;
  //   notifyListeners();
  // }
}