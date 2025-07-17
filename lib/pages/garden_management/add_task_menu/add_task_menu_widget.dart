import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_task_menu_model.dart';
export 'add_task_menu_model.dart';

class AddTaskMenuWidget extends StatefulWidget {
  const AddTaskMenuWidget({super.key});

  static String routeName = 'addTaskMenu';
  static String routePath = '/addTaskMenu';

  @override
  State<AddTaskMenuWidget> createState() => _AddTaskMenuWidgetState();
}

class _AddTaskMenuWidgetState extends State<AddTaskMenuWidget> {
  late AddTaskMenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddTaskMenuModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                child: FlutterFlowIconButton(
                  borderRadius: 20.0,
                  borderWidth: 0.0,
                  buttonSize: 48.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.arrow_back,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Add Task',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.ibmPlexMono(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              fontSize: 32.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .headlineMedium
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          'Would you like to add a task to a plant or garden?',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.ibmPlexMono(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 15.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w300,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(AddPlantTaskWidget.routeName);
                          },
                          text: 'Plant Task',
                          icon: Icon(
                            FFIcons.kflowers,
                            size: 50.0,
                          ),
                          options: FFButtonOptions(
                            width: 290.0,
                            height: 120.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            iconColor: FlutterFlowTheme.of(context).primaryText,
                            color: Color(0xFFEDEDED),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(AddGardenTaskWidget.routeName);
                          },
                          text: 'Garden Task',
                          icon: Icon(
                            FFIcons.kicons8Hydroponics90,
                            size: 50.0,
                          ),
                          options: FFButtonOptions(
                            width: 290.0,
                            height: 120.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 20.0),
                            iconColor: FlutterFlowTheme.of(context).primaryText,
                            color: Color(0xFFEDEDED),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primaryText,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
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
      ),
    );
  }
}
