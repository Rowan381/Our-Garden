import 'package:get/get.dart';
import '../../core/services/api_service.dart';
import '../../data/repositories/product_repository.dart';
import '../../data/repositories/garden_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/user_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Core services
    // AuthService is initialized in main() before the app starts
    Get.lazyPut<ApiService>(() => ApiService(), fenix: true);

    // Register repositories
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<GardenRepository>(() => GardenRepository());
    Get.lazyPut<TaskRepository>(() => TaskRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());

    // Add other core services here as needed
    // Get.lazyPut<StorageService>(() => StorageService(), fenix: true);
    // Get.lazyPut<NotificationService>(() => NotificationService(), fenix: true);
  }
}
