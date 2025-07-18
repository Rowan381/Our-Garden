import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/garden_repository.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../data/repositories/user_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Register repositories
    Get.lazyPut<ProductRepository>(() => ProductRepository());
    Get.lazyPut<GardenRepository>(() => GardenRepository());
    Get.lazyPut<TaskRepository>(() => TaskRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    
    // Register controller
    Get.lazyPut<HomeController>(() => HomeController());
  }
} 