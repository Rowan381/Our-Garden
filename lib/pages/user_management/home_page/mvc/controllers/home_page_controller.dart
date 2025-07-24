import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/user_management/location_services/location_services_widget.dart';
import '/pages/user_management/account_settings/account_settings_widget.dart';
import '/pages/marketplace/marketplace_explore_listings/marketplace_explore_listings_widget.dart';
import '/pages/gpt/gpt/gpt_widget.dart';
import '/pages/chat_groupwbubbles/chat_2_main_new/chat2_main_new_widget.dart';
import '/pages/garden_management/tabs/tabs_widget.dart';
import '../models/home_page_data_model.dart';
import '../models/home_page_ui_models.dart';
import '../repositories/home_page_repository.dart';
import '../services/task_service.dart';

/// Controller class handling all business logic for the home page
class HomePageController {
  final HomePageDataModel _dataModel;
  BuildContext? _context;

  HomePageController(BuildContext context) : _dataModel = HomePageDataModel() {
    _context = context;
  }

  HomePageDataModel get dataModel => _dataModel;

  /// Update context reference - should be called from view's build method
  void updateContext(BuildContext context) {
    _context = context;
  }

  /// Safe context access with validation
  BuildContext? get currentContext => _context;
  bool get hasValidContext => _context != null && _context!.mounted;

