import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/home_page_ui_models.dart';

/// Header component showing location and settings
class HomePageHeader extends StatelessWidget {
  final UserLocationModel userLocation;
  final VoidCallback onLocationTap;
  final VoidCallback onSettingsTap;

  const HomePageHeader({
    super.key,
    required this.userLocation,
    required this.onLocationTap,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(-0.03, -0.99),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 75.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryText,
              width: 2.0,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: _buildLocationSection(context),
              ),
              Align(
                alignment: AlignmentDirectional(1.0, 0.0),
                child: FlutterFlowIconButton(
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.settings_outlined,
                    color: FlutterFlowTheme.of(context).secondary,
                    size: 40.0,
                  ),
                  onPressed: onSettingsTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    if (userLocation.hasLocation) {
      return Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.location_on_outlined,
                color: FlutterFlowTheme.of(context).secondary,
                size: 40.0,
              ),
              onPressed: onLocationTap,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 240.0,
              height: 85.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-0.01, 0.42),
                        child: Text(
                          userLocation.displayLocation,
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 25.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Align(
            alignment: AlignmentDirectional(-1.0, 0.0),
            child: FlutterFlowIconButton(
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.location_off_outlined,
                color: FlutterFlowTheme.of(context).secondary,
                size: 35.0,
              ),
              onPressed: onLocationTap,
            ),
          ),
          Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: 240.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 6.0),
                          child: Text(
                            'Location Not Enabled',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
