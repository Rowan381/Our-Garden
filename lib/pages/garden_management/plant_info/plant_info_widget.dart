import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'plant_info_model.dart';
export 'plant_info_model.dart';

class PlantInfoWidget extends StatefulWidget {
  const PlantInfoWidget({
    super.key,
    required this.plantDoc,
  });

  final PlantsRecord? plantDoc;

  static String routeName = 'plantInfo';
  static String routePath = '/plantInfo';

  @override
  State<PlantInfoWidget> createState() => _PlantInfoWidgetState();
}

class _PlantInfoWidgetState extends State<PlantInfoWidget>
    with TickerProviderStateMixin {
  late PlantInfoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlantInfoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.commonList = await queryCommonPlantsRecordOnce(
        queryBuilder: (commonPlantsRecord) => commonPlantsRecord.where(
          'species',
          isEqualTo: widget.plantDoc?.plantSpecies,
        ),
      );
      if (_model.commonList?.length != 0) {
        _model.plantFacts = _model.commonList!.firstOrNull!.blurb;
        safeSetState(() {});
      } else {
        _model.customList = await queryCustomSpeciesRecordOnce(
          queryBuilder: (customSpeciesRecord) => customSpeciesRecord
              .where(
                'uid',
                isEqualTo: currentUserUid,
              )
              .where(
                'speciesName',
                isEqualTo: widget.plantDoc?.plantSpecies,
              ),
        );
        if (_model.customList?.length != 0) {
          _model.plantFacts = _model.customList!.firstOrNull!.blurb;
          safeSetState(() {});
        }
      }

      _model.plantsList = await queryPlantsRecordOnce(
        queryBuilder: (plantsRecord) => plantsRecord.where(
          'userCreatorID',
          isEqualTo: currentUserUid,
        ),
      );
      _model.plantListLen = _model.plantsList?.length;
      safeSetState(() {});
      _model.plantListLen = _model.plantListLen! + -1;
      safeSetState(() {});
      while (_model.plantListLen! >= 0) {
        _model.currGardenDoc = await GardensRecord.getDocumentOnce(_model
            .plantsList!
            .elementAtOrNull(_model.plantListLen!)!
            .gardenCreatorRef!);
        _model.addToPlantListDisplay(
            '${_model.plantsList?.elementAtOrNull(_model.plantListLen!)?.plantID} in ${_model.currGardenDoc?.gardenName}');
        safeSetState(() {});
        _model.plantListLen = _model.plantListLen! + -1;
        safeSetState(() {});
      }
      _model.ogGardenDoc = await GardensRecord.getDocumentOnce(
          widget.plantDoc!.gardenCreatorRef!);
      _model.plantInfoPlantID = widget.plantDoc?.reference;
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: Align(
              alignment: AlignmentDirectional(-1.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
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
            actions: [],
            centerTitle: false,
            toolbarHeight: 40.0,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, -1.0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 358.0,
                      height: 61.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: StreamBuilder<GardensRecord>(
                              stream: GardensRecord.getDocument(
                                  widget.plantDoc!.gardenCreatorRef!),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(
                                      width: 50.0,
                                      height: 50.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          FlutterFlowTheme.of(context).primary,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                final plantDropdownGardensRecord =
                                    snapshot.data!;

                                return FlutterFlowDropDown<String>(
                                  controller:
                                      _model.plantDropdownValueController ??=
                                          FormFieldController<String>(
                                    _model.plantDropdownValue ??=
                                        '${widget.plantDoc?.plantID} in ${plantDropdownGardensRecord.gardenName}',
                                  ),
                                  options: _model.plantListDisplay,
                                  onChanged: (val) async {
                                    safeSetState(
                                        () => _model.plantDropdownValue = val);
                                    _model.plantGardenList =
                                        await actions.newCustomAction2(
                                      _model.plantDropdownValue!,
                                    );
                                    _model.selectedGardenDoc =
                                        await queryGardensRecordOnce(
                                      queryBuilder: (gardensRecord) =>
                                          gardensRecord
                                              .where(
                                                'gardenName',
                                                isEqualTo: _model
                                                    .plantGardenList
                                                    ?.lastOrNull,
                                              )
                                              .where(
                                                'uid',
                                                isEqualTo: currentUserUid,
                                              ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    _model.selectedPlantDoc =
                                        await queryPlantsRecordOnce(
                                      queryBuilder: (plantsRecord) =>
                                          plantsRecord
                                              .where(
                                                'userCreatorID',
                                                isEqualTo: currentUserUid,
                                              )
                                              .where(
                                                'plantID',
                                                isEqualTo: _model
                                                    .plantGardenList
                                                    ?.firstOrNull,
                                              )
                                              .where(
                                                'gardenCreatorRef',
                                                isEqualTo: _model
                                                    .selectedGardenDoc
                                                    ?.reference,
                                              ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    _model.plantInfoPlantID =
                                        _model.selectedPlantDoc?.reference;
                                    _model.selectedCommonList =
                                        await queryCommonPlantsRecordOnce(
                                      queryBuilder: (commonPlantsRecord) =>
                                          commonPlantsRecord.where(
                                        'species',
                                        isEqualTo: _model
                                            .selectedPlantDoc?.plantSpecies,
                                      ),
                                    );
                                    if (_model.selectedCommonList != null &&
                                        (_model.selectedCommonList)!
                                            .isNotEmpty) {
                                      _model.plantFacts = _model
                                          .selectedCommonList!
                                          .firstOrNull!
                                          .blurb;
                                    } else {
                                      _model.selectedCustomList =
                                          await queryCustomSpeciesRecordOnce(
                                        queryBuilder: (customSpeciesRecord) =>
                                            customSpeciesRecord
                                                .where(
                                                  'uid',
                                                  isEqualTo: currentUserUid,
                                                )
                                                .where(
                                                  'speciesName',
                                                  isEqualTo: _model
                                                      .selectedPlantDoc
                                                      ?.plantSpecies,
                                                ),
                                      );
                                      if (_model.selectedCustomList != null &&
                                          (_model.selectedCustomList)!
                                              .isNotEmpty) {
                                        _model.plantFacts = _model
                                            .selectedCustomList!
                                            .firstOrNull!
                                            .blurb;
                                      } else {
                                        _model.plantFacts =
                                            'No plant facts added for this custom species.';
                                      }
                                    }

                                    _model.ogPlantImage = false;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                  width: 360.0,
                                  height: 70.0,
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
                                        .primaryText,
                                    size: 24.0,
                                  ),
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  elevation: 0.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0.0,
                                  borderRadius: 0.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  hidesUnderline: true,
                                  isOverButton: true,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                  labelText: 'Select Plant',
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
                                        fontSize: 10.0,
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
                        ],
                      ),
                    ),
                  ),
                ),
                if (!_model.ogPlantImage)
                  StreamBuilder<List<PlantsRecord>>(
                    stream: queryPlantsRecord(
                      queryBuilder: (plantsRecord) => plantsRecord
                          .where(
                            'plantID',
                            isEqualTo: _model.selectedPlantDoc?.plantID,
                          )
                          .where(
                            'userCreatorID',
                            isEqualTo: currentUserUid,
                          )
                          .where(
                            'gardenCreatorRef',
                            isEqualTo: _model.selectedGardenDoc?.reference,
                          ),
                      singleRecord: true,
                    ),
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
                      List<PlantsRecord> currPlantImagePlantsRecordList =
                          snapshot.data!;
                      // Return an empty Container when the item does not exist.
                      if (snapshot.data!.isEmpty) {
                        return Container();
                      }
                      final currPlantImagePlantsRecord =
                          currPlantImagePlantsRecordList.isNotEmpty
                              ? currPlantImagePlantsRecordList.first
                              : null;

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          valueOrDefault<String>(
                            currPlantImagePlantsRecord?.plantIMGURL,
                            'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                          ),
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 240.0,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                if (_model.ogPlantImage)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.plantDoc!.plantIMGURL,
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 240.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: TabBar(
                            isScrollable: true,
                            labelColor:
                                FlutterFlowTheme.of(context).primaryText,
                            unselectedLabelColor:
                                FlutterFlowTheme.of(context).secondaryText,
                            labelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.ibmPlexMono(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                            unselectedLabelStyle: TextStyle(),
                            indicatorColor:
                                FlutterFlowTheme.of(context).primary,
                            padding: EdgeInsets.all(4.0),
                            tabs: [
                              Tab(
                                text: 'Tasks',
                              ),
                              Tab(
                                text: 'Plant Facts',
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Container(
                                              width: 350.0,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFD1F3FF),
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Today\'s Tasks',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .ibmPlexMono(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      24.0,
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
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  StreamBuilder<
                                                      List<PlantTasksRecord>>(
                                                    stream:
                                                        queryPlantTasksRecord(
                                                      queryBuilder:
                                                          (plantTasksRecord) =>
                                                              plantTasksRecord
                                                                  .where(
                                                                    'userCreatorID',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  )
                                                                  .where(
                                                                    'plantCreatorRef',
                                                                    isEqualTo:
                                                                        _model
                                                                            .plantInfoPlantID,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<PlantTasksRecord>
                                                          todayTasksListPlantTasksRecordList =
                                                          snapshot.data!;

                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            todayTasksListPlantTasksRecordList
                                                                .length,
                                                            (todayTasksListIndex) {
                                                          final todayTasksListPlantTasksRecord =
                                                              todayTasksListPlantTasksRecordList[
                                                                  todayTasksListIndex];
                                                          return Visibility(
                                                            visible: functions.checkToday(
                                                                todayTasksListPlantTasksRecord
                                                                    .startDate!,
                                                                todayTasksListPlantTasksRecord
                                                                    .frequencyNum,
                                                                todayTasksListPlantTasksRecord
                                                                    .frequencyType),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Theme(
                                                                  data:
                                                                      ThemeData(
                                                                    checkboxTheme:
                                                                        CheckboxThemeData(
                                                                      visualDensity:
                                                                          VisualDensity
                                                                              .compact,
                                                                      materialTapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(4.0),
                                                                      ),
                                                                    ),
                                                                    unselectedWidgetColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                  ),
                                                                  child:
                                                                      Checkbox(
                                                                    value: _model
                                                                            .checkboxValueMap[todayTasksListPlantTasksRecord] ??=
                                                                        todayTasksListPlantTasksRecord
                                                                            .completedToday,
                                                                    onChanged:
                                                                        (newValue) async {
                                                                      safeSetState(() =>
                                                                          _model.checkboxValueMap[todayTasksListPlantTasksRecord] =
                                                                              newValue!);
                                                                      if (newValue!) {
                                                                        await todayTasksListPlantTasksRecord
                                                                            .reference
                                                                            .update(createPlantTasksRecordData(
                                                                          completedToday:
                                                                              true,
                                                                        ));
                                                                      } else {
                                                                        await todayTasksListPlantTasksRecord
                                                                            .reference
                                                                            .update(createPlantTasksRecordData(
                                                                          completedToday:
                                                                              false,
                                                                        ));
                                                                      }
                                                                    },
                                                                    side: (FlutterFlowTheme.of(context).secondaryText !=
                                                                            null)
                                                                        ? BorderSide(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                          )
                                                                        : null,
                                                                    activeColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .accent1,
                                                                    checkColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .info,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  todayTasksListPlantTasksRecord
                                                                      .objective,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 10.0, 10.0, 10.0),
                                            child: Container(
                                              width: 350.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Upcoming Tasks',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .ibmPlexMono(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      24.0,
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
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  StreamBuilder<
                                                      List<PlantTasksRecord>>(
                                                    stream:
                                                        queryPlantTasksRecord(
                                                      queryBuilder:
                                                          (plantTasksRecord) =>
                                                              plantTasksRecord
                                                                  .where(
                                                                    'userCreatorID',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  )
                                                                  .where(
                                                                    'plantCreatorRef',
                                                                    isEqualTo: _model
                                                                        .selectedPlantDoc
                                                                        ?.reference,
                                                                  ),
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Center(
                                                          child: SizedBox(
                                                            width: 50.0,
                                                            height: 50.0,
                                                            child:
                                                                CircularProgressIndicator(
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                      Color>(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      List<PlantTasksRecord>
                                                          upcomingTasksListPlantTasksRecordList =
                                                          snapshot.data!;

                                                      return Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                            upcomingTasksListPlantTasksRecordList
                                                                .length,
                                                            (upcomingTasksListIndex) {
                                                          final upcomingTasksListPlantTasksRecord =
                                                              upcomingTasksListPlantTasksRecordList[
                                                                  upcomingTasksListIndex];
                                                          return Visibility(
                                                            visible: !functions.checkToday(
                                                                upcomingTasksListPlantTasksRecord
                                                                    .startDate!,
                                                                upcomingTasksListPlantTasksRecord
                                                                    .frequencyNum,
                                                                upcomingTasksListPlantTasksRecord
                                                                    .frequencyType),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          30.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    upcomingTasksListPlantTasksRecord
                                                                        .objective,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                          lineHeight:
                                                                              2.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0.9, 0.95),
                                    child: FlutterFlowIconButton(
                                      borderColor:
                                          FlutterFlowTheme.of(context).primary,
                                      borderRadius: 50.0,
                                      borderWidth: 1.0,
                                      buttonSize: 50.0,
                                      fillColor: Color(0xFF157145),
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        context.pushNamed(
                                            AddPlantTaskWidget.routeName);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        _model.plantFacts,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 22.0,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