  /// Initialize the home page data using repository pattern
  Future<void> initializePage() async {
    try {
      // Use repository to get all initialization data
      final initData = await HomePageRepository.initializeHomePageData();

      // Update data model with fetched data
      _dataModel.userDoc = initData.user;
      _dataModel.userGardenTasks = initData.gardenTasks;
      _dataModel.userPlantTasks = initData.plantTasks;
      _dataModel.pendingOrder = initData.pendingOrder;
      _dataModel.sellerAccountLoad = initData.sellerInfo;

      // Initialize checkbox states
      _initializeCheckboxStates();
    } catch (e) {
      debugPrint('Error initializing home page: $e');

      // Show user-friendly error feedback only if context is valid
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
            content: Text('Failed to load homepage data. Please try again.'),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => initializePage(),
            ),
          ),
        );
      }
      rethrow;
    }
  }

  /// Initialize checkbox states for tasks
  void _initializeCheckboxStates() {
    // Initialize garden task checkboxes
    if (_dataModel.userGardenTasks != null) {
      for (final task in _dataModel.userGardenTasks!) {
        _dataModel.checkboxValueMap1[task] = task.completedToday;
      }
    }

    // Initialize plant task checkboxes
    if (_dataModel.userPlantTasks != null) {
      for (final task in _dataModel.userPlantTasks!) {
        _dataModel.checkboxValueMap2[task] = task.completedToday;
      }
    }
  }

  /// Handle task checkbox changes
  Future<void> toggleGardenTask(dynamic task, bool value) async {
    try {
      _dataModel.checkboxValueMap1[task] = value;

      // Use TaskService to update task completion
      await TaskService.updateGardenTaskCompletion(task.reference, value);
    } catch (e) {
      // Revert the checkbox state on error
      _dataModel.checkboxValueMap1[task] = !value;

      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content: Text('Failed to update garden task: ${e.toString()}')),
        );
      }
      rethrow;
    }
  }

  Future<void> togglePlantTask(dynamic task, bool value) async {
    try {
      _dataModel.checkboxValueMap2[task] = value;

      // Use TaskService to update task completion
      await TaskService.updatePlantTaskCompletion(task.reference, value);
    } catch (e) {
      // Revert the checkbox state on error
      _dataModel.checkboxValueMap2[task] = !value;

      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content: Text('Failed to update plant task: ${e.toString()}')),
        );
      }
      rethrow;
    }
  }

  /// Navigation methods
  Future<void> navigateToLocationServices() async {
    if (!hasValidContext) return;

    try {
      final confirm = await _showLocationDialog();
      if (confirm && hasValidContext) {
        _context!.pushNamed(LocationServicesWidget.routeName);
      }
    } catch (e) {
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to navigate to location services: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> navigateToAccountSettings() async {
    if (!hasValidContext) return;

    try {
      _context!.pushNamed(AccountSettingsWidget.routeName);
    } catch (e) {
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to navigate to account settings: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> navigateToGpt() async {
    if (!hasValidContext) return;

    try {
      debugPrint('Navigating to GPT with route name: ${GptWidget.routeName}');
      _context!.pushNamed(GptWidget.routeName);
    } catch (e) {
      debugPrint(
          'Navigation error - Expected: ${GptWidget.routeName}, Error: ${e.toString()}');
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(content: Text('Failed to navigate to GPT: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> navigateToMessages() async {
    if (!hasValidContext) return;

    try {
      debugPrint(
          'Navigating to Messages with route name: ${Chat2MainNewWidget.routeName}');
      _context!.pushNamed(Chat2MainNewWidget.routeName);
    } catch (e) {
      debugPrint(
          'Navigation error - Expected: ${Chat2MainNewWidget.routeName}, Error: ${e.toString()}');
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content: Text('Failed to navigate to messages: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> navigateToMarketplace() async {
    if (!hasValidContext) return;

    try {
      _context!.pushNamed(MarketplaceExploreListingsWidget.routeName);
    } catch (e) {
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to navigate to marketplace: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> navigateToTabs() async {
    if (!hasValidContext) return;

    try {
      if (_context!.canPop()) {
        _context!.pop();
      }
      // TODO: Replace with static route name when available (e.g., TabsWidget.routeName)
      _context!.pushNamed(TabsWidget.routeName);
    } catch (e) {
      if (hasValidContext) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(
              content: Text('Failed to navigate to tabs: ${e.toString()}')),
        );
      }
    }
  }

  /// Helper methods
  Future<bool> _showLocationDialog() async {
    if (!hasValidContext) return false;

    final hasLocation = _dataModel.userDoc?.location != null;

    return await showDialog<bool>(
          context: _context!,
          barrierDismissible: false,
          builder: (alertDialogContext) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Text(
                hasLocation ? 'Update Location Services' : 'Location Services',
                style: Theme.of(_context!).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              content: Text(
                hasLocation
                    ? 'Would you like to update your current location?'
                    : 'In order to search nearby, this app requires access to your current location.',
                style: Theme.of(_context!).textTheme.bodyMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext, false),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(_context!)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                  ),
                  child: const Text('Not Now'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(alertDialogContext, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(_context!).primaryColor,
                    foregroundColor: Theme.of(_context!).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Confirm'),
                ),
              ],
              actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            );
          },
        ) ??
        false;
  }

  /// Get user location model
  UserLocationModel getUserLocation() {
    final userLocation = _dataModel.userDoc?.location;
    final city = _dataModel.userDoc?.city;

    return UserLocationModel(
      city: city,
      coordinates: userLocation != null
          ? Coordinates(userLocation.latitude, userLocation.longitude)
          : null,
    );
  }

  /// Get today's tasks as UI models
  List<TaskItemModel> getTodaysTasks() {
    final tasks = <TaskItemModel>[];

    // Add garden tasks
    if (_dataModel.userGardenTasks != null) {
      for (final task in _dataModel.userGardenTasks!) {
        tasks.add(TaskItemModel(
          id: task.reference.id,
          title: task.objective,
          description: task.objective.isNotEmpty
              ? 'Garden task - ${task.objective}'
              : 'No description available',
          isCompleted: task.completedToday,
          type: 'garden',
        ));
      }
    }

    // Add plant tasks
    if (_dataModel.userPlantTasks != null) {
      for (final task in _dataModel.userPlantTasks!) {
        tasks.add(TaskItemModel(
          id: task.reference.id,
          title: task.objective,
          description: task.objective.isNotEmpty
              ? 'Plant task - ${task.objective}'
              : 'No description available',
          isCompleted: task.completedToday,
          type: 'plant',
        ));
      }
    }

    return tasks;
  }

  /// Clean up resources
  void dispose() {
    _dataModel.clearData();
    _context = null; // Clear context reference to prevent memory leaks
  }
}
