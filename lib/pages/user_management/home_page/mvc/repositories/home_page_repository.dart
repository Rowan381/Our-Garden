import '/backend/backend.dart';
import '../services/task_service.dart';
import '../services/user_service.dart';
import '../services/marketplace_service.dart';

/// Repository pattern implementation for home page data access
/// This class coordinates between different services and provides a unified data access layer
class HomePageRepository {
  /// Get all data needed for home page initialization
  static Future<HomePageInitData> initializeHomePageData() async {
    try {
      // Fetch all required data in parallel for better performance
      final results = await Future.wait([
        UserService.getCurrentUser(),
        TaskService.getUserGardenTasks(),
        TaskService.getUserPlantTasks(),
        MarketplaceService.getPendingOrder(),
      ]);

      final user = results[0] as UsersRecord?;
      final gardenTasks = results[1] as List<GardenTasksRecord>;
      final plantTasks = results[2] as List<PlantTasksRecord>;
      final pendingOrder = results[3] as OrdersRecord?;

      // Get seller info if there's a pending order
      UsersRecord? sellerInfo;
      if (pendingOrder?.seller != null) {
        sellerInfo =
            await MarketplaceService.getSellerInfo(pendingOrder!.seller!);
      }

      return HomePageInitData(
        user: user,
        gardenTasks: gardenTasks,
        plantTasks: plantTasks,
        pendingOrder: pendingOrder,
        sellerInfo: sellerInfo,
      );
    } catch (e) {
      print('Error initializing home page data: $e');
      rethrow;
    }
  }

  /// Update task completion status
  static Future<bool> updateTaskCompletion(
      String taskId, String taskType, bool isCompleted,
      {List<GardenTasksRecord>? gardenTasks,
      List<PlantTasksRecord>? plantTasks}) async {
    try {
      if (taskType == 'garden' && gardenTasks != null) {
        final task = gardenTasks
            .where((task) => task.reference.id == taskId)
            .firstOrNull;
        if (task != null) {
          return await TaskService.updateGardenTaskCompletion(
              task, isCompleted);
        }
      } else if (taskType == 'plant' && plantTasks != null) {
        final task =
            plantTasks.where((task) => task.reference.id == taskId).firstOrNull;
        if (task != null) {
          return await TaskService.updatePlantTaskCompletion(task, isCompleted);
        }
      }
      return false;
    } catch (e) {
      print('Error updating task completion: $e');
      return false;
    }
  }

  /// Refresh user data
  static Future<UsersRecord?> refreshUserData() async {
    return await UserService.getCurrentUser();
  }

  /// Get products for marketplace section
  static Future<List<ProductRecord>> getMarketplaceProducts(UsersRecord? user,
      {double maxDistance = 1000.0}) async {
    try {
      // This would typically query products from the database
      // For now, return empty list as placeholder
      final allProducts = await queryProductRecordOnce();

      if (user?.location != null) {
        return MarketplaceService.getProductsNearLocation(
          allProducts,
          user!.location,
          maxDistance: maxDistance,
        );
      }

      return [];
    } catch (e) {
      print('Error fetching marketplace products: $e');
      return [];
    }
  }
}

/// Data class to hold all initialization data
class HomePageInitData {
  final UsersRecord? user;
  final List<GardenTasksRecord> gardenTasks;
  final List<PlantTasksRecord> plantTasks;
  final OrdersRecord? pendingOrder;
  final UsersRecord? sellerInfo;

  const HomePageInitData({
    this.user,
    required this.gardenTasks,
    required this.plantTasks,
    this.pendingOrder,
    this.sellerInfo,
  });
}
