import 'package:get/get.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/api_service.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/garden_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../data/repositories/garden_repository.dart';
import '../../../data/repositories/task_repository.dart';
import '../../../data/repositories/user_repository.dart';

class HomeController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final ApiService _apiService = Get.find<ApiService>();
  final ProductRepository _productRepository = Get.find<ProductRepository>();
  final GardenRepository _gardenRepository = Get.find<GardenRepository>();
  final TaskRepository _taskRepository = Get.find<TaskRepository>();
  final UserRepository _userRepository = Get.find<UserRepository>();

  // Reactive state variables
  final _isLoading = true.obs;
  final _isOnTour = false.obs;
  final _currentUser = Rxn<UserModel>();
  final _nearbyProducts = <ProductModel>[].obs;
  final _userGardens = <GardenModel>[].obs;
  final _userGardenTasks = <TaskModel>[].obs;
  final _userPlantTasks = <TaskModel>[].obs;
  final _pendingOrders = <dynamic>[].obs;
  final _hasLocation = false.obs;
  final _location = Rxn<Map<String, double>>();
  final _selectedGardenTasks = <String, bool>{}.obs;
  final _selectedPlantTasks = <String, bool>{}.obs;

  // Getters
  bool get isLoading => _isLoading.value;
  bool get isOnTour => _isOnTour.value;
  UserModel? get currentUser => _currentUser.value;
  List<ProductModel> get nearbyProducts => _nearbyProducts;
  List<GardenModel> get userGardens => _userGardens;
  List<TaskModel> get userGardenTasks => _userGardenTasks;
  List<TaskModel> get userPlantTasks => _userPlantTasks;
  List<dynamic> get pendingOrders => _pendingOrders;
  bool get hasLocation => _hasLocation.value;
  Map<String, double>? get location => _location.value;
  List<TaskModel> get selectedGardenTasks => _selectedGardenTasks.entries
      .where((e) => e.value)
      .map((e) => _userGardenTasks.firstWhere((task) => task.id == e.key))
      .toList();
  List<TaskModel> get selectedPlantTasks => _selectedPlantTasks.entries
      .where((e) => e.value)
      .map((e) => _userPlantTasks.firstWhere((task) => task.id == e.key))
      .toList();

  @override
  void onInit() {
    super.onInit();
    _initializeHome();
  }

  Future<void> _initializeHome() async {
    try {
      _isLoading.value = true;

      // Load current user
      await _loadCurrentUser();

      // Check if first time user
      if (currentUser?.isFirstSignIn == true) {
        _isOnTour.value = true;
        await _showTourDialog();
        await _markFirstSignInComplete();
      }

      // Load user data
      await Future.wait([
        _loadUserGardens(),
        _loadUserTasks(),
        _loadPendingOrders(),
        _loadNearbyProducts(),
      ]);

      // Reset daily tasks if needed
      await _resetDailyTasksIfNeeded();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load home data: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _loadCurrentUser() async {
    try {
      final user = await _userRepository.getCurrentUser();
      _currentUser.value = user;
      _hasLocation.value = user?.location != null;
      _location.value = user?.location;
    } catch (e) {
      print('Error loading current user: $e');
    }
  }

  Future<void> _loadUserGardens() async {
    try {
      final gardens = await _gardenRepository.getUserGardens();
      _userGardens.value = gardens;
    } catch (e) {
      print('Error loading user gardens: $e');
    }
  }

  Future<void> _loadUserTasks() async {
    try {
      final gardenTasks = await _taskRepository.getUserGardenTasks();
      final plantTasks = await _taskRepository.getUserPlantTasks();

      _userGardenTasks.value = gardenTasks;
      _userPlantTasks.value = plantTasks;

      // Initialize task selection maps
      for (final task in gardenTasks) {
        _selectedGardenTasks[task.id] = false;
      }
      for (final task in plantTasks) {
        _selectedPlantTasks[task.id] = false;
      }
    } catch (e) {
      print('Error loading user tasks: $e');
    }
  }

  Future<void> _loadPendingOrders() async {
    try {
      final orders = await _productRepository.getPendingOrders();
      _pendingOrders.value = orders;
    } catch (e) {
      print('Error loading pending orders: $e');
    }
  }

  Future<void> _loadNearbyProducts() async {
    try {
      List<ProductModel> products;

      if (hasLocation && location != null) {
        // Load products filtered by location
        products = await _productRepository.getNearbyProducts(
          latitude: location!['latitude']!,
          longitude: location!['longitude']!,
          radius: 1000.0, // 1km radius
          limit: 3,
        );
      } else {
        // Load all products if no location
        products = await _productRepository.getAllProducts(limit: 3);
      }

      _nearbyProducts.value = products;
    } catch (e) {
      print('Error loading nearby products: $e');
    }
  }

  Future<void> _resetDailyTasksIfNeeded() async {
    try {
      final lastReset = currentUser?.lastTaskResetDate;
      final now = DateTime.now();

      if (lastReset == null || !_isSameDay(lastReset, now)) {
        // Reset garden tasks
        await _taskRepository.resetDailyGardenTasks();

        // Reset plant tasks
        await _taskRepository.resetDailyPlantTasks();

        // Update user's last reset date
        await _userRepository.updateLastTaskResetDate(now);

        // Reload tasks
        await _loadUserTasks();
      }
    } catch (e) {
      print('Error resetting daily tasks: $e');
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<void> _showTourDialog() async {
    // This will be handled by the UI layer
    // For now, just mark as not on tour
    _isOnTour.value = false;
  }

  Future<void> _markFirstSignInComplete() async {
    try {
      await _userRepository.markFirstSignInComplete();
      _currentUser.value = _currentUser.value?.copyWith(isFirstSignIn: false);
    } catch (e) {
      print('Error marking first sign in complete: $e');
    }
  }

  // Task management
  void toggleGardenTaskSelection(String taskId) {
    _selectedGardenTasks[taskId] = !(_selectedGardenTasks[taskId] ?? false);
  }

  void togglePlantTaskSelection(String taskId) {
    _selectedPlantTasks[taskId] = !(_selectedPlantTasks[taskId] ?? false);
  }

  // Helper methods to check task selection state
  bool isGardenTaskSelected(String taskId) {
    return _selectedGardenTasks[taskId] ?? false;
  }

  bool isPlantTaskSelected(String taskId) {
    return _selectedPlantTasks[taskId] ?? false;
  }

  // Check if any tasks are selected
  bool hasSelectedGardenTasks() {
    return _selectedGardenTasks.values.any((selected) => selected == true);
  }

  bool hasSelectedPlantTasks() {
    return _selectedPlantTasks.values.any((selected) => selected == true);
  }

  Future<void> completeSelectedGardenTasks() async {
    try {
      final selectedTasks = selectedGardenTasks;
      if (selectedTasks.isEmpty) return;

      for (final task in selectedTasks) {
        await _taskRepository.completeGardenTask(task.id);
      }

      // Reload tasks
      await _loadUserTasks();

      Get.snackbar(
        'Success',
        '${selectedTasks.length} garden task(s) completed!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to complete tasks: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> completeSelectedPlantTasks() async {
    try {
      final selectedTasks = selectedPlantTasks;
      if (selectedTasks.isEmpty) return;

      for (final task in selectedTasks) {
        await _taskRepository.completePlantTask(task.id);
      }

      // Reload tasks
      await _loadUserTasks();

      Get.snackbar(
        'Success',
        '${selectedTasks.length} plant task(s) completed!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to complete tasks: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Payment processing
  Future<void> processPendingPayment(dynamic order) async {
    try {
      // This would integrate with your payment service
      // For now, just show a placeholder
      Get.snackbar(
        'Payment',
        'Payment processing would happen here',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Payment failed: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Navigation
  void navigateToGpt() {
    Get.toNamed('/gpt');
  }

  void navigateToMarketplace() {
    Get.toNamed('/marketplace');
  }

  void navigateToGarden() {
    Get.toNamed('/garden');
  }

  void navigateToChat() {
    Get.toNamed('/chat');
  }

  void navigateToProductDetails(ProductModel product) {
    Get.toNamed('/product-details', arguments: product);
  }

  void navigateToGardenDetails(GardenModel garden) {
    Get.toNamed('/garden-details', arguments: garden);
  }

  // Refresh data
  Future<void> refreshData() async {
    await _initializeHome();
  }

  // Tour management
  void startTour() {
    _isOnTour.value = true;
  }

  void endTour() {
    _isOnTour.value = false;
  }
}
