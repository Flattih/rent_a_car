import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:rent_a_car/all_cars.dart';
import 'package:rent_a_car/common_widgets.dart/error_handling.dart';
import 'package:rent_a_car/constants/utils.dart';
import 'package:rent_a_car/models/Product.dart';
import 'package:rent_a_car/providers/all_providers.dart';

final searchServicesProvider = Provider<SearchServices>((ref) {
  return SearchServices();
});

class SearchServices {
  Future<List<Product>> fetchSearchedProduct(
      String searchQuery, FutureProviderRef ref) async {
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': ref.watch(userProvider)!.token
      });
      httpErrorHandleSearch(
        response: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      ErrorScreen(
        text: e.toString(),
      );
    }
    return productList;
  }

  Future<List<Product>> searchProduct(String query, FutureProviderRef ref) {
    return fetchSearchedProduct(query, ref);
  }
}

final searchProvider =
    FutureProvider.family<List<Product>, String>((ref, String query) {
  return ref.watch(searchServicesProvider).searchProduct(query, ref);
});
