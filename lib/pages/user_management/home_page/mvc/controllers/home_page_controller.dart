import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/user_management/location_services/location_services_widget.dart';
import '/pages/user_management/account_settings/account_settings_widget.dart';
import '/pages/marketplace/marketplace_explore_listings/marketplace_explore_listings_widget.dart';
import '../models/home_page_data_model.dart';
import '../models/home_page_ui_models.dart';
import '../repositories/home_page_repository.dart';
import '../services/task_service.dart';

/// Controller class handling all business logic for the home page
class HomePageController {
  final HomePageDataModel _dataModel;
  final BuildContext _context;

  HomePageController(this._context) : _dataModel = HomePageDataModel();

  HomePageDataModel get dataModel => _dataModel;

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
    _dataModel.checkboxValueMap1[task] = value;

    // Use TaskService to update task completion
    await TaskService.updateGardenTaskCompletion(task.reference, value);
  }

  Future<void> togglePlantTask(dynamic task, bool value) async {
    _dataModel.checkboxValueMap2[task] = value;

    // Use TaskService to update task completion
    await TaskService.updatePlantTaskCompletion(task.reference, value);
  }

  /// Navigation methods
  Future<void> navigateToLocationServices() async {
    final confirm = await _showLocationDialog();
    if (confirm) {
      await Navigator.of(_context).pushNamed(LocationServicesWidget.routeName);
    }
  }

  Future<void> navigateToAccountSettings() async {
    await launchURL('https://www.google.com');
    await Navigator.of(_context).pushNamed(AccountSettingsWidget.routeName);
  }

  Future<void> navigateToGpt() async {
    await Navigator.of(_context).pushNamed('/gpt');
  }

  Future<void> navigateToMessages() async {
    await Navigator.of(_context).pushNamed('/chat-2-main-new');
  }

  Future<void> navigateToMarketplace() async {
    await Navigator.of(_context)
        .pushNamed(MarketplaceExploreListingsWidget.routeName);
  }

  Future<void> navigateToTabs() async {
    if (Navigator.of(_context).canPop()) {
      Navigator.of(_context).pop();
    }
    await Navigator.of(_context).pushNamed('/tabs');
  }

  /// Helper methods
  Future<bool> _showLocationDialog() async {
    final hasLocation = _dataModel.userDoc?.location != null;

    return await showDialog<bool>(
          context: _context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text(hasLocation
                  ? 'Update Location Services'
                  : 'Location Services'),
              content: Text(hasLocation
                  ? 'Would you like to update your current location?'
                  : 'In order to search nearby, this app requires access to your current location.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext, false),
                  child: Text('Not Now'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext, true),
                  child: Text('Confirm'),
                ),
              ],
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
          description: '',
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
          description: '',
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
  }
}
