import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/user_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/text_input.dart';
import 'package:food_fly_delivery_partner/features/profile/controller/profile_controller.dart';
import 'package:geocoding/geocoding.dart';

class PersonalDetail extends ConsumerStatefulWidget {
  const PersonalDetail({super.key, required this.userModel});
  final UserModel userModel;

  @override
  ConsumerState<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends ConsumerState<PersonalDetail> {
  @override
  void initState() {
    super.initState();
    ref.read(profileControllerProvider).init(widget.userModel);
  }

  @override
  void dispose() {
    print('dispose');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileWatch = ref.watch(profileControllerProvider);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        ref.read(profileControllerProvider).clearData();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profilee'),
          ),
          body: profileWatch.isLoading
              ? const Center(
                  child: const CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Form(
                    key: profileWatch.profilekey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: EditProfileImg(
                                  widget.userModel.profileImage ?? '')),
                          const SizedBox(height: 30),
                          MyTextInput(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 20),
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: profileWatch.nameController,
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            customBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: context.primaryColor)),
                            label: 'Name',
                          ),
                          const SizedBox(height: 15),
                          MyTextInput(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 20),
                            controller: profileWatch.numberController,
                            label: 'Phone Number',
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            prefixIcon: const IconButton(
                                onPressed: null, icon: Text('+91')),
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your phone number';
                              } else if (p0.length < 10) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            },
                            customBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: context.primaryColor)),
                          ),
                          const SizedBox(height: 15),
                          MyTextInput(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 20),
                            controller: profileWatch.addressController,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            label: 'Address',
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                            customBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: context.primaryColor)),
                          ),
                          const SizedBox(height: 30),
                          CommonButton(
                              onTap: () {
                                if (profileWatch.nameController.text ==
                                        widget.userModel.name &&
                                    profileWatch.addressController.text ==
                                        widget.userModel.address &&
                                    profileWatch.numberController.text ==
                                        widget.userModel.phone &&
                                    profileWatch.selectedImgPath.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Data is already uptodate');
                                  return;
                                }
                                profileWatch.updateProfile(
                                    widget.userModel.uid!, context);
                              },
                              btnText: 'Update Profile')
                        ]),
                  ),
                )),
    );
  }
}

class EditProfileImg extends ConsumerWidget {
  const EditProfileImg(this.imgUrl, {super.key});
  final String imgUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileController = ref.watch(profileControllerProvider);

    return GestureDetector(
        onTap: () {
          profileController.pickImage();
        },
        child: Card(
          elevation: 10,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r)),
          child: Container(
            width: 120.h,
            height: 120.w,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Color(0xffD6D6D6)),
            child: imgUrl.isNotEmpty
                ? profileController.selectedImgPath.isNotEmpty
                    ? Image.file(
                        File(profileController.selectedImgPath),
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: imgUrl,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                        fit: BoxFit.cover,
                      )
                : Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: 40.sp,
                      color: Colors.white,
                    ),
                  ),
          ),
        ));
  }
}
