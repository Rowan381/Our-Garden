import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../core/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Register services if not already registered
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    
    // Register the auth controller
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
} 