import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'index.dart';
import 'services/connectivity_service.dart';
import 'widgets/offline_banner.dart';
import 'utils/error_reporter.dart';

import 'backend/stripe/payment_manager.dart';

// Completer to track Firebase initialization
final Completer<bool> _firebaseInitializedCompleter = Completer<bool>();
// Global variable to track Firebase initialization status
bool _isFirebaseInitialized = false;
// Lock to prevent race conditions
bool _firebaseInitializationInProgress = false;
// Splash screen management
bool _splashScreenDismissed = false;

// Centralized splash screen dismissal
void _dismissSplashScreenSafely(String context) {
  if (_splashScreenDismissed) {
    return; // Already dismissed, no need to try again
  }

  try {
    final appStateNotifier = AppStateNotifier.instance;
    appStateNotifier.stopShowingSplashImage();
    _splashScreenDismissed = true;
    print('✅ Splash screen dismissed successfully ($context)');
  } catch (e) {
    print('❌ Error dismissing splash screen ($context): $e');
  }
}

// Function to safely wait for Firebase initialization
Future<bool> waitForFirebaseInitialization() async {
  if (_isFirebaseInitialized) return true;
  if (_firebaseInitializedCompleter.isCompleted) {
    return _firebaseInitializedCompleter.future;
  }
  return _firebaseInitializedCompleter.future;
}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // ABSOLUTELY FIRST

  // ✅ Enhanced global error handling for production
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('🔥 Flutter Error: ${details.exception}');
    print('🔥 Stack trace: ${details.stack}');
    
    // Report layout errors specifically
    if (details.exception.toString().contains('RenderBox was not laid out') ||
        details.exception.toString().contains('hasSize')) {
      ErrorReporter.reportUIError('Layout/Rendering', details.exception,
          userAction: 'Widget layout and rendering');
      print('🎨 Layout Error Detected - This may be caused by improper widget constraints');
    }

    // Send to analytics/crashlytics if available
    Zone.current.handleUncaughtError(
        details.exception, details.stack ?? StackTrace.current);
  };

  runZonedGuarded(() {
    final appState = FFAppState();
    runApp(
      ChangeNotifierProvider(
        create: (context) => appState,
        child: MyApp(),
      ),
    );
    _initializeServicesInBackground(appState); // Async init in background
  }, (error, stack) {
    print('🚨 Uncaught error in main zone: $error');
    print('🚨 Stack trace: $stack');

    // Show fallback UI for critical errors
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  'An unexpected error occurred',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Please restart the app. If the problem persists, contact support.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Exit the app gracefully - safer than recursive main() calls
                    SystemNavigator.pop();
                  },
                  child: Text('Exit App'),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  });
}

