import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/api_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core services - these should be available throughout the app
    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);
    
    // Add other core services here as needed
    // Get.lazyPut<StorageService>(() => StorageService(), fenix: true);
    // Get.lazyPut<NotificationService>(() => NotificationService(), fenix: true);
  }
} 