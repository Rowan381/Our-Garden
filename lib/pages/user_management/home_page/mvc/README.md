# Home Page MVC Architecture

This folder contains the refactored home page using the Model-View-Controller (MVC) architectural pattern for better code organization, maintainability, and testability.

## 📁 Folder Structure

```
mvc/
├── models/                 # Data models and business logic models
│   ├── home_page_data_model.dart     # Core data model for home page state
│   └── home_page_ui_models.dart      # UI-specific models (TaskItem, UserLocation, etc.)
├── views/                  # UI components and views
│   ├── components/         # Reusable UI components
│   │   ├── home_page_header.dart     # Header with location and settings
│   │   ├── navigation_buttons.dart   # Ask Sage and Messages buttons
│   │   ├── marketplace_section.dart  # Marketplace products section
│   │   └── tasks_section.dart        # Today's tasks section
│   └── home_page_view.dart # Main view assembling all components
├── controllers/            # Business logic and state management
│   └── home_page_controller.dart     # Main controller handling all operations
└── index.dart             # Barrel file exporting all MVC components
```

## 🏗️ Architecture Overview

### Models

- **HomePageDataModel**: Contains all data state (users, tasks, orders, etc.)
- **UI Models**: Lightweight models for specific UI components (TaskItemModel, UserLocationModel, etc.)

### Views

- **HomePageView**: Main view that composes all UI components
- **Components**: Modular, reusable UI widgets:
  - `HomePageHeader`: Location display and settings button
  - `NavigationButtons`: Ask Sage and Messages navigation
  - `MarketplaceSection`: Product listings display
  - `TasksSection`: Today's tasks with checkboxes

### Controllers

- **HomePageController**: Centralized business logic handling:
  - Data initialization and loading
  - Navigation between screens
  - Task state management
  - API calls and Firebase operations

## 🔧 Usage

### Basic Integration

```dart
import 'mvc/index.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomePageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = HomePageController(context);
    _controller.initializePage();
  }

  @override
  Widget build(BuildContext context) {
    return HomePageView();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Using Individual Components

```dart
import 'mvc/views/components/tasks_section.dart';

TasksSection(
  tasks: controller.getTodaysTasks(),
  onTaskToggle: (taskId, value) async {
    await controller.handleTaskToggle(taskId, value);
  },
  onViewMoreTap: () => controller.navigateToTabs(),
)
```

## ✨ Benefits of This Architecture

1. **Separation of Concerns**: UI, business logic, and data are clearly separated
2. **Testability**: Controllers and models can be easily unit tested
3. **Reusability**: Components can be reused across different screens
4. **Maintainability**: Changes to business logic don't affect UI and vice versa
5. **Scalability**: Easy to add new features without affecting existing code

## 🚀 Integration with Existing Code

The MVC architecture is designed to work alongside the existing FlutterFlow code:

- `home_page_mvc_widget.dart`: New main widget using MVC pattern
- `home_page_model_mvc.dart`: Adapter model for FlutterFlow compatibility
- Original files remain unchanged for backward compatibility

## 📋 Component Responsibilities

### HomePageHeader

- Displays user location or "Location Not Enabled" message
- Provides location and settings navigation buttons
- Handles location permission dialogs

### NavigationButtons

- Renders Ask Sage and Messages navigation cards
- Handles tap events for navigation

### MarketplaceSection

- Shows marketplace header and content
- Displays location-based product filtering
- Provides fallback UI when location is disabled

### TasksSection

- Renders today's tasks with checkboxes
- Handles task completion toggle
- Provides scrollable task list with "View More" button

### HomePageController

- Manages all business logic and state
- Handles Firebase queries and updates
- Manages navigation between screens
- Processes task completions and user interactions

## 🧪 Testing Strategy

With this MVC structure, you can easily test:

```dart
// Test the controller
test('HomePageController initializes data correctly', () async {
  final controller = HomePageController(mockContext);
  await controller.initializePage();
  expect(controller.dataModel.userDoc, isNotNull);
});

// Test UI components
testWidgets('TasksSection renders tasks correctly', (tester) async {
  final tasks = [TaskItemModel(id: '1', title: 'Water plants', ...)];
  await tester.pumpWidget(TasksSection(tasks: tasks, ...));
  expect(find.text('Water plants'), findsOneWidget);
});
```

## 🔄 Migration Guide

To migrate from the original home page to MVC:

1. Import the MVC components: `import 'mvc/index.dart';`
2. Replace `HomePageWidget` with `HomePageMVCWidget`
3. Update navigation routes to point to the new widget
4. Test all functionality to ensure compatibility

The MVC version maintains all original functionality while providing better code organization and maintainability.
