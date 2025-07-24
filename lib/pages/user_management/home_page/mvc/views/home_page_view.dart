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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = HomePageController(context);
    _initializePage();
  }

  Future<void> _initializePage() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      await _controller.initializePage();
    } catch (e) {
      debugPrint('Homepage initialization failed: $e');
      if (mounted) {
        setState(() {
          _errorMessage =
              'Failed to load homepage data. Please check your connection and try again.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Update controller context for each build
    _controller.updateContext(context);

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

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.0,
                  color: FlutterFlowTheme.of(context).error,
                ),
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                        color: FlutterFlowTheme.of(context).error,
                      ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _initializePage,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    foregroundColor: FlutterFlowTheme.of(context).info,
                  ),
                ),
              ],
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
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
    try {
      // Find the task and toggle it
      final gardenTasks = _controller.dataModel.userGardenTasks;
      final plantTasks = _controller.dataModel.userPlantTasks;

      // Check garden tasks
      if (gardenTasks != null) {
        final gardenTask = gardenTasks
            .where((task) => task.reference.id == taskId)
            .firstOrNull;
        if (gardenTask != null) {
          await _controller.toggleGardenTask(gardenTask, value);
          setState(() {}); // Refresh UI to reflect the change
          return;
        }
      }

      // Check plant tasks
      if (plantTasks != null) {
        final plantTask =
            plantTasks.where((task) => task.reference.id == taskId).firstOrNull;
        if (plantTask != null) {
          await _controller.togglePlantTask(plantTask, value);
          setState(() {}); // Refresh UI to reflect the change
          return;
        }
      }

      // If we get here, task was not found
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Task not found. Please refresh the page.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      // Error handling is managed in controller, just refresh UI
      if (mounted) {
        setState(() {}); // Refresh UI to reflect any state changes/rollbacks
      }
    }
  }
}
