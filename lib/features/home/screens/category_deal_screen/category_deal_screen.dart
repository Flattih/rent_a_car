import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/common_widgets.dart/loader.dart';
import 'package:rent_a_car/features/home/screens/products/components/product_cart.dart';
import 'package:rent_a_car/features/home/services/home_services.dart';
import 'package:rent_a_car/models/Product.dart';

class CategoryDealScreen extends ConsumerStatefulWidget {
  static const String routeName = '/category-deals';
  final String category;
  const CategoryDealScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryDealScreenState();
}

class _CategoryDealScreenState extends ConsumerState<CategoryDealScreen> {
  List<Product> products = [];
  fetchAllProducts() async {
    products = await ref
        .read(homeServicesProvider)
        .fetchCategoryProduct(context, widget.category, ref);
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    fetchAllProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: products.isEmpty
            ? const Center(child: Text("No product to show"))
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Keep shopping for ${widget.category}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.3,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ProductCart(product: product)
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
