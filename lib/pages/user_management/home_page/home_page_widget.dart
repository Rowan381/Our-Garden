// Compatibility alias for HomePageWidget
// This ensures existing imports continue to work while using the new MVC architecture
import 'home_page_mvc_widget.dart';
export 'home_page_mvc_widget.dart';

// Create alias so existing code can still use HomePageWidget
class HomePageWidget extends HomePageMVCWidget {
  const HomePageWidget({super.key, super.onTour});

  // Expose static properties from the underlying MVC widget
  static String get routeName => HomePageMVCWidget.routeName;
  static String get routePath => HomePageMVCWidget.routePath;
}
