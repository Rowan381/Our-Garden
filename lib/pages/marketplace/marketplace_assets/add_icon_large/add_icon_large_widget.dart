import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_icon_large_model.dart';
export 'add_icon_large_model.dart';

class AddIconLargeWidget extends StatefulWidget {
  const AddIconLargeWidget({
    super.key,
    required this.notMyListing,
  });

  final bool? notMyListing;

  @override
  State<AddIconLargeWidget> createState() => _AddIconLargeWidgetState();
}

class _AddIconLargeWidgetState extends State<AddIconLargeWidget> {
  late AddIconLargeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddIconLargeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.notMyListing ?? true,
      child: Align(
        alignment: AlignmentDirectional(0.87, 0.92),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (!_model.showText) {
              _model.containerWidth = 150;
              safeSetState(() {});
              await Future.delayed(const Duration(milliseconds: 300));
              _model.showText = !_model.showText;
              safeSetState(() {});
            } else {
              _model.showText = !_model.showText;
              safeSetState(() {});
              _model.containerWidth = 40;
              safeSetState(() {});
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
            width: _model.containerWidth.toDouble(),
            height: 30.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_model.showText)
                    AnimatedDefaultTextStyle(
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                      child: Text(
                        'Add to Basket ',
                      ),
                    ),
                  FaIcon(
                    FontAwesomeIcons.shoppingBasket,
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    size: 18.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
