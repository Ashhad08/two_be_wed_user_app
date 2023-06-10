import 'package:flutter/material.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../../../../configs/front_end_configs.dart';
import '../../../../../utils/navigation_helper.dart';
import '../../../../elements/app_text_field.dart';
import '../../../../elements/pick_images_sheet.dart';
import '../../../home_view/home_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Padding(
        padding: FrontEndConfigs.kAllSidePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New\nAccount',
                  style: context.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          builder: (context) => PickImageSheet(
                            onCamera: () {},
                            onGallery: () {},
                          ),
                        );
                      },
                      child: Image.asset(
                        height: 50,
                        width: 50,
                        "assets/images/profile_image_placeholder.png",
                      ),
                    ),
                    5.sH,
                    Text(
                      'Upload your\nprofile picture',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall,
                    )
                  ],
                ),
              ],
            ),
            30.sH,
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
              'Enter Your Email',
              style: context.textTheme.titleMedium,
            ),
            8.sH,
            AppTextField(
              hint: 'Email Here',
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Your Email';
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
            15.sH,
            Text(
              'Enter Your Password',
              style: context.textTheme.titleMedium,
            ),
            8.sH,
            AppTextField(
              hint: 'Password Here',
              isPasswordField: true,
              controller: _passwordController,
              maxLines: 1,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Enter Your Password';
                }
                return null;
              },
            ),
            15.sH,
            Text(
              'Confirm Your Password',
              style: context.textTheme.titleMedium,
            ),
            8.sH,
            AppTextField(
              hint: 'Password Here again',
              isPasswordField: true,
              controller: _passwordController,
              maxLines: 1,
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Confirm Your Password';
                } else if (_passwordController.text !=
                    _confirmPasswordController.text) {
                  return 'Password dosen\'t match';
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
                    'SignUp',
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      NavigationHelper.pushReplacement(
                          context, const HomeView());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
