import 'package:flutter/services.dart';
import 'package:food_fly/framework/controller/food_controller/food_controlller.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/extension/widget_extension.dart';
import 'package:food_fly/ui/utils/form_validator.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_form_field.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';

import '../utils/theme/theme.dart';
import '../utils/widgets/common_snackbar.dart';

class AddFood extends ConsumerWidget {
  const AddFood({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final foodWatch = ref.watch(foodController);
    final size = MediaQuery.of(context).size;
    return CommonLoading(
      show: foodWatch.isLoading,
      child: PopScope(
        canPop: foodWatch.isLoading?false: true,
        onPopInvoked: (value){
          foodWatch.isLoading?null:foodWatch.clearFormData();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle:  true,
            automaticallyImplyLeading: false,
            title:  Text(
              foodWatch.isUpdateButton ?"Update Food":"Add Food",
              style: AppTextStyle.w5.copyWith(fontSize: 25.sp,color: AppColors.kPrimary),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Category",
                        style: AppTextStyle.w5.copyWith(fontSize: 16.sp,color: AppColors.textGreyColor),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 3,
                        children: catagories.map((option) {
                          return ChoiceChip(
                            label: Text(option),
                            selected: foodWatch.selectedCategory == option,
                            selectedColor: AppColors.kPrimary,
                            onSelected: (selected) {
                              foodWatch.updateSelectedCategory(selected ? option : '');
                            },
                          );
                        }).toList(),),
                      Form(
                        key: foodWatch.formKey,
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "name",
                              style: AppTextStyle.w5.copyWith(fontSize: 14.sp,color: AppColors.textGreyColor),
                            ),
                             CommonFormField(
                               autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: foodWatch.nameController,
                              hintText: "Name", validator: requiredFieldValidator,
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              "description",
                              style: AppTextStyle.w5.copyWith(fontSize: 14.sp,color: AppColors.textGreyColor),
                            ),
                             CommonFormField(
                               autovalidateMode: AutovalidateMode.onUserInteraction,
                               controller:  foodWatch.descriptionController,
                              hintText: "Description", validator: requiredFieldValidator,),
                            SizedBox(height: 10.h,),
                            Text(
                              "price",
                              style: AppTextStyle.w5.copyWith(fontSize: 14.sp,color: AppColors.textGreyColor),
                            ),
                            CommonFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: foodWatch.priceController,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly,],
                              hintText: "Price", validator: requiredFieldValidator,
                            ),
                          ])
                      ).paddingVertical(15.h),
                      Text(
                        "Select The Taxation",
                        style: AppTextStyle.w5.copyWith(fontSize: 16.sp,color: AppColors.textGreyColor),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 3,
                        children: taxList.map((option) {
                          return ChoiceChip(
                            label: Text("$option%"),
                            selected: foodWatch.selectedTax == option,
                            selectedColor: AppColors.kPrimary,
                            onSelected: (selected) {
                              foodWatch.updateSelectedTax(selected ? option : '');
                            },
                          );
                        }).toList(),),
                      SizedBox(height: 10.h,),
                      Text(
                        "Price off for the Food (Optional)",
                        style: AppTextStyle.w5.copyWith(fontSize: 16.sp,color: AppColors.textGreyColor),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 3,
                        children: offPriceList.map((option) {
                          return ChoiceChip(
                            label: Text("₹ $option OFF"),
                            selected: foodWatch.selectedOffPrice == option,
                            selectedColor: AppColors.kPrimary,
                            onSelected: (selected) {
                              foodWatch.updateSelectedOffPrice(selected ? option : '');
                            },
                          );
                        }).toList(),),
                      SizedBox(height: 10.h,),
                      foodWatch.imageFile!=null?
                      GestureDetector(
                        onTap: (){
                          foodWatch.pickImageFromMedia();
                        },
                        child: SizedBox(
                          height: 180.h,
                          width: size.width,
                          child: Image.file(foodWatch.imageFile!,fit: BoxFit.fill,),
                        ),
                      ):
                      foodWatch.urlFormDataBase != ""?
                      GestureDetector(
                        onTap: (){
                          foodWatch.pickImageFromMedia();
                        },
                        child: SizedBox(
                          height: 180.h,
                          width: size.width,
                          child: Image.network(foodWatch.urlFormDataBase,fit: BoxFit.fill,),
                        ),
                      )
                          :foodWatch.imageFile != null?
                      GestureDetector(
                        onTap: (){
                          foodWatch.pickImageFromMedia();
                        },
                        child: SizedBox(
                          height: 180.h,
                          width: size.width,
                          child: Image.file(foodWatch.imageFile!,fit: BoxFit.fill,),
                        ),
                      ):
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: (){
                                foodWatch.pickImageFromMedia();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                                  backgroundColor: AppColors.kPrimary,
                                  padding: EdgeInsets.symmetric(vertical: 20.h)
                              ), child: const Text("Select Image",style: TextStyle(color: Colors.white),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

              /// Post Button ///
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: ()async{
                          if(foodWatch.selectedCategory != ""){
                            if(foodWatch.formKey.currentState!.validate()){
                              if(foodWatch.selectedTax != ""){
                                if(foodWatch.urlFormDataBase!="" || foodWatch.imageFile != null){
                                  foodWatch.isUpdateButton?await foodWatch.updateFoodToFireStore(context: context): await foodWatch.addFoodToFireStore(context: context);
                                  // await foodWatch.addFoodToFireStore(context: context);
                                }else{
                                  commonSnackBar(context: context, eText: "Please select Food image!!",backgroundColor: AppColors.textGreyColor);
                                }
                              }else{
                                commonSnackBar(context: context, eText: "Please add Tax to the food!!!",backgroundColor: AppColors.textGreyColor);
                              }
                            }}else{
                            commonSnackBar(context: context, eText: "Please select category!!!",backgroundColor: AppColors.textGreyColor);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                            backgroundColor: AppColors.kPrimary,
                            padding: EdgeInsets.symmetric(vertical: 20.h)
                        ), child:  Text(foodWatch.isUpdateButton? "Update Product":"Add Product",style: const TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
