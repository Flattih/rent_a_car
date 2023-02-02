// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:rent_a_car/constants/utils.dart';
import 'package:rent_a_car/all_cars.dart';
import 'package:rent_a_car/features/auth/screens/sign_in_screen.dart';
import 'package:rent_a_car/features/home/screens/products/screens/bottom_screen.dart';
import 'package:rent_a_car/providers/all_providers.dart';

import '../../../common_widgets.dart/error_handling.dart';
import '../../../models/user.dart';

class AuthService {
  final ProviderRef ref;
  AuthService({
    required this.ref,
  });
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "id",
          name: name,
          email: email,
          password: password,
          token: "token");

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignInScreen()));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          var navigator = Navigator.of(context);
          ref
              .read(userProvider.notifier)
              .update((state) => User.fromJson(res.body));

          await ref
              .watch(sharedProvider)
              .setString('x-auth-token', jsonDecode(res.body)['token']);
          navigator.pushNamedAndRemoveUntil(
              BottomScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData({required BuildContext context}) async {
    try {
      String? token = ref.watch(sharedProvider).getString('x-auth-token');

      if (token == null) {
        ref.watch(sharedProvider).setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        ref
            .watch(userProvider.notifier)
            .update((state) => User.fromJson(userRes.body));
      }
    } catch (e) {
      ErrorScreen(
        text: e.toString(),
      );
    }
  }
  // get user data

}
