import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/common_widgets.dart/error_handling.dart';
import 'package:rent_a_car/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:rent_a_car/providers/all_providers.dart';

import '../../../models/Product.dart';

final homeServicesProvider = Provider<HomeServices>((ref) {
  return HomeServices();
});

class HomeServices {
  Future<List<Product>> fetchAllProducts(
      BuildContext context, WidgetRef ref) async {
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': ref.watch(userProvider)!.token
      });

      httpErrorHandle(
        response: res,
        context: context,
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
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchCategoryProduct(
      BuildContext context, String category, WidgetRef ref) async {
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': ref.watch(userProvider)!.token
      });

      httpErrorHandle(
        response: res,
        context: context,
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
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
    BuildContext context,
    Product product,
    WidgetRef ref,
    VoidCallback onSuccess,
  ) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': ref.watch(userProvider)!.token,
        },
        body: jsonEncode(
            {'id': ref.watch(userProvider)!.id, 'productId': product.id}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Arabanı başarıyla sildin!");
          onSuccess();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
