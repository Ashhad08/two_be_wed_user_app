import 'package:flutter/material.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../../../../configs/front_end_configs.dart';
import '../../../../../utils/navigation_helper.dart';
import '../../../../elements/app_text_field.dart';
import '../../../home_view/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            20.sH,
            Text('Welcome Back', style: context.textTheme.titleLarge),
            25.sH,
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
                    'Login',
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      NavigationHelper.pushReplacement(context, const HomeView());
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
