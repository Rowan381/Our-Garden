import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/pages/garden_management/garden_management_components/edit_garden_task_menu/edit_garden_task_menu_widget.dart';
import '/pages/garden_management/garden_management_components/edit_plant_task_menu/edit_plant_task_menu_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_task_menu_model.dart';
export 'edit_task_menu_model.dart';

class EditTaskMenuWidget extends StatefulWidget {
  const EditTaskMenuWidget({
    super.key,
    required this.gardenRef,
  });

  final DocumentReference? gardenRef;

  static String routeName = 'editTaskMenu';
  static String routePath = '/editTaskMenu';

  @override
  State<EditTaskMenuWidget> createState() => _EditTaskMenuWidgetState();
}

class _EditTaskMenuWidgetState extends State<EditTaskMenuWidget> {
  late EditTaskMenuModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditTaskMenuModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.ogGardenTasks = await queryGardenTasksRecordOnce(
        queryBuilder: (gardenTasksRecord) => gardenTasksRecord
            .where(
              'uid',
              isEqualTo: currentUserUid,
            )
            .where(
              'gardenCreatorRef',
              isEqualTo: widget.gardenRef,
            ),
      );
      _model.ogPlantTasks = await queryPlantTasksRecordOnce(
        queryBuilder: (plantTasksRecord) => plantTasksRecord
            .where(
              'gardenCreatorRef',
              isEqualTo: widget.gardenRef,
            )
            .where(
              'userCreatorID',
              isEqualTo: currentUserUid,
            ),
      );
      _model.currPlantTasks =
          _model.ogPlantTasks!.toList().cast<PlantTasksRecord>();
      _model.currGardenTasks =
          _model.ogGardenTasks!.toList().cast<GardenTasksRecord>();
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GardensRecord>>(
      stream: queryGardensRecord(
        queryBuilder: (gardensRecord) => gardensRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<GardensRecord> editTaskMenuGardensRecordList = snapshot.data!;

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
                backgroundColor:
                    FlutterFlowTheme.of(context).secondaryBackground,
                automaticallyImplyLeading: false,
                leading: Align(
                  alignment: AlignmentDirectional(-1.0, -1.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 20.0,
                      borderWidth: 0.0,
                      buttonSize: 48.0,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
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
                            'Edit Task',
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 25.0, 0.0, 0.0),
                          child: StreamBuilder<GardensRecord>(
                            stream:
                                GardensRecord.getDocument(widget.gardenRef!),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
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

                              final dropDownGardensRecord = snapshot.data!;

                              return FlutterFlowDropDown<String>(
                                controller: _model.dropDownValueController ??=
                                    FormFieldController<String>(
                                  _model.dropDownValue ??=
                                      dropDownGardensRecord.gardenName,
                                ),
                                options: editTaskMenuGardensRecordList
                                    .map((e) => e.gardenName)
                                    .toList(),
                                onChanged: (val) async {
                                  safeSetState(
                                      () => _model.dropDownValue = val);
                                  _model.currGardenDoc =
                                      await queryGardensRecordOnce(
                                    queryBuilder: (gardensRecord) =>
                                        gardensRecord.where(
                                      'gardenName',
                                      isEqualTo: _model.dropDownValue,
                                    ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  _model.tempGardenTasks =
                                      await queryGardenTasksRecordOnce(
                                    queryBuilder: (gardenTasksRecord) =>
                                        gardenTasksRecord
                                            .where(
                                              'gardenCreatorRef',
                                              isEqualTo: _model
                                                  .currGardenDoc?.reference,
                                            )
                                            .where(
                                              'uid',
                                              isEqualTo: currentUserUid,
                                            ),
                                  );
                                  _model.tempPlantTasks =
                                      await queryPlantTasksRecordOnce(
                                    queryBuilder: (plantTasksRecord) =>
                                        plantTasksRecord
                                            .where(
                                              'gardenCreatorRef',
                                              isEqualTo: _model
                                                  .currGardenDoc?.reference,
                                            )
                                            .where(
                                              'userCreatorID',
                                              isEqualTo: currentUserUid,
                                            ),
                                  );
                                  _model.currPlantTasks = _model.tempPlantTasks!
                                      .toList()
                                      .cast<PlantTasksRecord>();
                                  _model.currGardenTasks = _model
                                      .tempGardenTasks!
                                      .toList()
                                      .cast<GardenTasksRecord>();
                                  safeSetState(() {});

                                  safeSetState(() {});
                                },
                                width: 300.0,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.ibmPlexMono(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 2.0,
                                borderRadius: 8.0,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: true,
                                isSearchable: false,
                                isMultiSelect: false,
                                labelText: 'Choose garden',
                                labelTextStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.ibmPlexMono(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                              );
                            },
                          ),
                        ),
                        if (_model.currPlantTasks.isNotEmpty)
                          Builder(
                            builder: (context) => Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 10.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: EditPlantTaskMenuWidget(
                                            pTaskList: _model.currPlantTasks,
                                          ),
                                        ),
                                      );
                                    },
                                  );
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
                                  iconColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  color: Color(0xFFEDEDED),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.ibmPlexMono(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                            ),
                          ),
                        if (_model.currGardenTasks.isNotEmpty)
                          Builder(
                            builder: (context) => Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 15.0, 0.0, 0.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: EditGardenTaskMenuWidget(
                                            gTaskList: _model.currGardenTasks,
                                          ),
                                        ),
                                      );
                                    },
                                  );
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
                                  iconColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  color: Color(0xFFEDEDED),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        font: GoogleFonts.ibmPlexMono(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 24.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
      },
    );
  }
}
