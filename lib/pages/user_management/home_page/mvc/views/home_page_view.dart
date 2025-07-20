import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '../controllers/home_page_controller.dart';
import 'components/home_page_header.dart';
import 'components/navigation_buttons.dart';
import 'components/marketplace_section.dart';
import 'components/tasks_section.dart';

/// Main view for the home page using MVC pattern
class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late HomePageController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = HomePageController(context);
    _initializePage();
  }

  Future<void> _initializePage() async {
    await _controller.initializePage();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      );
    }

    final userLocation = _controller.getUserLocation();
    final todaysTasks = _controller.getTodaysTasks();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.88,
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Header with location and settings
                      HomePageHeader(
                        userLocation: userLocation,
                        onLocationTap: _controller.navigateToLocationServices,
                        onSettingsTap: _controller.navigateToAccountSettings,
                      ),

                      // Navigation buttons (Ask Sage & Messages)
                      NavigationButtons(
                        onAskSageTap: _controller.navigateToGpt,
                        onMessagesTap: _controller.navigateToMessages,
                      ),

                      // Marketplace section
                      MarketplaceSection(
                        hasLocation: userLocation.hasLocation,
                        onMarketplaceTap: _controller.navigateToMarketplace,
                      ),

                      // Tasks section
                      TasksSection(
                        tasks: todaysTasks,
                        onTaskToggle: _handleTaskToggle,
                        onViewMoreTap: _controller.navigateToTabs,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleTaskToggle(String taskId, bool value) async {
    // Find the task and toggle it
    final gardenTasks = _controller.dataModel.userGardenTasks;
    final plantTasks = _controller.dataModel.userPlantTasks;

    // Check garden tasks
    if (gardenTasks != null) {
      final gardenTask =
          gardenTasks.where((task) => task.reference.id == taskId).firstOrNull;
      if (gardenTask != null) {
        await _controller.toggleGardenTask(gardenTask, value);
        return;
      }
    }

    // Check plant tasks
    if (plantTasks != null) {
      final plantTask =
          plantTasks.where((task) => task.reference.id == taskId).firstOrNull;
      if (plantTask != null) {
        await _controller.togglePlantTask(plantTask, value);
        return;
      }
    }
  }
}
