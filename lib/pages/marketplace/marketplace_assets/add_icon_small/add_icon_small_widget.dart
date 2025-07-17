import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_icon_small_model.dart';
export 'add_icon_small_model.dart';

class AddIconSmallWidget extends StatefulWidget {
  const AddIconSmallWidget({
    super.key,
    required this.notMyListing,
  });

  final bool? notMyListing;

  @override
  State<AddIconSmallWidget> createState() => _AddIconSmallWidgetState();
}

class _AddIconSmallWidgetState extends State<AddIconSmallWidget> {
  late AddIconSmallModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddIconSmallModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.notMyListing! && !_model.showAddedCart)
          Align(
            alignment: AlignmentDirectional(1.0, 1.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                _model.showAddedCart = true;
                safeSetState(() {});
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                width: 35.0,
                height: 25.0,
                decoration: BoxDecoration(
                  color: colorFromCssString(
                    _model.containerColor,
                    defaultColor: Color(0xFF00ADEA),
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.shoppingBasket,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 14.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (widget.notMyListing! && _model.showAddedCart)
          Align(
            alignment: AlignmentDirectional(1.0, 1.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              height: 25.0,
              decoration: BoxDecoration(
                color: colorFromCssString(
                  _model.containerColor,
                  defaultColor: Color(0xFF00ADEA),
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                    child: AnimatedDefaultTextStyle(
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
                        'Added to Basket ',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                    child: Icon(
                      Icons.check_sharp,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
