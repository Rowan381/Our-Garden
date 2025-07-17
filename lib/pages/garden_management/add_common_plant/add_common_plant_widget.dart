import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_search/text_search.dart';
import 'add_common_plant_model.dart';
export 'add_common_plant_model.dart';

class AddCommonPlantWidget extends StatefulWidget {
  const AddCommonPlantWidget({
    super.key,
    this.gardenDest,
  });

  final GardensRecord? gardenDest;

  static String routeName = 'addCommonPlant';
  static String routePath = '/addCommonPlant';

  @override
  State<AddCommonPlantWidget> createState() => _AddCommonPlantWidgetState();
}

class _AddCommonPlantWidgetState extends State<AddCommonPlantWidget> {
  late AddCommonPlantModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCommonPlantModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
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
        List<GardensRecord> addCommonPlantGardensRecordList = snapshot.data!;

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
                        if (_shouldSetState) safeSetState(() {});
                        return;
                      }
                      _model.saveLoading = true;
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
                      if (_model.speciesSelectedBool) {
                        _model.selectedGardenDoc = await queryGardensRecordOnce(
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
                        _model.numMatchingPlantIDs =
                            await queryPlantsRecordCount(
                          queryBuilder: (plantsRecord) => plantsRecord
                              .where(
                                'userCreatorID',
                                isEqualTo: currentUserUid,
                              )
                              .where(
                                'gardenCreatorRef',
                                isEqualTo: _model.selectedGardenDoc?.reference,
                              )
                              .where(
                                'plantID',
                                isEqualTo: _model.textController1.text,
                              ),
                        );
                        _shouldSetState = true;
                        if ((_model.numMatchingPlantIDs!) == 0) {
                          _model.speciesDoc = await queryCommonPlantsRecordOnce(
                            queryBuilder: (commonPlantsRecord) =>
                                commonPlantsRecord.where(
                              'species',
                              isEqualTo: _model.recentlyClickedSpecies,
                            ),
                            singleRecord: true,
                          ).then((s) => s.firstOrNull);
                          _shouldSetState = true;

                          var plantsRecordReference =
                              PlantsRecord.collection.doc();
                          await plantsRecordReference.set({
                            ...createPlantsRecordData(
                              userCreatorID: currentUserUid,
                              gardenCreatorRef:
                                  _model.selectedGardenDoc?.reference,
                              plantSpecies: _model.recentlyClickedSpecies,
                              plantIMGURL: _model.speciesDoc?.imageURL,
                            ),
                            ...mapToFirestore(
                              {
                                'dateCreated': FieldValue.serverTimestamp(),
                              },
                            ),
                          });
                          _model.plantUnderConstruction =
                              PlantsRecord.getDocumentFromData({
                            ...createPlantsRecordData(
                              userCreatorID: currentUserUid,
                              gardenCreatorRef:
                                  _model.selectedGardenDoc?.reference,
                              plantSpecies: _model.recentlyClickedSpecies,
                              plantIMGURL: _model.speciesDoc?.imageURL,
                            ),
                            ...mapToFirestore(
                              {
                                'dateCreated': DateTime.now(),
                              },
                            ),
                          }, plantsRecordReference);
                          _shouldSetState = true;
                          if (_model.textController1.text != '') {
                            await _model.plantUnderConstruction!.reference
                                .update(createPlantsRecordData(
                              plantID: _model.textController1.text,
                            ));
                          } else {
                            _model.numMatchingSpecies =
                                await queryPlantsRecordCount(
                              queryBuilder: (plantsRecord) => plantsRecord
                                  .where(
                                    'userCreatorID',
                                    isEqualTo: currentUserUid,
                                  )
                                  .where(
                                    'gardenCreatorRef',
                                    isEqualTo:
                                        _model.selectedGardenDoc?.reference,
                                  )
                                  .where(
                                    'plantSpecies',
                                    isEqualTo: _model.recentlyClickedSpecies,
                                  ),
                            );
                            _shouldSetState = true;
                            if (valueOrDefault<int>(
                                  _model.numMatchingSpecies,
                                  0,
                                ) >
                                1) {
                              _model.nickname =
                                  '${_model.recentlyClickedSpecies} ${_model.numMatchingSpecies?.toString()}';
                              safeSetState(() {});
                              _model.moreTwins = await queryPlantsRecordCount(
                                queryBuilder: (plantsRecord) => plantsRecord
                                    .where(
                                      'userCreatorID',
                                      isEqualTo: currentUserUid,
                                    )
                                    .where(
                                      'gardenCreatorRef',
                                      isEqualTo:
                                          _model.selectedGardenDoc?.reference,
                                    )
                                    .where(
                                      'plantID',
                                      isEqualTo: _model.nickname,
                                    ),
                              );
                              _shouldSetState = true;
                              if (_model.moreTwins != 0) {
                                while (_model.currTwins != 0) {
                                  _model.nickname =
                                      '${_model.recentlyClickedSpecies} ${((_model.numMatchingSpecies!) + _model.currIncrement).toString()}';
                                  safeSetState(() {});
                                  _model.stillTwins =
                                      await queryPlantsRecordCount(
                                    queryBuilder: (plantsRecord) => plantsRecord
                                        .where(
                                          'userCreatorID',
                                          isEqualTo: currentUserUid,
                                        )
                                        .where(
                                          'gardenCreatorRef',
                                          isEqualTo: _model
                                              .selectedGardenDoc?.reference,
                                        )
                                        .where(
                                          'plantID',
                                          isEqualTo: _model.nickname,
                                        ),
                                  );
                                  _shouldSetState = true;
                                  _model.currTwins = _model.stillTwins!;
                                  safeSetState(() {});
                                  _model.currIncrement =
                                      _model.currIncrement + 1;
                                  safeSetState(() {});
                                }
                              }

                              await _model.plantUnderConstruction!.reference
                                  .update(createPlantsRecordData(
                                plantID: _model.nickname,
                              ));
                            } else {
                              await _model.plantUnderConstruction!.reference
                                  .update(createPlantsRecordData(
                                plantID: _model.recentlyClickedSpecies,
                              ));
                            }
                          }

                          if ((_model.selectedGardenDoc?.imageurl ==
                                  'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae') ||
                              (_model.selectedGardenDoc?.imageurl == null ||
                                  _model.selectedGardenDoc?.imageurl == '')) {
                            await _model.selectedGardenDoc!.reference
                                .update(createGardensRecordData(
                              imageurl:
                                  _model.plantUnderConstruction?.plantIMGURL,
                            ));
                          }
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Error: nickname not unique'),
                                content: Text(
                                    'Choose a new nickname or leave it blank'),
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

                        await _model.selectedGardenDoc!.reference.update({
                          ...mapToFirestore(
                            {
                              'numPlants': FieldValue.increment(1),
                            },
                          ),
                        });

                        context.goNamed(TabsWidget.routeName);
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Error saving plant'),
                              content: Text('Please select a common plant'),
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

                      if (_shouldSetState) safeSetState(() {});
                    },
                    backgroundColor: FlutterFlowTheme.of(context).secondary,
                    elevation: 0.0,
                    label: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Text(
                        'Save Plant',
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              font: GoogleFonts.ibmPlexMono(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: Colors.white,
                              fontSize: 24.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              body: SafeArea(
                top: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                5.0, 0.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderColor: Colors.transparent,
                              borderRadius: 0.0,
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
                    Flexible(
                      child: Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 20.0),
                                  child: Text(
                                    'Add Common Plant',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.ibmPlexMono(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 32.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
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
                                      20.0, 0.0, 20.0, 0.0),
                                  child: FlutterFlowDropDown<String>(
                                    controller:
                                        _model.dropDownValueController ??=
                                            FormFieldController<String>(
                                      _model.dropDownValue ??=
                                          widget.gardenDest?.gardenName,
                                    ),
                                    options: addCommonPlantGardensRecordList
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
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 6.0, 20.0, 6.0),
                                  child: TextFormField(
                                    controller: _model.textController1,
                                    focusNode: _model.textFieldFocusNode1,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Optional nickname',
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
                                            fontSize: 20.0,
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
                                    validator: _model.textController1Validator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 1.0, 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!_model.speciesSelectedBool)
                                      Container(
                                        width: 10.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 5.0),
                                        child: TextFormField(
                                          controller: _model.textController2,
                                          focusNode: _model.textFieldFocusNode2,
                                          onFieldSubmitted: (_) async {
                                            await queryCommonPlantsRecordOnce()
                                                .then(
                                                  (records) => _model
                                                          .simpleSearchResults =
                                                      TextSearch(
                                                    records
                                                        .map(
                                                          (record) =>
                                                              TextSearchItem
                                                                  .fromTerms(
                                                                      record, [
                                                            record.species
                                                          ]),
                                                        )
                                                        .toList(),
                                                  )
                                                          .search(_model
                                                              .textController2
                                                              .text)
                                                          .map((r) => r.object)
                                                          .take(30)
                                                          .toList(),
                                                )
                                                .onError((_, __) => _model
                                                    .simpleSearchResults = [])
                                                .whenComplete(
                                                    () => safeSetState(() {}));

                                            _model.showAllSpecies = false;
                                            safeSetState(() {});
                                            if (_model.simpleSearchResults
                                                .isNotEmpty) {
                                              _model.noResults = false;
                                              safeSetState(() {});
                                            } else {
                                              _model.noResults = true;
                                              safeSetState(() {});
                                            }

                                            await CommonPlantsQueryRecord
                                                .collection
                                                .doc()
                                                .set(
                                                    createCommonPlantsQueryRecordData(
                                                  user: currentUserUid,
                                                  query: _model
                                                      .textController2.text,
                                                ));
                                          },
                                          autofocus: false,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Search plants',
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
                                                  fontSize: 20.0,
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
                                                  fontSize: 20.0,
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
                                                color: Color(0xFF00ADEA),
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFFEDF7FF),
                                            contentPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
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
                                          validator: _model
                                              .textController2Validator
                                              .asValidator(context),
                                        ),
                                      ),
                                    ),
                                    if (!_model.speciesSelectedBool)
                                      Container(
                                        width: 20.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    if (_model.speciesSelectedBool)
                                      Container(
                                        width: 140.0,
                                        height: 50.0,
                                        decoration: BoxDecoration(),
                                        child: Visibility(
                                          visible: _model.speciesSelectedBool,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2.0, 0.0, 0.0, 0.0),
                                            child: AutoSizeText(
                                              'Selected species: ${_model.recentlyClickedSpecies}',
                                              maxLines: 2,
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font:
                                                        GoogleFonts.ibmPlexMono(
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
                                      ),
                                  ],
                                ),
                              ),
                              if (_model.showAllSpecies == true)
                                Flexible(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child:
                                        StreamBuilder<List<CommonPlantsRecord>>(
                                      stream: queryCommonPlantsRecord(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<CommonPlantsRecord>
                                            columnCommonPlantsRecordList =
                                            snapshot.data!;

                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: List.generate(
                                                columnCommonPlantsRecordList
                                                    .length, (columnIndex) {
                                              final columnCommonPlantsRecord =
                                                  columnCommonPlantsRecordList[
                                                      columnIndex];
                                              return Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -0.44),
                                                child: Container(
                                                  width: 350.0,
                                                  height: 150.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.recentlyClickedSpecies =
                                                          columnCommonPlantsRecord
                                                              .species;
                                                      safeSetState(() {});
                                                      _model.speciesSelectedBool =
                                                          true;
                                                      safeSetState(() {});
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            columnCommonPlantsRecord
                                                                .imageURL,
                                                            width: 167.0,
                                                            height: 200.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                columnCommonPlantsRecord
                                                                    .species,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .ibmPlexMono(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).divide(SizedBox(height: 10.0)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              if (_model.noResults && !_model.showAllSpecies)
                                Flexible(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                0.0, -0.44),
                                            child: Container(
                                              width: 350.0,
                                              height: 150.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Text(
                                                  'Plant coming soon! Try another search or create a custom plant',
                                                  textAlign: TextAlign.center,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
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
                                                        fontSize: 20.0,
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
                                          ),
                                        ].divide(SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              if (!_model.showAllSpecies && !_model.noResults)
                                Flexible(
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child:
                                        StreamBuilder<List<CommonPlantsRecord>>(
                                      stream: queryCommonPlantsRecord(
                                        queryBuilder: (commonPlantsRecord) =>
                                            commonPlantsRecord.whereIn(
                                                'species',
                                                _model.simpleSearchResults
                                                    .map((e) => e.species)
                                                    .toList()),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<CommonPlantsRecord>
                                            listViewCommonPlantsRecordList =
                                            snapshot.data!;

                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              listViewCommonPlantsRecordList
                                                  .length,
                                          itemBuilder:
                                              (context, listViewIndex) {
                                            final listViewCommonPlantsRecord =
                                                listViewCommonPlantsRecordList[
                                                    listViewIndex];
                                            return Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -0.44),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: Container(
                                                  width: 350.0,
                                                  height: 150.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                  ),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.recentlyClickedSpecies =
                                                          listViewCommonPlantsRecord
                                                              .species;
                                                      safeSetState(() {});
                                                      _model.speciesSelectedBool =
                                                          true;
                                                      safeSetState(() {});
                                                    },
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            listViewCommonPlantsRecord
                                                                .imageURL,
                                                            width: 167.0,
                                                            height: 200.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                listViewCommonPlantsRecord
                                                                    .species,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .ibmPlexMono(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
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
                                      },
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
