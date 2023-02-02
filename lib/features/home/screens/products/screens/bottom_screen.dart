import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/all_cars.dart';
import 'package:rent_a_car/features/add-product/screens/add_product_screen.dart';
import 'package:rent_a_car/features/home/screens/products/screens/home_screen.dart';
import 'package:rent_a_car/providers/all_providers.dart';

import '../../../../search/delegates/search_delegate.dart';

class BottomScreen extends ConsumerStatefulWidget {
  static const String routeName = "/bottom-bar";
  const BottomScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends ConsumerState<BottomScreen> {
  int _bottomNavIndex = 0;
  List screens = [const HomeScreen(), const AllCarsScreen()];

  @override
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
            leftCornerRadius: 20,
            icons: const [Icons.home, Icons.directions_car],
            activeIndex: _bottomNavIndex,
            gapLocation: GapLocation.end,
            inactiveColor: Colors.black26,
            height: MediaQuery.of(context).size.height / 12,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (index) {
              setState(() {
                _bottomNavIndex = index;
              });
            }),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer(
                builder: (context, ref, child) => Text(
                  "Good Days ${ref.watch(userProvider)!.name}",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search(ref));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: screens[_bottomNavIndex]);
  }
}
