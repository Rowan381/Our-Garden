import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:google_fonts/google_fonts.dart';

/// Navigation buttons component for Ask Sage and Messages
class NavigationButtons extends StatelessWidget {
  final VoidCallback onAskSageTap;
  final VoidCallback onMessagesTap;

  const NavigationButtons({
    super.key,
    required this.onAskSageTap,
    required this.onMessagesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, -0.62),
      child: Container(
        width: 359.0,
        height: 140.0,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        child: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavigationCard(
                  context: context,
                  title: 'Ask Sage',
                  icon: Icons
                      .psychology, // Using a built-in icon instead of FFIcons
                  color: Color(0xFF57A773),
                  onTap: onAskSageTap,
                ),
                _buildNavigationCard(
                  context: context,
                  title: 'Messages',
                  icon: Icons.chat_bubble_outline_rounded,
                  color: Color(0xFF157145),
                  onTap: onMessagesTap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(1.0, 0.0, 1.0, 0.0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          width: 165.0,
          height: 125.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: color,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: title == 'Ask Sage' ? 60.0 : 70.0,
              ),
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Text(
                    title,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.readexPro(
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 24.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
