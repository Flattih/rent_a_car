import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rent_a_car/common_widgets.dart/app_text_field.dart';
import 'package:rent_a_car/common_widgets.dart/custom_button.dart';
import 'package:rent_a_car/constants/dimensions.dart';
import 'package:rent_a_car/constants/utils.dart';
import 'package:rent_a_car/features/auth/screens/sign_up_screen.dart';
import 'package:rent_a_car/providers/all_providers.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const String routeName = '/sign-in';
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isEmpty) {
      showSnackBar(context, "Type in your email adress");
    } else if (!EmailValidator.validate(email)) {
      showSnackBar(context, "Type in a valid email address");
    } else if (password.isEmpty) {
      showSnackBar(context, "Type in your password");
    } else if (password.length < 6) {
      showSnackBar(context, "Password can not be less than six characters");
    } else {
      ref
          .read(authServiceProvider)
          .signInUser(context: context, email: email, password: password);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.instance.init(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Lottie.asset(
                "assets/lottie/lottie_car.json",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: Dimensions.height30 * 2.5,
              ),
              AppTextField(
                  textController: emailController,
                  hintText: "Enter your mail",
                  icon: Icons.email),
              SizedBox(
                height: Dimensions.height30,
              ),
              AppTextField(
                  textController: passwordController,
                  hintText: "Enter your password",
                  icon: Icons.password),
              SizedBox(height: Dimensions.height45 * 1.5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.height20),
                child: CustomButton(
                  color: const Color(0xFFEAC785),
                  text: "Login",
                  onTap: _login,
                ),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              RichText(
                text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () =>
                        Navigator.pushNamed(context, SignUpScreen.routeName),
                  text: "Don't have an account?",
                  style: TextStyle(color: Colors.grey[500], fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
