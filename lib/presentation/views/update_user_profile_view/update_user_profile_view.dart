import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd_user_app/infrastructure/services/user_services.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../../configs/front_end_configs.dart';
import '../../../infrastructure/models/user_model.dart';
import '../../../infrastructure/providers/loading_helper.dart';
import '../../../infrastructure/providers/profile_image_provider.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/custom_image.dart';
import '../../elements/loading_overlay.dart';
import '../../elements/pick_images_sheet.dart';

class UpdateUserProfileView extends StatefulWidget {
  const UpdateUserProfileView({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<UpdateUserProfileView> createState() => _UpdateUserProfileViewState();
}

class _UpdateUserProfileViewState extends State<UpdateUserProfileView> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _phoneNumberController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userProfileImage =
          Provider.of<ProfileImageProvider>(context, listen: false);
      userProfileImage.profileImage = widget.user.profileImage!;
      _nameController = TextEditingController(text: widget.user.name);
      _phoneNumberController =
          TextEditingController(text: widget.user.phoneNumber);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProfileImage = context.watch<ProfileImageProvider>();
    return CustomLoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update your Profile',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: FrontEndConfigs.kAllSidePadding,
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          builder: (context) => PickImageSheet(
                            onCamera: () async {
                              Navigator.pop(context);
                              await userProfileImage.userprofileImage(context,
                                  source: ImageSource.camera);
                            },
                            onGallery: () async {
                              Navigator.pop(context);
                              await userProfileImage.userprofileImage(context,
                                  source: ImageSource.gallery);
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            userProfileImage.profileImageLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : userProfileImage.profileImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CustomImage(
                                          image: userProfileImage.profileImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        height: 50,
                                        width: 50,
                                        "assets/images/profile_image_placeholder.png",
                                      ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: ElevatedButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          ),
                                        ),
                                        builder: (context) => PickImageSheet(
                                          onCamera: () async {
                                            Navigator.pop(context);
                                            await userProfileImage
                                                .userprofileImage(context,
                                                    source: ImageSource.camera);
                                          },
                                          onGallery: () async {
                                            Navigator.pop(context);
                                            await userProfileImage
                                                .userprofileImage(context,
                                                    source:
                                                        ImageSource.gallery);
                                          },
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.zero),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 20,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  50.sH,
                  Text(
                    'Enter your Name',
                    style: context.textTheme.titleMedium,
                  ),
                  8.sH,
                  AppTextField(
                    hint: 'Name Here',
                    controller: _nameController,
                    textInputType: TextInputType.name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter Your Name';
                      }
                      return null;
                    },
                  ),
                  15.sH,
                  Text(
                    'Your WhatsApp/Mobile Number',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  5.sH,
                  AppTextField(
                    hint: 'Enter your WhatsApp/Mobile number',
                    textInputType: TextInputType.phone,
                    controller: _phoneNumberController,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Enter Hall WhatsApp number';
                      } else if (val.length < 11) {
                        return 'WhatsApp number must be 11 digits';
                      }
                      return null;
                    },
                  ),
                  30.sH,
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: context.screenWidth * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          foregroundColor: context.colorScheme.onPrimary,
                          backgroundColor: context.colorScheme.primary,
                        ),
                        child: const Text(
                          'Update',
                        ),
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            await _updateProfile(context);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile(BuildContext context) async {
    final userProfileImage =
        Provider.of<ProfileImageProvider>(context, listen: false);
    if (userProfileImage.profileImage == null) {
      Utils.showSnackBar(
          context: context,
          message: "Kindly Select profile image",
          color: context.colorScheme.error);
    } else {
      final loadingProvider =
          Provider.of<LoadingHelper>(context, listen: false);

      loadingProvider.stateStatus(StateStatus.IsBusy);
      await UserServices()
          .updateUserProfile(
              context: context,
              name: _nameController.text.trim(),
              phoneNumber: _phoneNumberController.text.trim(),
              uid: widget.user.uid!)
          .then((value) {
        loadingProvider.stateStatus(StateStatus.IsFree);
        Navigator.pop(context);
        Utils.showSnackBar(
            context: context,
            message: "Your Profile Information Changed Successfully");
      }).onError((error, stackTrace) {
        loadingProvider.stateStatus(StateStatus.IsError);
        debugPrint(stackTrace.toString());
        Utils.showSnackBar(
            context: context,
            message: error.toString().replaceAll(RegExp(r'\[.*?\]'), '').trim(),
            color: Theme.of(context).colorScheme.error);
      });
    }
  }
}
