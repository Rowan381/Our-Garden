import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/backend/backend.dart';
import 'mvc/index.dart';

/// Main HomePage widget using MVC architecture
/// This replaces the original home_page_widget.dart with a cleaner, modular structure
class HomePageMVCWidget extends StatefulWidget {
  const HomePageMVCWidget({
    super.key,
    this.onTour = false,
  });

  final bool onTour;

  // Use SAME route names as original for seamless replacement
  static String get routeName => 'HomePage';
  static String get routePath => '/homePage';

  State<HomePageMVCWidget> createState() => _HomePageMVCWidgetState();
}

class _HomePageMVCWidgetState extends State<HomePageMVCWidget> {
  late HomePageController _controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _controller = HomePageController(context);
    _initializePage();

    // Handle onTour parameter if needed for future tour functionality
    if (widget.onTour) {
      // TODO: Initialize tour functionality when needed
      debugPrint('Tour mode enabled for home page');
    }
  }

  Future<void> _initializePage() async {
    try {
      await _controller.initializePage();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error loading page: $e';
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
    return Builder(
      builder: (context) => StreamBuilder<List<ProductRecord>>(
        stream: queryProductRecord(),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: PopScope(
              canPop: false,
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                body: SafeArea(
                  child: _buildBody(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: SizedBox(
          width: 50.0,
          height: 50.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.0,
              color: FlutterFlowTheme.of(context).error,
            ),
            SizedBox(height: 16.0),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    color: FlutterFlowTheme.of(context).error,
                  ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                _initializePage();
              },
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Use the MVC HomePageView
    return HomePageView();
  }
}
