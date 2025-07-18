import 'package:editing/main.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../bindings/initial_binding.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/auth/views/auth_view.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/home/views/home_view.dart';
import '../../core/services/auth_service.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.auth;

  static final routes = [
    GetPage(
      name: Routes.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.marketplace,
      page: () => const MarketplaceView(),
      binding: InitialBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.garden,
      page: () => const GardenView(),
      binding: InitialBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.chat,
      page: () => const ChatView(),
      binding: InitialBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.gpt,
      page: () => const GptView(),
      binding: InitialBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

// Route names
abstract class Routes {
  Routes._();
  static const auth = '/auth';
  static const home = '/home';
  static const marketplace = '/marketplace';
  static const garden = '/garden';
  static const chat = '/chat';
  static const gpt = '/gpt';
}

// Auth middleware to protect routes
class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    try {
      final authService = Get.find<AuthService>();

      // If user is not logged in and trying to access protected route
      if (!authService.isLoggedIn && route != Routes.auth) {
        return const RouteSettings(name: Routes.auth);
      }

      // If user is logged in and trying to access auth page
      if (authService.isLoggedIn && route == Routes.auth) {
        return const RouteSettings(name: Routes.home);
      }

      return null;
    } catch (e) {
      // If AuthService is not yet initialized, default to auth route
      print('AuthMiddleware error: $e');
      if (route != Routes.auth) {
        return const RouteSettings(name: Routes.auth);
      }
      return null;
    }
  }
}
