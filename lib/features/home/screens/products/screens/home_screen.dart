import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rent_a_car/constants/constants.dart';
import 'package:rent_a_car/features/home/screens/products/components/categories.dart';
import 'package:rent_a_car/features/home/screens/products/components/posts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Explore",
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const Text(
            "best Cars for you",
            style: TextStyle(fontSize: 18),
          ),
          const Categories()
              .animate()
              .fadeIn(delay: 300.ms, duration: 500.ms)
              .then()
              .slide(duration: 400.ms)
              .then(delay: 200.ms)
              .move(delay: 0.ms),
          const SizedBox(height: 15),
          const PostsScreen().animate().fade().scale()
        ],
      ),
    );
  }
}
