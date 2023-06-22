import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd_user_app/presentation/views/user_auth_view/user_auth_view.dart';
import 'package:two_be_wedd_user_app/utils/extensions.dart';

import '../../../infrastructure/providers/loading_helper.dart';
import '../../../infrastructure/services/auth_services.dart';
import '../../../utils/navigation_helper.dart';
import '../../../utils/utils.dart';
import '../../elements/app_text_field.dart';
import '../../elements/loading_overlay.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoadingOverlay(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Forgot Your Password',
            ),
          ),
          body: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    40.sH,
                    Image.asset("assets/images/forgot_password.png"),
                    20.sH,
                    Text(
                      'Enter your registered email below to receive password reset instruction',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    35.sH,
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
                    30.sH,
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: context.screenWidth * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              sendPasswordResetEmail(
                                  email: _emailController.text,
                                  context: context);
                            }
                          },
                          child: const Text('Send password reset email'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void sendPasswordResetEmail(
      {required String email, required BuildContext context}) {
    final loadingProvider = Provider.of<LoadingHelper>(context, listen: false);

    loadingProvider.stateStatus(StateStatus.IsBusy);

    AuthServices()
        .sendPasswordResetEmail(email: email, context: context)
        .then((value) {
      loadingProvider.stateStatus(StateStatus.IsFree);
      Utils.showSnackBar(
          context: context,
          message: 'Password reset email has been sent.',
          color: Theme.of(context).colorScheme.primary);

      NavigationHelper.pushReplacement(context, const UserAuthView());
    }).onError((error, stackTrace) {
      loadingProvider.stateStatus(StateStatus.IsError);
      Utils.showSnackBar(
          context: context,
          message: 'Something went Wrong',
          color: Theme.of(context).colorScheme.error);
    });
  }
}
