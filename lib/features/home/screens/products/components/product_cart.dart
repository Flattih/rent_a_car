import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/constants/colors.dart';
import 'package:rent_a_car/features/home/services/home_services.dart';
import 'package:rent_a_car/models/Product.dart';
import 'package:rent_a_car/providers/all_providers.dart';

class ProductCart extends ConsumerWidget {
  const ProductCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.textColor, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
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
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "${product.name} ${product.price}\$",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (ref.read(userProvider)!.id == product.userId)
                      IconButton(
                        onPressed: () {
                          ref
                              .read(homeServicesProvider)
                              .deleteProduct(context, product, ref, () {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
