import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_custom_plant_model.dart';
export 'add_custom_plant_model.dart';

class AddCustomPlantWidget extends StatefulWidget {
  const AddCustomPlantWidget({
    super.key,
    this.gardenDest,
  });

  final GardensRecord? gardenDest;

  static String routeName = 'addCustomPlant';
  static String routePath = '/addCustomPlant';

  @override
  State<AddCustomPlantWidget> createState() => _AddCustomPlantWidgetState();
}

class _AddCustomPlantWidgetState extends State<AddCustomPlantWidget> {
  late AddCustomPlantModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCustomPlantModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.customSpeciesList = await queryCustomSpeciesRecordOnce(
        queryBuilder: (customSpeciesRecord) => customSpeciesRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
      );
    });

    _model.switchValue = false;
    _model.customSpeciesTextController ??= TextEditingController();
    _model.customSpeciesFocusNode ??= FocusNode();

    _model.nicknameTextController ??= TextEditingController();
    _model.nicknameFocusNode ??= FocusNode();
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
            backgroundColor: Colors.white,
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
        List<GardensRecord> addCustomPlantGardensRecordList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.white,
              floatingActionButton: Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 0.0),
                  child: FloatingActionButton.extended(
                    onPressed: () async {
                      var _shouldSetState = false;
                      if (_model.saveLoading) {
                        return;
                      }

                      _model.saveLoading = true;
                      if (_model.isDataUploading_uploadDataP0f) {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Image Uploading'),
                              content: Text(
                                  'Please wait until the image has fully uploaded'),
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
                      _model.formValidated = true;
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        _model.formValidated = false;
                      }
                      if (_model.dropDownValue == null) {
                        _model.formValidated = false;
                      }
                      _shouldSetState = true;
                      if (!_model.formValidated!) {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Make sure all fields are filled'),
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
                      if (!_model.switchValue! &&
                          (_model.uploadedFileUrl_uploadDataP0f == '')) {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('No Image Uploaded'),
                              content: Text(
                                  'Upload an image or choose a species you added'),
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
                      } else {
                        if (_model.switchValue! &&
                            (_model.addedSpeciesDDValue == null ||
                                _model.addedSpeciesDDValue == '')) {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('No Species Selected'),
                                content: Text(
                                    'Select a species from the dropdown or write a new one'),
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
                        } else {
                          if ((_model.switchValue == false) &&
                              (_model.customSpeciesTextController.text ==
                                      '')) {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title:
                                      Text('Custom Species Field Not Filled'),
                                  content: Text(
                                      'Enter the species or choose a species you added'),
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
                            if (_shouldSetState) safeSetState(() {});
                            return;
                          }
                        }
                      }

                      _model.gardenSelectedDoc = await queryGardensRecordOnce(
                        queryBuilder: (gardensRecord) => gardensRecord
                            .where(
                              'uid',
                              isEqualTo: currentUserUid,
                            )
                            .where(
                              'gardenName',
                              isEqualTo: _model.dropDownValue,
                            ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      _shouldSetState = true;
                      if (_model.nicknameTextController.text != '') {
                        _model.planTwins = await queryPlantsRecordOnce(
                          queryBuilder: (plantsRecord) => plantsRecord
                              .where(
                                'userCreatorID',
                                isEqualTo: currentUserUid,
                              )
                              .where(
                                'gardenCreatorRef',
                                isEqualTo: _model.gardenSelectedDoc?.reference,
                              )
                              .where(
                                'plantID',
                                isEqualTo: _model.nicknameTextController.text,
                              ),
                        );
                        _shouldSetState = true;
                        if (!(_model.planTwins != null &&
                            (_model.planTwins)!.isNotEmpty)) {
                          if (!_model.switchValue!) {
                            _model.commonSpeciesPoss =
                                await queryCommonPlantsRecordOnce(
                              queryBuilder: (commonPlantsRecord) =>
                                  commonPlantsRecord.where(
                                'species',
                                isEqualTo:
                                    _model.customSpeciesTextController.text,
                              ),
                            );
                            _shouldSetState = true;
                            if (_model.commonSpeciesPoss != null &&
                                (_model.commonSpeciesPoss)!.isNotEmpty) {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text(
                                        'Are you looking for the species${_model.commonSpeciesPoss?.firstOrNull?.species}?'),
                                    content: Text(
                                        'If so, navigate back to choose a common plant'),
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
                              _model.similarSpeciesNotif = true;
                              safeSetState(() {});
                              _model.saveLoading = false;
                              safeSetState(() {});
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            } else if (_model.similarSpeciesNotif) {}
                          }
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Nickname is not Unique'),
                                content:
                                    Text('Please try a different nickname'),
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

                        _model.nickname = _model.nicknameTextController.text;
                        safeSetState(() {});
                      } else {
                        if (_model.switchValue!) {
                          _model.speciesTwins1 = await queryPlantsRecordCount(
                            queryBuilder: (plantsRecord) => plantsRecord
                                .where(
                                  'gardenCreatorRef',
                                  isEqualTo:
                                      _model.gardenSelectedDoc?.reference,
                                )
                                .where(
                                  'plantSpecies',
                                  isEqualTo: _model.addedSpeciesDDValue,
                                )
                                .where(
                                  'userCreatorID',
                                  isEqualTo: currentUserUid,
                                ),
                          );
                          _shouldSetState = true;
                          if (_model.speciesTwins1 == 0) {
                            _model.nickname = _model.addedSpeciesDDValue;
                            safeSetState(() {});
                          } else {
                            _model.nickname =
                                '${_model.addedSpeciesDDValue} ${((_model.speciesTwins1!) + 1).toString()}';
                            _model.moreTwins1 = await queryPlantsRecordCount(
                              queryBuilder: (plantsRecord) => plantsRecord
                                  .where(
                                    'userCreatorID',
                                    isEqualTo: currentUserUid,
                                  )
                                  .where(
                                    'gardenCreatorRef',
                                    isEqualTo:
                                        _model.gardenSelectedDoc?.reference,
                                  )
                                  .where(
                                    'plantID',
                                    isEqualTo: _model.nickname,
                                  ),
                            );
                            _shouldSetState = true;
                            if (_model.moreTwins1 != 0) {
                              while (_model.currTwins != 0) {
                                _model.nickname =
                                    '${_model.addedSpeciesDDValue} ${((_model.speciesTwins1!) + _model.currIncrement).toString()}';
                                _model.currIncrement = _model.currIncrement + 1;
                                _model.stillTwins1 =
                                    await queryPlantsRecordCount(
                                  queryBuilder: (plantsRecord) => plantsRecord
                                      .where(
                                        'userCreatorID',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'gardenCreatorRef',
                                        isEqualTo:
                                            _model.gardenSelectedDoc?.reference,
                                      )
                                      .where(
                                        'plantID',
                                        isEqualTo: _model.nickname,
                                      ),
                                );
                                _shouldSetState = true;
                                _model.currTwins = _model.stillTwins1!;
                                safeSetState(() {});
                              }
                            }
                          }
                        } else {
                          _model.speciesTwins2 = await queryPlantsRecordCount(
                            queryBuilder: (plantsRecord) => plantsRecord
                                .where(
                                  'gardenCreatorRef',
                                  isEqualTo:
                                      _model.gardenSelectedDoc?.reference,
                                )
                                .where(
                                  'plantSpecies',
                                  isEqualTo: _model.addedSpeciesDDValue,
                                )
                                .where(
                                  'userCreatorID',
                                  isEqualTo: currentUserUid,
                                ),
                          );
                          _shouldSetState = true;
                          if (_model.speciesTwins2 == 0) {
                            _model.nickname =
                                _model.customSpeciesTextController.text;
                          } else {
                            _model.nickname =
                                '${_model.customSpeciesTextController.text} ${((_model.speciesTwins2!) + 1).toString()}';
                            _model.moreTwins2 = await queryPlantsRecordCount(
                              queryBuilder: (plantsRecord) => plantsRecord
                                  .where(
                                    'userCreatorID',
                                    isEqualTo: currentUserUid,
                                  )
                                  .where(
                                    'gardenCreatorRef',
                                    isEqualTo:
                                        _model.gardenSelectedDoc?.reference,
                                  )
                                  .where(
                                    'plantID',
                                    isEqualTo: _model.nickname,
                                  ),
                            );
                            _shouldSetState = true;
                            if (_model.moreTwins2 != 0) {
                              while (_model.currTwins != 0) {
                                _model.nickname =
                                    '${_model.customSpeciesTextController.text} ${((_model.speciesTwins2!) + _model.currIncrement).toString()}';
                                _model.currIncrement = _model.currIncrement + 1;
                                _model.stillTwins2 =
                                    await queryPlantsRecordCount(
                                  queryBuilder: (plantsRecord) => plantsRecord
                                      .where(
                                        'userCreatorID',
                                        isEqualTo: currentUserUid,
                                      )
                                      .where(
                                        'gardenCreatorRef',
                                        isEqualTo:
                                            _model.gardenSelectedDoc?.reference,
                                      )
                                      .where(
                                        'plantID',
                                        isEqualTo: _model.nickname,
                                      ),
                                );
                                _shouldSetState = true;
                                _model.currTwins = _model.stillTwins2!;
                                safeSetState(() {});
                              }
                            }
                          }
                        }
                      }

                      var plantsRecordReference = PlantsRecord.collection.doc();
                      await plantsRecordReference.set({
                        ...createPlantsRecordData(
                          userCreatorID: currentUserUid,
                          gardenCreatorRef: _model.gardenSelectedDoc?.reference,
                          plantID: _model.nickname,
                        ),
                        ...mapToFirestore(
                          {
                            'dateCreated': FieldValue.serverTimestamp(),
                          },
                        ),
                      });
                      _model.plantInProgress =
                          PlantsRecord.getDocumentFromData({
                        ...createPlantsRecordData(
                          userCreatorID: currentUserUid,
                          gardenCreatorRef: _model.gardenSelectedDoc?.reference,
                          plantID: _model.nickname,
                        ),
                        ...mapToFirestore(
                          {
                            'dateCreated': DateTime.now(),
                          },
                        ),
                      }, plantsRecordReference);
                      _shouldSetState = true;
                      if (_model.switchValue!) {
                        _model.userSpeciesDoc =
                            await queryCustomSpeciesRecordOnce(
                          queryBuilder: (customSpeciesRecord) =>
                              customSpeciesRecord.where(Filter.or(
                            Filter(
                              'uid',
                              isEqualTo: currentUserUid,
                            ),
                            Filter(
                              'speciesName',
                              isEqualTo: _model.addedSpeciesDDValue,
                            ),
                          )),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        _shouldSetState = true;

                        await _model.plantInProgress!.reference
                            .update(createPlantsRecordData(
                          plantSpecies: _model.addedSpeciesDDValue,
                          plantIMGURL: _model.userSpeciesDoc?.imageURL,
                        ));
                      } else {
                        await _model.plantInProgress!.reference
                            .update(createPlantsRecordData(
                          plantIMGURL: _model.uploadedFileUrl_uploadDataP0f,
                          plantSpecies: _model.customSpeciesTextController.text,
                        ));
                      }

                      if ((_model.gardenSelectedDoc?.imageurl ==
                              'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae') ||
                          (_model.gardenSelectedDoc?.imageurl == null ||
                              _model.gardenSelectedDoc?.imageurl == '')) {
                        await _model.gardenSelectedDoc!.reference
                            .update(createGardensRecordData(
                          imageurl: _model.plantInProgress?.plantIMGURL,
                        ));
                      }

                      await _model.gardenSelectedDoc!.reference.update({
                        ...mapToFirestore(
                          {
                            'numPlants': FieldValue.increment(1),
                          },
                        ),
                      });

                      context.goNamed(TabsWidget.routeName);

                      if (_shouldSetState) safeSetState(() {});
                    },
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                    elevation: 0.0,
                    label: Text(
                      'Save Plant',
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
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 20.0,
                              borderWidth: 0.0,
                              buttonSize: 48.0,
                              fillColor: Colors.white,
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
                      ],
                    ),
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 20.0),
                                  child: Text(
                                    'Add Custom Plant',
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
                                          fontSize: 32.0,
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
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 5.0),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController ??=
                                            FormFieldController<String>(
                                      _model.dropDownValue ??=
                                          addCustomPlantGardensRecordList
                                              .firstOrNull?.gardenName,
                                    ),
                                    options: addCustomPlantGardensRecordList
                                        .map((e) => e.gardenName)
                                        .toList(),
                                    onChanged: (val) => safeSetState(
                                        () => _model.dropDownValue = val),
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
                                          fontSize: 18.0,
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
                                    labelText: 'Assign Plant to Garden',
                                    labelTextStyle: FlutterFlowTheme.of(context)
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
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        flex: 4,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Text(
                                            'Use a Species You Added',
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
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
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
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Switch.adaptive(
                                            value: _model.switchValue!,
                                            onChanged: (newValue) async {
                                              safeSetState(() => _model
                                                  .switchValue = newValue);
                                              if (newValue) {
                                                _model.speciesNameOnly = false;
                                                safeSetState(() {});
                                              } else {
                                                _model.speciesNameOnly = true;
                                              }
                                            },
                                            activeColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            activeTrackColor: Color(0xFF72B589),
                                            inactiveTrackColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            inactiveThumbColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (_model.switchValue ?? true)
                                    Flexible(
                                      flex: 1,
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .addedSpeciesDDValueController ??=
                                                FormFieldController<String>(
                                              _model.addedSpeciesDDValue ??=
                                                  _model
                                                      .customSpeciesList
                                                      ?.firstOrNull
                                                      ?.speciesName,
                                            ),
                                            options: _model.customSpeciesList!
                                                .map((e) => e.speciesName)
                                                .toList(),
                                            onChanged: (val) => safeSetState(
                                                () => _model
                                                    .addedSpeciesDDValue = val),
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
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
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
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
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .alternate,
                                            borderWidth: 2.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 2.0, 16.0, 2.0),
                                            hidesUnderline: true,
                                            isOverButton: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                            labelText: 'Species You Added',
                                            labelTextStyle: FlutterFlowTheme.of(
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
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (!valueOrDefault<bool>(
                                    _model.switchValue,
                                    true,
                                  ))
                                    Flexible(
                                      flex: 1,
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20.0, 0.0, 20.0, 0.0),
                                          child: TextFormField(
                                            controller: _model
                                                .customSpeciesTextController,
                                            focusNode:
                                                _model.customSpeciesFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font:
                                                        GoogleFonts.ibmPlexMono(
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
                                                    fontSize: 18.0,
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
                                              hintText: 'Custom species...',
                                              hintStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    font:
                                                        GoogleFonts.ibmPlexMono(
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
                                                    fontSize: 18.0,
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
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 2.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFD1F3FF),
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 0.0, 0.0),
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
                                                  fontSize: 18.0,
                                                  letterSpacing: 0.0,
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
                                            validator: _model
                                                .customSpeciesTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 10.0, 20.0, 10.0),
                                  child: TextFormField(
                                    controller: _model.nicknameTextController,
                                    focusNode: _model.nicknameFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
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
                                      hintText: 'Optional nickname',
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
                                            fontSize: 18.0,
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
                                          color: Color(0xFFAEAEAE),
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 2.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFEDEDED),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16.0, 0.0, 0.0, 0.0),
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
                                          fontSize: 18.0,
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
                                    validator: _model
                                        .nicknameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              if (_model.speciesNameOnly)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 10.0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        if ((await getPermissionStatus(
                                                photoLibraryPermission)) ||
                                            isAndroid) {
                                          final selectedMedia =
                                              await selectMediaWithSourceBottomSheet(
                                            context: context,
                                            allowPhoto: true,
                                          );
                                          if (selectedMedia != null &&
                                              selectedMedia.every((m) =>
                                                  validateFileFormat(
                                                      m.storagePath,
                                                      context))) {
                                            safeSetState(() => _model
                                                    .isDataUploading_uploadDataP0f =
                                                true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            var downloadUrls = <String>[];
                                            try {
                                              selectedUploadedFiles =
                                                  selectedMedia
                                                      .map(
                                                          (m) => FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                                height: m
                                                                    .dimensions
                                                                    ?.height,
                                                                width: m
                                                                    .dimensions
                                                                    ?.width,
                                                                blurHash:
                                                                    m.blurHash,
                                                              ))
                                                      .toList();

                                              downloadUrls = (await Future.wait(
                                                selectedMedia.map(
                                                  (m) async => await uploadData(
                                                      m.storagePath, m.bytes),
                                                ),
                                              ))
                                                  .where((u) => u != null)
                                                  .map((u) => u!)
                                                  .toList();
                                            } finally {
                                              _model.isDataUploading_uploadDataP0f =
                                                  false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedMedia.length &&
                                                downloadUrls.length ==
                                                    selectedMedia.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFile_uploadDataP0f =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl_uploadDataP0f =
                                                    downloadUrls.first;
                                              });
                                            } else {
                                              safeSetState(() {});
                                              return;
                                            }
                                          }

                                          if (_model.uploadedFileUrl_uploadDataP0f !=
                                                  '') {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title:
                                                      Text('Image Uploaded!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        } else {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text(
                                                    'Photo Permissions Required'),
                                                content: Text(
                                                    'OurGarden is unable to access your photo library because your photo permissions are currently disabled. Please navigate to your device\'s settings to update this permission.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext),
                                                    child: Text('I Understand'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      text: 'Upload Image',
                                      options: FFButtonOptions(
                                        width: 240.0,
                                        height: 40.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: Color(0x5B686666),
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.ibmPlexMono(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              if ((_model.uploadedFileUrl_uploadDataP0f !=
                                          '') &&
                                  !_model.switchValue!)
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      _model.uploadedFileUrl_uploadDataP0f,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.5,
                                      height: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
