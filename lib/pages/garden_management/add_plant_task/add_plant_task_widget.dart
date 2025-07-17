import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_plant_task_model.dart';
export 'add_plant_task_model.dart';

class AddPlantTaskWidget extends StatefulWidget {
  const AddPlantTaskWidget({
    super.key,
    this.plantRef,
  });

  final PlantsRecord? plantRef;

  static String routeName = 'addPlantTask';
  static String routePath = '/addPlantTask';

  @override
  State<AddPlantTaskWidget> createState() => _AddPlantTaskWidgetState();
}

class _AddPlantTaskWidgetState extends State<AddPlantTaskWidget> {
  late AddPlantTaskModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddPlantTaskModel());

    _model.customObjectiveTextController ??= TextEditingController();
    _model.customObjectiveFocusNode ??= FocusNode();

    _model.taskNotesTextController ??= TextEditingController();
    _model.taskNotesFocusNode ??= FocusNode();

    _model.frequencyNumFieldTextController ??= TextEditingController();
    _model.frequencyNumFieldFocusNode ??= FocusNode();

    _model.endTaskSwitchValue = true;
    _model.occurrencesFieldTextController ??= TextEditingController();
    _model.occurrencesFieldFocusNode ??= FocusNode();
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
        List<GardensRecord> addPlantTaskGardensRecordList = snapshot.data!;

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
              floatingActionButton: Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 0.0),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      var _shouldSetState = false;
                      if (_model.saveLoading) {
                        if (_shouldSetState) safeSetState(() {});
                        return;
                      }

                      _model.saveLoading = true;
                      _model.valid = true;
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        _model.valid = false;
                      }
                      if (_model.chooseGardenValue == null) {
                        _model.valid = false;
                      }
                      if (_model.assignPlantValue == null) {
                        _model.valid = false;
                      }
                      if (_model.selectObjectiveValue == null) {
                        _model.valid = false;
                      }
                      if (_model.frequencyTypeDDValue == null) {
                        _model.valid = false;
                      }
                      if (_model.datePicked == null) {
                        _model.valid = false;
                      }
                      _shouldSetState = true;
                      if (!_model.valid!) {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text(
                                  'Make sure all fields are filled and start date is chosen'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                        _model.saveLoading = false;
                        safeSetState(() {});
                        if (_shouldSetState) safeSetState(() {});
                        return;
                      }
                      _model.recentPlantCreatorRef =
                          await queryPlantsRecordOnce(
                        queryBuilder: (plantsRecord) => plantsRecord
                            .where(
                              'userCreatorID',
                              isEqualTo: currentUserUid,
                            )
                            .where(
                              'plantID',
                              isEqualTo: _model.assignPlantValue,
                            ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      _shouldSetState = true;
                      if (_model.selectObjectiveValue == 'Custom') {
                        _model.objectiveTwins1 =
                            await queryPlantTasksRecordOnce(
                          queryBuilder: (plantTasksRecord) => plantTasksRecord
                              .where(
                                'plantCreatorRef',
                                isEqualTo:
                                    _model.recentPlantCreatorRef?.reference,
                              )
                              .where(
                                'objective',
                                isEqualTo:
                                    _model.customObjectiveTextController.text,
                              ),
                        );
                        _shouldSetState = true;
                        if (_model.objectiveTwins1 != null &&
                            (_model.objectiveTwins1)!.isNotEmpty) {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Objective is not unique to plant'),
                                content: Text('Try a different objective'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                          _model.saveLoading = false;
                          safeSetState(() {});
                          if (_shouldSetState) safeSetState(() {});
                          return;
                        }
                      } else {
                        _model.objectiveTwins2 =
                            await queryPlantTasksRecordOnce(
                          queryBuilder: (plantTasksRecord) => plantTasksRecord
                              .where(
                                'plantCreatorRef',
                                isEqualTo:
                                    _model.recentPlantCreatorRef?.reference,
                              )
                              .where(
                                'objective',
                                isEqualTo: _model.selectObjectiveValue,
                              ),
                        );
                        _shouldSetState = true;
                        if (_model.objectiveTwins2 != null &&
                            (_model.objectiveTwins2)!.isNotEmpty) {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Objective is not unique to plant'),
                                content:
                                    Text('Try a different or custom objective'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                          _model.saveLoading = false;
                          safeSetState(() {});
                          if (_shouldSetState) safeSetState(() {});
                          return;
                        }
                      }

                      var plantTasksRecordReference =
                          PlantTasksRecord.collection.doc();
                      await plantTasksRecordReference
                          .set(createPlantTasksRecordData(
                        frequencyNum: int.tryParse(
                            _model.frequencyNumFieldTextController.text),
                        frequencyType: _model.frequencyTypeDDValue,
                        notes: _model.taskNotesTextController.text,
                        startDate: _model.datePicked,
                        userCreatorID: currentUserUid,
                      ));
                      _model.plantTaskInProgress =
                          PlantTasksRecord.getDocumentFromData(
                              createPlantTasksRecordData(
                                frequencyNum: int.tryParse(_model
                                    .frequencyNumFieldTextController.text),
                                frequencyType: _model.frequencyTypeDDValue,
                                notes: _model.taskNotesTextController.text,
                                startDate: _model.datePicked,
                                userCreatorID: currentUserUid,
                              ),
                              plantTasksRecordReference);
                      _shouldSetState = true;
                      if (_model.selectObjectiveValue == 'Custom') {
                        await _model.plantTaskInProgress!.reference
                            .update(createPlantTasksRecordData(
                          objective: _model.customObjectiveTextController.text,
                        ));
                      } else {
                        await _model.plantTaskInProgress!.reference
                            .update(createPlantTasksRecordData(
                          objective: _model.selectObjectiveValue,
                        ));
                      }

                      if (_model.endTaskSwitchValue!) {
                        await _model.plantTaskInProgress!.reference
                            .update(createPlantTasksRecordData(
                          occurrences: int.tryParse(
                              _model.occurrencesFieldTextController.text),
                        ));
                      } else {
                        await _model.plantTaskInProgress!.reference
                            .update(createPlantTasksRecordData(
                          occurrences: -1,
                        ));
                      }

                      _model.recentGardenCreatorRef =
                          await queryGardensRecordOnce(
                        queryBuilder: (gardensRecord) => gardensRecord
                            .where(
                              'gardenName',
                              isEqualTo: _model.chooseGardenValue,
                            )
                            .where(
                              'uid',
                              isEqualTo: currentUserUid,
                            ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      _shouldSetState = true;

                      await _model.plantTaskInProgress!.reference
                          .update(createPlantTasksRecordData(
                        gardenCreatorRef:
                            _model.recentGardenCreatorRef?.reference,
                      ));

                      await _model.plantTaskInProgress!.reference
                          .update(createPlantTasksRecordData(
                        plantCreatorRef:
                            _model.recentPlantCreatorRef?.reference,
                        completedToday: false,
                      ));

                      context.goNamed(TabsWidget.routeName);

                      if (_shouldSetState) safeSetState(() {});
                    },
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                    elevation: 0.0,
                    label: Text(
                      'Save Task',
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                    ),
                  ),
                ),
              ),
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
                  autovalidateMode: AutovalidateMode.always,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Add Plant Task',
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
                                20.0, 10.0, 20.0, 0.0),
                            child: FlutterFlowDropDown<String>(
                              controller: _model.chooseGardenValueController ??=
                                  FormFieldController<String>(null),
                              options: addPlantTaskGardensRecordList
                                  .map((e) => e.gardenName)
                                  .toList(),
                              onChanged: (val) async {
                                safeSetState(
                                    () => _model.chooseGardenValue = val);
                                var _shouldSetState = false;
                                _model.currGardenRef =
                                    await queryGardensRecordOnce(
                                  queryBuilder: (gardensRecord) => gardensRecord
                                      .where(
                                        'uid',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'gardenName',
                                        isEqualTo: _model.chooseGardenValue,
                                      ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);
                                _shouldSetState = true;
                                _model.correspondingPlants =
                                    await queryPlantsRecordOnce(
                                  queryBuilder: (plantsRecord) => plantsRecord
                                      .where(
                                        'userCreatorID',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'gardenCreatorRef',
                                        isEqualTo:
                                            _model.currGardenRef?.reference,
                                      ),
                                );
                                _shouldSetState = true;
                                if (_model.correspondingPlants?.length == 0) {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Garden Has No Plants'),
                                        content: Text(
                                            'Choose a different garden or add a plant'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  if (_shouldSetState) safeSetState(() {});
                                  return;
                                }

                                if (_shouldSetState) safeSetState(() {});
                              },
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
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Choose Plant\'s Garden',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                                  16.0, 2.0, 16.0, 2.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: false,
                              isMultiSelect: false,
                              labelText: '',
                              labelTextStyle: FlutterFlowTheme.of(context)
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
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 20.0,
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
                        ),
                        if (_model.chooseGardenValue != null &&
                                _model.chooseGardenValue != ''
                            ? true
                            : false)
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: FlutterFlowDropDown<String>(
                                controller:
                                    _model.assignPlantValueController ??=
                                        FormFieldController<String>(null),
                                options: _model.correspondingPlants!
                                    .map((e) => e.plantID)
                                    .toList(),
                                onChanged: (val) => safeSetState(
                                    () => _model.assignPlantValue = val),
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
                                      fontSize: 18.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                hintText: 'Assign to Plant',
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
                                    16.0, 2.0, 16.0, 2.0),
                                hidesUnderline: true,
                                isOverButton: true,
                                isSearchable: false,
                                isMultiSelect: false,
                                labelText: '',
                                labelTextStyle: FlutterFlowTheme.of(context)
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
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 20.0,
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
                          ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Task Objective',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 24.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
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
                                20.0, 0.0, 20.0, 0.0),
                            child: FlutterFlowDropDown<String>(
                              controller:
                                  _model.selectObjectiveValueController ??=
                                      FormFieldController<String>(null),
                              options: [
                                'Water',
                                'Pest Defense',
                                'Mist',
                                'Prune',
                                'Repot',
                                'Harvest',
                                'Custom'
                              ],
                              onChanged: (val) => safeSetState(
                                  () => _model.selectObjectiveValue = val),
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
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              hintText: 'Select Objective',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
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
                                  16.0, 2.0, 16.0, 2.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: false,
                              isMultiSelect: false,
                              labelText: '',
                              labelTextStyle: FlutterFlowTheme.of(context)
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
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 28.0,
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
                        ),
                        if (_model.selectObjectiveValue == 'Custom')
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: TextFormField(
                                controller:
                                    _model.customObjectiveTextController,
                                focusNode: _model.customObjectiveFocusNode,
                                autofocus: true,
                                textCapitalization: TextCapitalization.words,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.ibmPlexMono(
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  alignLabelWithHint: true,
                                  hintText: 'Custom objective...',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.ibmPlexMono(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  errorStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        font: GoogleFonts.ibmPlexMono(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).error,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFEDEDED),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          16.0, 16.0, 16.0, 16.0),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                minLines: 1,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                validator: _model
                                    .customObjectiveTextControllerValidator
                                    .asValidator(context),
                                inputFormatters: [
                                  if (!isAndroid && !isiOS)
                                    TextInputFormatter.withFunction(
                                        (oldValue, newValue) {
                                      return TextEditingValue(
                                        selection: newValue.selection,
                                        text: newValue.text.toCapitalization(
                                            TextCapitalization.words),
                                      );
                                    }),
                                ],
                              ),
                            ),
                          ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: TextFormField(
                              controller: _model.taskNotesTextController,
                              focusNode: _model.taskNotesFocusNode,
                              autofocus: false,
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.ibmPlexMono(
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                alignLabelWithHint: true,
                                hintText: 'Task notes...',
                                hintStyle: FlutterFlowTheme.of(context)
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
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                errorStyle: FlutterFlowTheme.of(context)
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
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: Color(0xFFEDEDED),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 16.0, 16.0, 16.0),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              maxLines: 9,
                              minLines: 2,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model.taskNotesTextControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                if (!isAndroid && !isiOS)
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return TextEditingValue(
                                      selection: newValue.selection,
                                      text: newValue.text.toCapitalization(
                                          TextCapitalization.words),
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDEDED),
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFFAEAEAE),
                                width: 2.0,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'every',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.ibmPlexMono(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Container(
                                      width: 100.0,
                                      child: TextFormField(
                                        controller: _model
                                            .frequencyNumFieldTextController,
                                        focusNode:
                                            _model.frequencyNumFieldFocusNode,
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.ibmPlexMono(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          alignLabelWithHint: false,
                                          hintText: 'number',
                                          hintStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.ibmPlexMono(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                          contentPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 42.0),
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.ibmPlexMono(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        textAlign: TextAlign.center,
                                        minLines: 1,
                                        keyboardType: TextInputType.number,
                                        validator: _model
                                            .frequencyNumFieldTextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FlutterFlowDropDown<String>(
                                    controller: _model
                                            .frequencyTypeDDValueController ??=
                                        FormFieldController<String>(null),
                                    options: ['Days', 'Weeks', 'Months'],
                                    onChanged: (val) => safeSetState(() =>
                                        _model.frequencyTypeDDValue = val),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.ibmPlexMono(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    hintText: 'period',
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
                                        16.0, 4.0, 16.0, 4.0),
                                    hidesUnderline: true,
                                    isOverButton: true,
                                    isSearchable: false,
                                    isMultiSelect: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              final _datePickedDate = await showDatePicker(
                                context: context,
                                initialDate: getCurrentTimestamp,
                                firstDate: getCurrentTimestamp,
                                lastDate: DateTime(2050),
                              );

                              TimeOfDay? _datePickedTime;
                              if (_datePickedDate != null) {
                                _datePickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.fromDateTime(
                                      getCurrentTimestamp),
                                );
                              }

                              if (_datePickedDate != null &&
                                  _datePickedTime != null) {
                                safeSetState(() {
                                  _model.datePicked = DateTime(
                                    _datePickedDate.year,
                                    _datePickedDate.month,
                                    _datePickedDate.day,
                                    _datePickedTime!.hour,
                                    _datePickedTime.minute,
                                  );
                                });
                              } else if (_model.datePicked != null) {
                                safeSetState(() {
                                  _model.datePicked = getCurrentTimestamp;
                                });
                              }
                              if (_model.datePicked != null) {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Start Date Chosen!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            text: 'Choose Start',
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0x5B686666),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(36.0),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(36.0),
                              border: Border.all(
                                color: Color(0xFF090909),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 7,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'End Task',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.ibmPlexMono(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        7.0, 0.0, 0.0, 0.0),
                                    child: Switch.adaptive(
                                      value: _model.endTaskSwitchValue!,
                                      onChanged: (newValue) async {
                                        safeSetState(() => _model
                                            .endTaskSwitchValue = newValue);
                                      },
                                      activeColor:
                                          FlutterFlowTheme.of(context).primary,
                                      activeTrackColor: Color(0xFF72B589),
                                      inactiveTrackColor:
                                          FlutterFlowTheme.of(context)
                                              .alternate,
                                      inactiveThumbColor: Color(0x5B686666),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_model.endTaskSwitchValue ?? true)
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEDEDED),
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Color(0xFFAEAEAE),
                                  width: 2.0,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'stop after',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.ibmPlexMono(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: 100.0,
                                        child: TextFormField(
                                          controller: _model
                                              .occurrencesFieldTextController,
                                          focusNode:
                                              _model.occurrencesFieldFocusNode,
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.ibmPlexMono(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                            hintText: 'number',
                                            hintStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.ibmPlexMono(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 42.0),
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.ibmPlexMono(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          validator: _model
                                              .occurrencesFieldTextControllerValidator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: Text(
                                        'reminders',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.ibmPlexMono(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 16.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
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
                      ]
                          .divide(SizedBox(height: 12.0))
                          .addToEnd(SizedBox(height: 32.0)),
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
