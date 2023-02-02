import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/common_widgets.dart/loader.dart';
import 'package:rent_a_car/constants/colors.dart';

import 'package:rent_a_car/features/home/services/home_services.dart';
import 'package:rent_a_car/models/Product.dart';
import 'package:rent_a_car/providers/all_providers.dart';

class AllCarsScreen extends ConsumerStatefulWidget {
  static const String routeName = "/all-cars";
  const AllCarsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllCarsScreenState();
}

class _AllCarsScreenState extends ConsumerState<AllCarsScreen> {
  List<Product>? products;
  fetchAllProducts() async {
    products =
        await ref.read(homeServicesProvider).fetchAllProducts(context, ref);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    ref.read(homeServicesProvider).deleteProduct(context, product, ref, () {
      products!.removeAt(index);
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    fetchAllProducts();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Center(child: Text("No product to show"))
        : SafeArea(
            child: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: products!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.36,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = products![index];
                        return Container(
                          decoration: BoxDecoration(
                              color: AppColors.textColor,
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 24),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  product.images[0],
                                  height: 180,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "${product.name} ${product.price}\$",
                                            style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        if (product.userId ==
                                            ref.read(userProvider)!.id)
                                          IconButton(
                                              onPressed: () {
                                                deleteProduct(product, index);
                                              },
                                              icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .scale()
                            .move(duration: const Duration(seconds: 2))
                            .fade(duration: const Duration(seconds: 1));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class ErrorScreen extends StatelessWidget {
  final String text;
  const ErrorScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
