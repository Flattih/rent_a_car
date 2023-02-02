import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/all_cars.dart';
import 'package:rent_a_car/common_widgets.dart/loader.dart';
import 'package:rent_a_car/features/add-product/screens/add_product_screen.dart';
import 'package:rent_a_car/features/search/services/search_services.dart';

class Search extends SearchDelegate {
  final WidgetRef ref;

  Search(this.ref);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return ref.watch(searchProvider(query)).when(
          data: (products) => ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        product.images[0],
                      ),
                    ),
                    title: Text(product.name),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ErrorScreen(text: "SELAM!");
                        },
                      ));
                    },
                  ),
                ],
              );
            },
          ),
          error: (error, stackTrace) => ErrorScreen(text: error.toString()),
          loading: () => const Loader(),
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchProvider(query)).when(
          data: (products) => Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.search,
                    size: 100,
                  ),
                  Text(
                    "Arama yapmak için arama ikonuna basınız.",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  )
                ]),
          ),
          error: (error, stackTrace) => ErrorScreen(text: error.toString()),
          loading: () => Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.search,
                  size: 100,
                ),
                Text(
                  "Arama yapmak için arama ikonuna basınız.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
  }
}
