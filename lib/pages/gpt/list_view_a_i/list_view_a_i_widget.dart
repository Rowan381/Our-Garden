import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'list_view_a_i_model.dart';
export 'list_view_a_i_model.dart';

class ListViewAIWidget extends StatefulWidget {
  const ListViewAIWidget({
    super.key,
    required this.savedChatObjectJ,
  });

  final AIsavedChatsRecord? savedChatObjectJ;

  @override
  State<ListViewAIWidget> createState() => _ListViewAIWidgetState();
}

class _ListViewAIWidgetState extends State<ListViewAIWidget> {
  late ListViewAIModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListViewAIModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 273.0,
          height: 24.0,
          decoration: BoxDecoration(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  valueOrDefault<String>(
                    widget.savedChatObjectJ?.title,
                    'Null',
                  ),
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 214.0,
              height: 20.0,
              decoration: BoxDecoration(),
              child: Text(
                valueOrDefault<String>(
                  dateTimeFormat("MMMMEEEEd", widget.savedChatObjectJ?.date),
                  'Null',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 15.0,
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
            Container(
              width: 60.0,
              height: 24.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Confirm'),
                              content: Text(
                                  'Are you sure you would like to delete this chat?'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Confirm'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      await widget.savedChatObjectJ!.reference.delete();
                    }
                  },
                  text: '',
                  icon: Icon(
                    Icons.delete_forever,
                    size: 24.0,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(7.0, 0.0, 0.0, 0.0),
                    iconColor: FlutterFlowTheme.of(context).primaryText,
                    color: FlutterFlowTheme.of(context).secondary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                          color: Colors.white,
                          fontSize: 13.0,
                          letterSpacing: 0.0,
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
