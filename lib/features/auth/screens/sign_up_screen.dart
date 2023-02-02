import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'package:rent_a_car/common_widgets.dart/app_text_field.dart';
import 'package:rent_a_car/common_widgets.dart/big_text.dart';
import 'package:rent_a_car/constants/colors.dart';
import 'package:rent_a_car/constants/dimensions.dart';
import 'package:rent_a_car/constants/utils.dart';
import 'package:rent_a_car/providers/all_providers.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = "/sign-up";
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  void _registration() {
    String name = nameController.text.trim();

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty) {
      showSnackBar(context, "Type in your name");
    } else if (email.isEmpty) {
      showSnackBar(context, "Type in your email adress");
    } else if (!EmailValidator.validate(email)) {
      showSnackBar(
        context,
        "Type in a valid email address",
      );
    } else if (password.isEmpty) {
      showSnackBar(context, "Type in your password");
    } else if (password.length < 6) {
      showSnackBar(context, "Password can not be less than six characters");
    } else {
      ref.read(authServiceProvider).signUpUser(
          context: context, email: email, password: password, name: name);
      showSnackBar(
          context, 'Account created! Login with the same credentials!');
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.instance.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimensions.screenHeight! * 0.05,
            ),
            SizedBox(
              height: Dimensions.screenHeight! * 0.25,
              child: Center(
                child: Lottie.asset("assets/lottie/lottie_car_sign_up.json",
                    fit: BoxFit.cover),
              ),
            ),
            AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20),
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.password),
            SizedBox(height: Dimensions.height20),
            AppTextField(
                textController: nameController,
                hintText: "Name",
                icon: Icons.person),
            SizedBox(height: Dimensions.height20),
            GestureDetector(
              onTap: _registration,
              child: Container(
                alignment: Alignment.center,
                width: Dimensions.screenWidth! / 2,
                height: Dimensions.screenHeight! / 13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.mainColor),
                child: const BigText(
                  text: "Sign Up",
                  size: 27,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pop(context),
                text: "Have an account already?",
                style: TextStyle(color: Colors.grey[500], fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
