//Shared Preferences
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_a_car/features/add-product/services/add_product_service.dart';
import 'package:rent_a_car/features/auth/services/auth_service.dart';
import 'package:rent_a_car/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());
final userProvider = StateProvider<User?>(
    (ref) => User(id: "", name: "", email: "", password: "", token: ""));

final authServiceProvider =
    Provider<AuthService>((ref) => AuthService(ref: ref));
final addProudctServiceProvider = Provider<AddProductServices>((ref) {
  return AddProductServices();
});
