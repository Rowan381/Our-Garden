import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'new_logo_model.dart';
export 'new_logo_model.dart';

class NewLogoWidget extends StatefulWidget {
  const NewLogoWidget({super.key});

  @override
  State<NewLogoWidget> createState() => _NewLogoWidgetState();
}

class _NewLogoWidgetState extends State<NewLogoWidget> {
  late NewLogoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewLogoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/applogoswhite-24.png',
              width: 250.0,
              height: 250.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            'Sage',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.ibmPlexMono(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  fontSize: 28.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
            child: Text(
              'Ask Anything Plant Related',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.ibmPlexMono(
                      fontWeight: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
                    fontSize: 16.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