// Initialize non-critical services in background to avoid blocking UI thread
Future<void> _initializeServicesInBackground(FFAppState appState) async {
  // Try to force dismiss splash screen right away
  _dismissSplashScreenSafely('early background service initialization');

  try {
    await appState.initializePersistedState();
    print('✅ FFAppState initialized successfully');
  } catch (e) {
    print('❌ Error initializing FFAppState: $e');
  }

  try {
    final environmentValues = FFDevEnvironmentValues();
    await environmentValues.initialize();
    print('✅ Environment values initialized successfully');
  } catch (e) {
    print('❌ Error initializing environment values: $e');
  }

  // ✅ Enhanced Firebase initialization with proper error handling
  try {
    // Prevent multiple initialization attempts
    if (_firebaseInitializationInProgress) {
      print('⚠️ Firebase initialization already in progress, waiting...');
      return;
    }

    _firebaseInitializationInProgress = true;

    await initFirebase();
    _isFirebaseInitialized = true;

    // Complete the completer only once
    if (!_firebaseInitializedCompleter.isCompleted) {
      _firebaseInitializedCompleter.complete(true);
    }

    print('✅ Firebase initialized successfully');

    // Try to dismiss splash screen after Firebase initialization
    _dismissSplashScreenSafely('post-Firebase initialization');
  } catch (e) {
    print('🔥 Critical Firebase initialization error: $e');

    // Report the error using our error reporting system
    ErrorReporter.reportInitializationError('Firebase', e,
        userAction: 'App startup - Firebase initialization');

    // Mark Firebase as failed but allow app to continue
    _isFirebaseInitialized = false;

    // Complete the completer only once
    if (!_firebaseInitializedCompleter.isCompleted) {
      _firebaseInitializedCompleter.complete(false);
    }

    // Still try to dismiss splash screen even if Firebase fails
    _dismissSplashScreenSafely('Firebase initialization failure');
  } finally {
    _firebaseInitializationInProgress = false;
  }

  try {
    await initializeStripe();
    print('✅ Stripe initialized successfully');
  } catch (e) {
    print('❌ Error initializing Stripe: $e');
  }

  try {
    // Initialize connectivity service
    ConnectivityService.initialize();
    print('✅ Connectivity service initialized successfully');
  } catch (e) {
    print('❌ Error initializing connectivity service: $e');
  }

  // After all services are initialized, try to dismiss splash screen again
  _dismissSplashScreenSafely('all services initialization complete');

  // Final check to make sure Firebase completer is completed
  if (!_firebaseInitializedCompleter.isCompleted) {
    print('⚠️ Warning: Firebase completer not completed, completing now');
    _firebaseInitializedCompleter.complete(_isFirebaseInitialized);
  }
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  ThemeMode _themeMode = ThemeMode.system;

  // Using nullable late variables to indicate initialization state
  AppStateNotifier? _appStateNotifier;
  GoRouter? _router;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Stream subscriptions
  late Stream<BaseAuthUser> userStream;
  StreamSubscription? userStreamSub; // Add subscription for userStream
  StreamSubscription? authUserSub;
  StreamSubscription? fcmTokenSub;
  StreamSubscription? jwtTokenSub; // Add for JWT token stream
  Timer? _splashScreenFailsafeTimer;

  // Helper methods for route tracking
  String getRoute([RouteMatch? routeMatch]) {
    try {
      if (_router == null) return '/';

      final RouteMatch lastMatch =
          routeMatch ?? _router!.routerDelegate.currentConfiguration.last;
      final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
          ? lastMatch.matches
          : _router!.routerDelegate.currentConfiguration;
      return matchList.uri.toString();
    } catch (e) {
      print('Error getting route: $e');
      return '/';
    }
  }

  List<String> getRouteStack() {
    try {
      if (_router == null) return ['/'];

      return _router!.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e as RouteMatch?))
          .toList();
    } catch (e) {
      print('Error getting route stack: $e');
      return ['/'];
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize AppStateNotifier first
    _appStateNotifier = AppStateNotifier.instance;

    // Force dismiss splash screen immediately
    _forceDismissSplashScreen();

    // Initialize app state in a non-blocking way
    _initializeAppState();

    // Set a single failsafe timer instead of multiple
    _splashScreenFailsafeTimer = Timer(Duration(seconds: 10), () {
      _forceDismissSplashScreen();
      print('⚠️ Failsafe splash screen dismissal after 10 seconds');
    });
  }

  // Helper method to aggressively dismiss splash screen
  void _forceDismissSplashScreen() {
    _dismissSplashScreenSafely('force dismissal');
  }

  // Separate method to initialize app state without blocking UI
  Future<void> _initializeAppState() async {
    try {
      // Create router (simple operation, can be done synchronously)
      if (_router == null && _appStateNotifier != null) {
        _router = createRouter(_appStateNotifier!);
      }

      // Set up user stream in background
      _setupUserStream();

      // Mark as initialized and refresh UI
      setState(() {});

      // Dismiss splash screen after successful initialization
      _dismissSplashScreenSafely('app state initialization complete');
    } catch (e) {
      print('Error in basic app initialization: $e');
      // Create fallback router if needed
      if (_router == null) {
        _router = _createFallbackRouter();
        setState(() {});
      }

      // Always try to dismiss splash screen even if there was an error
      _dismissSplashScreenSafely('app state initialization failed');
    }
  }

  // Separate method to set up user stream without blocking UI
  void _setupUserStream() async {
    try {
      // First wait for Firebase to be initialized
      try {
        final isFirebaseReady = await waitForFirebaseInitialization();
        if (!isFirebaseReady) {
          print('⚠️ Firebase initialization failed, using empty user stream');
          userStream = Stream.empty();
          return;
        }
        print('✅ Firebase is ready for user stream setup');
      } catch (e) {
        print('🔥 Error waiting for Firebase initialization: $e');
        userStream = Stream.empty();
        return;
      }

      // ✅ Enhanced user stream with proper error handling
      userStream = editingFirebaseUserStream();

      // Cancel existing subscription if any
      userStreamSub?.cancel();

      userStreamSub = userStream.listen((user) {
        try {
          _appStateNotifier?.update(user);
        } catch (e) {
          print('🔥 Firestore user update error: $e');
          ErrorReporter.reportFirestoreError('user update', e,
              userAction: 'Updating user state from stream');
        }
      }, onError: (error) {
        print('🔥 User stream error: $error');
        if (error.toString().contains('PERMISSION_DENIED')) {
          print('🔒 Firestore permission denied - check security rules');
          ErrorReporter.reportFirestoreError('user stream', error,
              userAction: 'Listening to user document changes');
        } else {
          ErrorReporter.reportFirestoreError('user stream', error,
              userAction: 'Listening to user document changes');
        }
      });
    } catch (e) {
      print('🔥 Error setting up user stream: $e');
      userStream = Stream.empty();
    }

    // Setup auth user subscription with error handling
    try {
      final isFirebaseReady = await waitForFirebaseInitialization();
      if (isFirebaseReady) {
        authUserSub = authenticatedUserStream.listen((_) {}, onError: (error) {
          print('🔥 Auth user subscription error: $error');
          ErrorReporter.reportAuthError('authenticated user stream', error,
              userAction: 'Listening to authentication state changes');
        });
      } else {
        print('⚠️ Skipping auth user subscription setup - Firebase not ready');
      }
    } catch (e) {
      print('🔥 Error setting up auth user subscription: $e');
      ErrorReporter.reportAuthError('auth user subscription setup', e,
          userAction: 'Setting up authentication stream listener');
    }

    // Setup FCM token subscription with error handling
    try {
      final isFirebaseReady = await waitForFirebaseInitialization();
      if (isFirebaseReady) {
        fcmTokenSub = fcmTokenUserStream.listen((_) {}, onError: (error) {
          print('🔥 FCM token subscription error: $error');
          ErrorReporter.reportNetworkError('FCM token stream', error,
              userAction: 'Listening to FCM token updates');
        });
      } else {
        print('⚠️ Skipping FCM token subscription setup - Firebase not ready');
      }
    } catch (e) {
      print('🔥 Error setting up FCM token subscription: $e');
      ErrorReporter.reportNetworkError('FCM token subscription setup', e,
          userAction: 'Setting up FCM token stream listener');
    }

    // Setup JWT token stream with error handling
    try {
      final isFirebaseReady = await waitForFirebaseInitialization();
      if (isFirebaseReady) {
        jwtTokenSub?.cancel(); // Cancel existing subscription
        jwtTokenSub = jwtTokenStream.listen((_) {}, onError: (error) {
          print('🔥 JWT token stream error: $error');
          ErrorReporter.reportAuthError('JWT token stream', error,
              userAction: 'Listening to JWT token updates');
        });
      } else {
        print('⚠️ Skipping JWT token stream setup - Firebase not ready');
      }
    } catch (e) {
      print('🔥 Error setting up JWT token stream: $e');
      ErrorReporter.reportAuthError('JWT token stream setup', e,
          userAction: 'Setting up JWT token stream listener');
    }
  }

  // Create a fallback router for emergency cases
  GoRouter _createFallbackRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loading...'),
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Handle app lifecycle changes
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App lifecycle state changed to: $state');

    // Only try to dismiss splash screen on app resume if not already dismissed
    if (state == AppLifecycleState.resumed && !_splashScreenDismissed) {
      _dismissSplashScreenSafely('app lifecycle resumed');
    }
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    if (_router == null) {
      // Return a loading widget while the router is being initialized
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp.router(
      title: 'Our Garden',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false,
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // Cancel all stream subscriptions safely
    userStreamSub?.cancel();
    authUserSub?.cancel();
    fcmTokenSub?.cancel();
    jwtTokenSub?.cancel();
    _splashScreenFailsafeTimer?.cancel();

    super.dispose();
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({
    Key? key,
    this.initialPage,
    this.page,
    this.disableResizeToAvoidBottomInset = false,
  }) : super(key: key);

  final String? initialPage;
  final Widget? page;
  final bool disableResizeToAvoidBottomInset;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomePage';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': HomePageMVCWidget(),
      'MarketplaceExploreListings': MarketplaceExploreListingsWidget(),
      'GPT': GptWidget(),
      'Tabs': TabsWidget(),
      'user_profile': UserProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate icon size so that 5 icons + padding always fit
    final iconSize = max(
        ((screenWidth - 40) / 6 > 35.0 ? 35.0 : (screenWidth - 40) / 6), 20.0);

    // Safe widget rendering with error boundary
    Widget currentWidget;
    try {
      currentWidget = _currentPage != null ? _currentPage! : tabs[_currentPageName]!;
    } catch (e) {
      print('🔥 Error rendering tab $_currentPageName: $e');
      ErrorReporter.reportUIError('Navigation Tab ($_currentPageName)', e,
          userAction: 'Navigating to $_currentPageName tab');
      
      // Fallback widget for tab errors
      currentWidget = Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.orange),
              SizedBox(height: 16),
              Text(
                'Error Loading Tab',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'There was an issue loading $_currentPageName',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentPage = null;
                    _currentPageName = 'HomePage'; // Go back to home
                  });
                },
                child: Text('Go to Home'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: !widget.disableResizeToAvoidBottomInset,
      body: Column(
        children: [
          // Show offline banner at the top
          const OfflineBanner(),
          // Expand the main content to fill the rest of the space
          Expanded(
            child: currentWidget,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          final newPageName = tabs.keys.toList()[i];
          print('🎯 Navigating to tab: $newPageName');
          
          setState(() {
            _currentPage = null;
            _currentPageName = newPageName;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: FlutterFlowTheme.of(context).accent2,
        unselectedItemColor: FlutterFlowTheme.of(context).secondary,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.khome,
              size: iconSize,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kstore,
              size: iconSize,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.ksagelogo,
              size: iconSize,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kleaf,
              size: iconSize,
            ),
            label: '',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FFIcons.kaccountCircle,
              size: iconSize,
            ),
            label: '',
            tooltip: '',
          )
        ],
      ),
    );
  }
}
