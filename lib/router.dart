import 'package:flutter/material.dart';
import 'package:rent_a_car/all_cars.dart';
import 'package:rent_a_car/features/add-product/screens/add_product_screen.dart';
import 'package:rent_a_car/features/auth/screens/sign_in_screen.dart';
import 'package:rent_a_car/features/auth/screens/sign_up_screen.dart';
import 'package:rent_a_car/features/home/screens/category_deal_screen/category_deal_screen.dart';
import 'package:rent_a_car/features/home/screens/products/screens/bottom_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const SignInScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const SignUpScreen(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CategoryDealScreen(category: category),
      );
    case BottomScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const BottomScreen(),
      );
    case AllCarsScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AllCarsScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProductScreen(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) =>
            ErrorScreen(text: routeSettings.arguments.toString()),
      );
  }
}
