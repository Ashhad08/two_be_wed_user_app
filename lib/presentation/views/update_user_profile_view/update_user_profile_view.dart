import 'package:flutter/material.dart';
import 'package:two_be_wedd_user_app/configs/front_end_configs.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../elements/app_text_field.dart';
import '../../elements/pick_images_sheet.dart';

class UpdateUserProfileView extends StatefulWidget {
  const UpdateUserProfileView({
    super.key,
  });

  @override
  State<UpdateUserProfileView> createState() => _UpdateUserProfileViewState();
}

class _UpdateUserProfileViewState extends State<UpdateUserProfileView> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update your Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: FrontEndConfigs.kAllSidePadding,
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
                      builder: (context) =>
                          PickImageSheet(onCamera: () {}, onGallery: () {}),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile_image_placeholder.png",
                          height: 100,
                          width: 100,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: ElevatedButton(
                                onPressed: () {},
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
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
