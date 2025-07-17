import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/tour_g_m1_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_search/text_search.dart';
import 'tabs_model.dart';
export 'tabs_model.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({
    super.key,
    int? parameterIndex,
    bool? onTour,
  })  : this.parameterIndex = parameterIndex ?? 0,
        this.onTour = onTour ?? false;

  final int parameterIndex;
  final bool onTour;

  static String routeName = 'Tabs';
  static String routePath = '/tabs';

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> with TickerProviderStateMixin {
  late TabsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TabsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {
        _model.tabBarController1!.animateTo(
          0,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });

      _model.userGardens = await queryGardensRecordOnce(
        queryBuilder: (gardensRecord) => gardensRecord.where(
          'uid',
          isEqualTo: currentUserUid,
        ),
      );
      _model.todayPlantTasks = await queryPlantTasksRecordOnce();
      _model.todayGardenTasks = await queryGardenTasksRecordOnce();
      if (widget.onTour) {
        await showDialog(
          barrierColor: Color(0x35000000),
          barrierDismissible: false,
          context: context,
          builder: (dialogContext) {
            return Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              alignment: AlignmentDirectional(0.0, 0.0)
                  .resolve(Directionality.of(context)),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(dialogContext).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: TourGM1Widget(),
              ),
            );
          },
        );
      }
    });

    _model.tabBarController1 = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.tabBarController2 = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  if (currentUserEmail != '') {
                    return Visibility(
                      visible:
                          currentUserEmail != '',
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment(0.0, 0),
                                  child: TabBar(
                                    labelColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    unselectedLabelColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.ibmPlexMono(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 15.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                    unselectedLabelStyle: TextStyle(),
                                    indicatorColor:
                                        FlutterFlowTheme.of(context).primary,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 150.0, 0.0, 0.0),
                                    tabs: [
                                      Tab(
                                        text: 'Gardens',
                                      ),
                                      Tab(
                                        text: 'Tasks',
                                      ),
                                      Tab(
                                        text: 'Plants',
                                      ),
                                    ],
                                    controller: _model.tabBarController1,
                                    onTap: (i) async {
                                      [
                                        () async {},
                                        () async {},
                                        () async {}
                                      ][i]();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _model.tabBarController1,
                                    children: [
                                      KeepAliveWidgetWrapper(
                                        builder: (context) =>
                                            SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        30.0, 10.0, 30.0, 0.0),
                                                child: TextFormField(
                                                  controller:
                                                      _model.textController1,
                                                  focusNode: _model
                                                      .textFieldFocusNode1,
                                                  onFieldSubmitted: (_) async {
                                                    await queryGardensRecordOnce()
                                                        .then(
                                                          (records) => _model
                                                                  .simpleSearchResults1 =
                                                              TextSearch(
                                                            records
                                                                .map(
                                                                  (record) => TextSearchItem
                                                                      .fromTerms(
                                                                          record,
                                                                          [
                                                                        record
                                                                            .gardenName
                                                                      ]),
                                                                )
                                                                .toList(),
                                                          )
                                                                  .search(_model
                                                                      .textController1
                                                                      .text)
                                                                  .map((r) =>
                                                                      r.object)
                                                                  .toList(),
                                                        )
                                                        .onError((_, __) =>
                                                            _model.simpleSearchResults1 =
                                                                [])
                                                        .whenComplete(() =>
                                                            safeSetState(
                                                                () {}));

                                                    _model.showAllGardens =
                                                        false;
                                                    safeSetState(() {});
                                                  },
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Search Gardens...',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .ibmPlexMono(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
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
                                                    hintStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .override(
                                                              font: GoogleFonts
                                                                  .ibmPlexMono(
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                              letterSpacing:
                                                                  0.0,
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
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 2.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFEDF7FF),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .ibmPlexMono(
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
                                                      .textController1Validator
                                                      .asValidator(context),
                                                ),
                                              ),
                                              Builder(
                                                builder: (context) {
                                                  if (_model.showAllGardens ==
                                                      true) {
                                                    return Align(
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
                                                        child: StreamBuilder<
                                                            List<
                                                                GardensRecord>>(
                                                          stream:
                                                              queryGardensRecord(
                                                            queryBuilder:
                                                                (gardensRecord) =>
                                                                    gardensRecord
                                                                        .where(
                                                              'uid',
                                                              isEqualTo:
                                                                  currentUserUid,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            List<GardensRecord>
                                                                columnGardensRecordList =
                                                                snapshot.data!;

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: List.generate(
                                                                  columnGardensRecordList
                                                                      .length,
                                                                  (columnIndex) {
                                                                final columnGardensRecord =
                                                                    columnGardensRecordList[
                                                                        columnIndex];
                                                                return Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          -0.44),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          350.0,
                                                                      height:
                                                                          150.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(24.0),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 60.0),
                                                                              child: Text(
                                                                                columnGardensRecord.gardenName.maybeHandleOverflow(
                                                                                  maxChars: 12,
                                                                                  replacement: '…',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                '${columnGardensRecord.numPlants.toString()} Plants'.maybeHandleOverflow(
                                                                                  maxChars: 15,
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFFA1A1A1),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, -1.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    EditGardenWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'gardenDocParam': serializeParam(
                                                                                        columnGardensRecord,
                                                                                        ParamType.Document,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      'gardenDocParam': columnGardensRecord,
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.mode_edit,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 24.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.network(
                                                                                valueOrDefault<String>(
                                                                                  columnGardensRecord.imageurl,
                                                                                  'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                                                                                ),
                                                                                width: 170.0,
                                                                                height: 300.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 60.0, 0.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    ViewGardenWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'gardenRef': serializeParam(
                                                                                        columnGardensRecord.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                text: 'View Details',
                                                                                options: FFButtonOptions(
                                                                                  width: 95.0,
                                                                                  height: 30.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.ibmPlexMono(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
                                                                                        fontSize: 8.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                  elevation: 3.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(24.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).divide(SizedBox(
                                                                  height:
                                                                      10.0)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Align(
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
                                                        child: StreamBuilder<
                                                            List<
                                                                GardensRecord>>(
                                                          stream:
                                                              queryGardensRecord(
                                                            queryBuilder: (gardensRecord) => gardensRecord
                                                                .whereIn(
                                                                    'gardenName',
                                                                    _model
                                                                        .simpleSearchResults1
                                                                        .map((e) =>
                                                                            e.gardenName)
                                                                        .toList())
                                                                .where(
                                                                  'uid',
                                                                  isEqualTo:
                                                                      currentUserUid,
                                                                ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            List<GardensRecord>
                                                                columnGardensRecordList =
                                                                snapshot.data!;

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: List.generate(
                                                                  columnGardensRecordList
                                                                      .length,
                                                                  (columnIndex) {
                                                                final columnGardensRecord =
                                                                    columnGardensRecordList[
                                                                        columnIndex];
                                                                return Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          -0.44),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          350.0,
                                                                      height:
                                                                          150.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(24.0),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 60.0),
                                                                              child: Text(
                                                                                columnGardensRecord.gardenName.maybeHandleOverflow(
                                                                                  maxChars: 12,
                                                                                  replacement: '…',
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                '${columnGardensRecord.numPlants.toString()} Plants'.maybeHandleOverflow(
                                                                                  maxChars: 15,
                                                                                  replacement: '…',
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFFA1A1A1),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, -1.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    EditGardenWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'gardenDocParam': serializeParam(
                                                                                        columnGardensRecord,
                                                                                        ParamType.Document,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      'gardenDocParam': columnGardensRecord,
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.mode_edit,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 24.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.network(
                                                                                valueOrDefault<String>(
                                                                                  columnGardensRecord.imageurl,
                                                                                  'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                                                                                ),
                                                                                width: 170.0,
                                                                                height: 300.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 60.0, 0.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    ViewGardenWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'gardenRef': serializeParam(
                                                                                        columnGardensRecord.reference,
                                                                                        ParamType.DocumentReference,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                text: 'View Details',
                                                                                options: FFButtonOptions(
                                                                                  width: 100.0,
                                                                                  height: 30.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.ibmPlexMono(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
                                                                                        fontSize: 8.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                  elevation: 0.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(24.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }).divide(SizedBox(
                                                                  height:
                                                                      10.0)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      KeepAliveWidgetWrapper(
                                        builder: (context) => Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Container(
                                                width: 350.0,
                                                constraints: BoxConstraints(
                                                  minHeight: 400.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFD1F3FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          24.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, -1.0),
                                                  child: StreamBuilder<
                                                      List<GardensRecord>>(
                                                    stream: queryGardensRecord(
                                                      queryBuilder:
                                                          (gardensRecord) =>
                                                              gardensRecord
                                                                  .where(
                                                        'uid',
                                                        isEqualTo:
                                                            currentUserUid,
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
                                                      List<GardensRecord>
                                                          columnGardensRecordList =
                                                          snapshot.data!;

                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: List.generate(
                                                              columnGardensRecordList
                                                                  .length,
                                                              (columnIndex) {
                                                            final columnGardensRecord =
                                                                columnGardensRecordList[
                                                                    columnIndex];
                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          30.0,
                                                                          15.0,
                                                                          0.0,
                                                                          15.0),
                                                                      child:
                                                                          Text(
                                                                        columnGardensRecord
                                                                            .gardenName
                                                                            .maybeHandleOverflow(
                                                                          maxChars:
                                                                              18,
                                                                          replacement:
                                                                              '…',
                                                                        ),
                                                                        maxLines:
                                                                            1,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.ibmPlexMono(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 24.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  if (!((_model
                                                                          .todayPlantTasks!
                                                                          .where((e) =>
                                                                              (columnGardensRecord.reference == e.gardenCreatorRef) &&
                                                                              functions.checkToday(
                                                                                  e
                                                                                      .startDate!,
                                                                                  e
                                                                                      .frequencyNum,
                                                                                  e
                                                                                      .frequencyType))
                                                                          .toList()
                                                                          .isNotEmpty) ||
                                                                      (_model
                                                                          .todayGardenTasks!
                                                                          .where((e) =>
                                                                              (columnGardensRecord.reference == e.gardenCreatorRef) &&
                                                                              functions.checkToday(e.startDate!, e.frequencyNum, e.frequencyType))
                                                                          .toList()
                                                                          .isNotEmpty)))
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          AutoSizeText(
                                                                        'No Tasks Today for ${columnGardensRecord.gardenName}',
                                                                        maxLines:
                                                                            1,
                                                                        minFontSize:
                                                                            8.0,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.ibmPlexMono(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            GardenTasksRecord>>(
                                                                      stream:
                                                                          queryGardenTasksRecord(
                                                                        queryBuilder: (gardenTasksRecord) => gardenTasksRecord
                                                                            .where(
                                                                              'uid',
                                                                              isEqualTo: columnGardensRecord.uid,
                                                                            )
                                                                            .where(
                                                                              'gardenCreatorRef',
                                                                              isEqualTo: columnGardensRecord.reference,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<GardenTasksRecord>
                                                                            todayTasksListGardenTasksRecordList =
                                                                            snapshot.data!;

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              todayTasksListGardenTasksRecordList.length,
                                                                              (todayTasksListIndex) {
                                                                            final todayTasksListGardenTasksRecord =
                                                                                todayTasksListGardenTasksRecordList[todayTasksListIndex];
                                                                            return Visibility(
                                                                              visible: functions.checkToday(todayTasksListGardenTasksRecord.startDate!, todayTasksListGardenTasksRecord.frequencyNum, todayTasksListGardenTasksRecord.frequencyType),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Theme(
                                                                                    data: ThemeData(
                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                        visualDensity: VisualDensity.compact,
                                                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                        ),
                                                                                      ),
                                                                                      unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                    ),
                                                                                    child: Checkbox(
                                                                                      value: _model.checkboxValueMap1[todayTasksListGardenTasksRecord] ??= todayTasksListGardenTasksRecord.completedToday,
                                                                                      onChanged: (newValue) async {
                                                                                        safeSetState(() => _model.checkboxValueMap1[todayTasksListGardenTasksRecord] = newValue!);
                                                                                        if (newValue!) {
                                                                                          await todayTasksListGardenTasksRecord.reference.update(createGardenTasksRecordData(
                                                                                            completedToday: true,
                                                                                          ));
                                                                                        } else {
                                                                                          await todayTasksListGardenTasksRecord.reference.update(createGardenTasksRecordData(
                                                                                            completedToday: false,
                                                                                          ));
                                                                                        }
                                                                                      },
                                                                                      side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                          ? BorderSide(
                                                                                              width: 2,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            )
                                                                                          : null,
                                                                                      activeColor: FlutterFlowTheme.of(context).accent1,
                                                                                      checkColor: FlutterFlowTheme.of(context).info,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    todayTasksListGardenTasksRecord.objective.maybeHandleOverflow(
                                                                                      maxChars: 30,
                                                                                      replacement: '…',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: StreamBuilder<
                                                                        List<
                                                                            PlantTasksRecord>>(
                                                                      stream:
                                                                          queryPlantTasksRecord(
                                                                        queryBuilder: (plantTasksRecord) => plantTasksRecord
                                                                            .where(
                                                                              'userCreatorID',
                                                                              isEqualTo: currentUserUid,
                                                                            )
                                                                            .where(
                                                                              'gardenCreatorRef',
                                                                              isEqualTo: columnGardensRecord.reference,
                                                                            ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        List<PlantTasksRecord>
                                                                            todayTasksListPlantTasksRecordList =
                                                                            snapshot.data!;

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              todayTasksListPlantTasksRecordList.length,
                                                                              (todayTasksListIndex) {
                                                                            final todayTasksListPlantTasksRecord =
                                                                                todayTasksListPlantTasksRecordList[todayTasksListIndex];
                                                                            return Visibility(
                                                                              visible: functions.checkToday(todayTasksListPlantTasksRecord.startDate!, todayTasksListPlantTasksRecord.frequencyNum, todayTasksListPlantTasksRecord.frequencyType),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Theme(
                                                                                    data: ThemeData(
                                                                                      checkboxTheme: CheckboxThemeData(
                                                                                        visualDensity: VisualDensity.compact,
                                                                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                        shape: RoundedRectangleBorder(
                                                                                          borderRadius: BorderRadius.circular(4.0),
                                                                                        ),
                                                                                      ),
                                                                                      unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                    ),
                                                                                    child: Checkbox(
                                                                                      value: _model.checkboxValueMap2[todayTasksListPlantTasksRecord] ??= todayTasksListPlantTasksRecord.completedToday,
                                                                                      onChanged: (newValue) async {
                                                                                        safeSetState(() => _model.checkboxValueMap2[todayTasksListPlantTasksRecord] = newValue!);
                                                                                        if (newValue!) {
                                                                                          await todayTasksListPlantTasksRecord.reference.update(createPlantTasksRecordData(
                                                                                            completedToday: true,
                                                                                          ));
                                                                                        } else {
                                                                                          await todayTasksListPlantTasksRecord.reference.update(createPlantTasksRecordData(
                                                                                            completedToday: false,
                                                                                          ));
                                                                                        }
                                                                                      },
                                                                                      side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                          ? BorderSide(
                                                                                              width: 2,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                            )
                                                                                          : null,
                                                                                      activeColor: FlutterFlowTheme.of(context).accent1,
                                                                                      checkColor: FlutterFlowTheme.of(context).info,
                                                                                    ),
                                                                                  ),
                                                                                  StreamBuilder<PlantsRecord>(
                                                                                    stream: PlantsRecord.getDocument(todayTasksListPlantTasksRecord.plantCreatorRef!),
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

                                                                                      final textPlantsRecord = snapshot.data!;

                                                                                      return Text(
                                                                                        '${textPlantsRecord.plantID}: ${todayTasksListPlantTasksRecord.objective}'.maybeHandleOverflow(
                                                                                          maxChars: 30,
                                                                                          replacement: '…',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          }),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  if ((_model
                                                                          .todayPlantTasks!
                                                                          .where((e) =>
                                                                              columnGardensRecord.reference ==
                                                                              e
                                                                                  .gardenCreatorRef)
                                                                          .toList()
                                                                          .isNotEmpty) ||
                                                                      (_model
                                                                          .todayGardenTasks!
                                                                          .where((e) =>
                                                                              columnGardensRecord.reference ==
                                                                              e.gardenCreatorRef)
                                                                          .toList()
                                                                          .isNotEmpty))
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          context
                                                                              .pushNamed(
                                                                            EditTaskMenuWidget.routeName,
                                                                            queryParameters:
                                                                                {
                                                                              'gardenRef': serializeParam(
                                                                                columnGardensRecord.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        },
                                                                        text:
                                                                            'Edit Task for ${columnGardensRecord.gardenName}',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          height:
                                                                              30.0,
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              24.0,
                                                                              0.0,
                                                                              24.0,
                                                                              0.0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                font: GoogleFonts.ibmPlexMono(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                          elevation:
                                                                              3.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ].addToEnd(
                                                                    SizedBox(
                                                                        height:
                                                                            15.0)),
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      KeepAliveWidgetWrapper(
                                        builder: (context) => Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(30.0, 10.0,
                                                          30.0, 0.0),
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController2,
                                                    focusNode: _model
                                                        .textFieldFocusNode2,
                                                    onFieldSubmitted:
                                                        (_) async {
                                                      await queryPlantsRecordOnce()
                                                          .then(
                                                            (records) => _model
                                                                    .simpleSearchResults2 =
                                                                TextSearch(
                                                              records
                                                                  .map(
                                                                    (record) =>
                                                                        TextSearchItem.fromTerms(
                                                                            record,
                                                                            [
                                                                          record
                                                                              .plantID
                                                                        ]),
                                                                  )
                                                                  .toList(),
                                                            )
                                                                    .search(_model
                                                                        .textController2
                                                                        .text)
                                                                    .map((r) =>
                                                                        r.object)
                                                                    .toList(),
                                                          )
                                                          .onError((_, __) =>
                                                              _model.simpleSearchResults2 =
                                                                  [])
                                                          .whenComplete(() =>
                                                              safeSetState(
                                                                  () {}));

                                                      _model.showAllPlants =
                                                          false;
                                                      safeSetState(() {});
                                                    },
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Search Plants...',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .ibmPlexMono(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .ibmPlexMono(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF00ADEA),
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xFFEDF7FF),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .ibmPlexMono(
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
                                                        .textController2Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    if (_model.showAllPlants ==
                                                        true) {
                                                      return StreamBuilder<
                                                          List<PlantsRecord>>(
                                                        stream:
                                                            queryPlantsRecord(
                                                          queryBuilder:
                                                              (plantsRecord) =>
                                                                  plantsRecord
                                                                      .where(
                                                            'userCreatorID',
                                                            isEqualTo:
                                                                currentUserUid,
                                                          ),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
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
                                                          List<PlantsRecord>
                                                              columnPlantsRecordList =
                                                              snapshot.data!;

                                                          return Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                columnPlantsRecordList
                                                                    .length,
                                                                (columnIndex) {
                                                              final columnPlantsRecord =
                                                                  columnPlantsRecordList[
                                                                      columnIndex];
                                                              return Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -0.44),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        350.0,
                                                                    height:
                                                                        150.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                    ),
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                200.0,
                                                                                0.0,
                                                                                0.0,
                                                                                60.0),
                                                                            child:
                                                                                Text(
                                                                              columnPlantsRecord.plantID.maybeHandleOverflow(
                                                                                maxChars: 12,
                                                                                replacement: '…',
                                                                              ),
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.ibmPlexMono(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 16.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                200.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              columnPlantsRecord.plantSpecies.maybeHandleOverflow(
                                                                                maxChars: 12,
                                                                                replacement: '…',
                                                                              ),
                                                                              maxLines: 1,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.ibmPlexMono(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: Color(0xFFA1A1A1),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                200.0,
                                                                                60.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                context.pushNamed(
                                                                                  PlantInfoWidget.routeName,
                                                                                  queryParameters: {
                                                                                    'plantDoc': serializeParam(
                                                                                      columnPlantsRecord,
                                                                                      ParamType.Document,
                                                                                    ),
                                                                                  }.withoutNulls,
                                                                                  extra: <String, dynamic>{
                                                                                    'plantDoc': columnPlantsRecord,
                                                                                  },
                                                                                );
                                                                              },
                                                                              text: 'View Details',
                                                                              options: FFButtonOptions(
                                                                                width: 95.0,
                                                                                height: 30.0,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                      color: Colors.white,
                                                                                      fontSize: 8.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                elevation: 3.0,
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.transparent,
                                                                                  width: 1.0,
                                                                                ),
                                                                                borderRadius: BorderRadius.circular(24.0),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                columnPlantsRecord.plantIMGURL,
                                                                                'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                                                                              ),
                                                                              width: 170.0,
                                                                              height: 200.0,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              -1.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                10.0,
                                                                                10.0,
                                                                                0.0),
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                context.pushNamed(
                                                                                  EditPlantWidget.routeName,
                                                                                  queryParameters: {
                                                                                    'plantDoc': serializeParam(
                                                                                      columnPlantsRecord,
                                                                                      ParamType.Document,
                                                                                    ),
                                                                                  }.withoutNulls,
                                                                                  extra: <String, dynamic>{
                                                                                    'plantDoc': columnPlantsRecord,
                                                                                  },
                                                                                );
                                                                              },
                                                                              child: Icon(
                                                                                Icons.mode_edit,
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                size: 24.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        },
                                                      );
                                                    } else {
                                                      return Align(
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
                                                          child: StreamBuilder<
                                                              List<
                                                                  PlantsRecord>>(
                                                            stream:
                                                                queryPlantsRecord(
                                                              queryBuilder: (plantsRecord) => plantsRecord
                                                                  .whereIn(
                                                                      'plantID',
                                                                      _model
                                                                          .simpleSearchResults2
                                                                          .map((e) =>
                                                                              e.plantID)
                                                                          .toList())
                                                                  .where(
                                                                    'userCreatorID',
                                                                    isEqualTo:
                                                                        currentUserUid,
                                                                  ),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
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
                                                              List<PlantsRecord>
                                                                  columnPlantsRecordList =
                                                                  snapshot
                                                                      .data!;

                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: List.generate(
                                                                    columnPlantsRecordList
                                                                        .length,
                                                                    (columnIndex) {
                                                                  final columnPlantsRecord =
                                                                      columnPlantsRecordList[
                                                                          columnIndex];
                                                                  return Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            -0.44),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            350.0,
                                                                        height:
                                                                            150.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(24.0),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 60.0),
                                                                                child: Text(
                                                                                  columnPlantsRecord.plantID.maybeHandleOverflow(
                                                                                    maxChars: 12,
                                                                                    replacement: '…',
                                                                                  ),
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.ibmPlexMono(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        fontSize: 16.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  columnPlantsRecord.plantSpecies.maybeHandleOverflow(
                                                                                    maxChars: 12,
                                                                                    replacement: '…',
                                                                                  ),
                                                                                  maxLines: 1,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.ibmPlexMono(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFFA1A1A1),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(1.0, -1.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    context.pushNamed(
                                                                                      EditPlantWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'plantDoc': serializeParam(
                                                                                          columnPlantsRecord,
                                                                                          ParamType.Document,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                      extra: <String, dynamic>{
                                                                                        'plantDoc': columnPlantsRecord,
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                  child: Icon(
                                                                                    Icons.mode_edit,
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    size: 24.0,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: ClipRRect(
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                                child: Image.network(
                                                                                  valueOrDefault<String>(
                                                                                    columnPlantsRecord.plantIMGURL,
                                                                                    'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                                                                                  ),
                                                                                  width: 170.0,
                                                                                  height: 300.0,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(200.0, 60.0, 0.0, 0.0),
                                                                                child: FFButtonWidget(
                                                                                  onPressed: () async {
                                                                                    context.pushNamed(
                                                                                      ViewGardenWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'gardenRef': serializeParam(
                                                                                          columnPlantsRecord.gardenCreatorRef,
                                                                                          ParamType.DocumentReference,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  text: 'View Details',
                                                                                  options: FFButtonOptions(
                                                                                    width: 100.0,
                                                                                    height: 30.0,
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                    color: FlutterFlowTheme.of(context).secondary,
                                                                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.ibmPlexMono(
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: Colors.white,
                                                                                          fontSize: 8.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    elevation: 3.0,
                                                                                    borderSide: BorderSide(
                                                                                      color: Colors.transparent,
                                                                                      width: 1.0,
                                                                                    ),
                                                                                    borderRadius: BorderRadius.circular(24.0),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }).divide(SizedBox(
                                                                    height:
                                                                        10.0)),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ].divide(SizedBox(height: 10.0)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.9, 0.95),
                            child: FlutterFlowIconButton(
                              borderColor: FlutterFlowTheme.of(context).primary,
                              borderRadius: 50.0,
                              borderWidth: 1.0,
                              buttonSize: 50.0,
                              fillColor: Color(0xFF157145),
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                if (_model.tabBarCurrentIndex1 == 0) {
                                  context.pushNamed(AddGardenWidget.routeName);
                                } else {
                                  if (_model.tabBarCurrentIndex1 == 1) {
                                    if (_model.userGardens != null &&
                                        (_model.userGardens)!.isNotEmpty) {
                                      context.pushNamed(
                                          AddTaskMenuWidget.routeName);
                                    } else {
                                      context.pushNamed(
                                          CreateGardenTaskWidget.routeName);
                                    }
                                  } else {
                                    if (_model.userGardens != null &&
                                        (_model.userGardens)!.isNotEmpty) {
                                      context.pushNamed(
                                          AddPlantMenuWidget.routeName);
                                    } else {
                                      context.pushNamed(
                                          CreateGardenPlantWidget.routeName);
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 13.0, 0.0, 0.0),
                              child: Text(
                                () {
                                  if (_model.tabBarCurrentIndex1 == 0) {
                                    return 'My Gardens';
                                  } else if (_model.tabBarCurrentIndex1 == 1) {
                                    return 'My Tasks';
                                  } else {
                                    return 'My Plants';
                                  }
                                }(),
                                style: FlutterFlowTheme.of(context)
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
                                      fontSize: 32.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 80.0, 0.0, 0.0),
                              child: Text(
                                dateTimeFormat("MMMEd", getCurrentTimestamp),
                                style: FlutterFlowTheme.of(context)
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
                                      fontSize: 22.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0),
                                    child: TabBar(
                                      labelColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            font: GoogleFonts.ibmPlexMono(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleMedium
                                                      .fontStyle,
                                            ),
                                            fontSize: 15.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                      unselectedLabelStyle: TextStyle(),
                                      indicatorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 100.0, 0.0, 0.0),
                                      tabs: [
                                        Tab(
                                          text: 'Gardens',
                                        ),
                                        Tab(
                                          text: 'Tasks',
                                        ),
                                        Tab(
                                          text: 'Plants',
                                        ),
                                      ],
                                      controller: _model.tabBarController2,
                                      onTap: (i) async {
                                        [
                                          () async {},
                                          () async {},
                                          () async {}
                                        ][i]();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController2,
                                      children: [
                                        KeepAliveWidgetWrapper(
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(30.0, 10.0,
                                                          30.0, 0.0),
                                                  child: TextFormField(
                                                    controller:
                                                        _model.textController3,
                                                    focusNode: _model
                                                        .textFieldFocusNode3,
                                                    onFieldSubmitted:
                                                        (_) async {
                                                      await queryGardensRecordOnce()
                                                          .then(
                                                            (records) => _model
                                                                    .simpleSearchResults3 =
                                                                TextSearch(
                                                              records
                                                                  .map(
                                                                    (record) =>
                                                                        TextSearchItem.fromTerms(
                                                                            record,
                                                                            [
                                                                          record
                                                                              .gardenName
                                                                        ]),
                                                                  )
                                                                  .toList(),
                                                            )
                                                                    .search(_model
                                                                        .textController3
                                                                        .text)
                                                                    .map((r) =>
                                                                        r.object)
                                                                    .toList(),
                                                          )
                                                          .onError((_, __) =>
                                                              _model.simpleSearchResults3 =
                                                                  [])
                                                          .whenComplete(() =>
                                                              safeSetState(
                                                                  () {}));

                                                      _model.showAllGardens =
                                                          false;
                                                      safeSetState(() {});
                                                    },
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'Search Gardens...',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .ibmPlexMono(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .ibmPlexMono(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .fontStyle,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 2.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      filled: true,
                                                      fillColor:
                                                          Color(0xFFEDF7FF),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .ibmPlexMono(
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
                                                        .textController3Validator
                                                        .asValidator(context),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, -1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, -0.44),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Container(
                                                              width: 350.0,
                                                              height: 150.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            24.0),
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          200.0,
                                                                          0.0,
                                                                          0.0,
                                                                          60.0),
                                                                      child:
                                                                          Text(
                                                                        'Backyard'
                                                                            .maybeHandleOverflow(
                                                                          maxChars:
                                                                              12,
                                                                          replacement:
                                                                              '…',
                                                                        ),
                                                                        maxLines:
                                                                            1,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.ibmPlexMono(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          200.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        '15 Plants'
                                                                            .maybeHandleOverflow(
                                                                          maxChars:
                                                                              15,
                                                                          replacement:
                                                                              '…',
                                                                        ),
                                                                        maxLines:
                                                                            1,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.ibmPlexMono(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFFA1A1A1),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .mode_edit,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      child: Image
                                                                          .network(
                                                                        'https://images.unsplash.com/photo-1509567852316-09a353a7914a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyMHx8Z2FyZGVufGVufDB8fHx8MTcyNzg5MTg5M3ww&ixlib=rb-4.0.3&q=80&w=1080',
                                                                        width:
                                                                            170.0,
                                                                        height:
                                                                            300.0,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          200.0,
                                                                          60.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              'Button pressed ...');
                                                                        },
                                                                        text:
                                                                            'View Details',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              30.0,
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              2.0,
                                                                              0.0,
                                                                              2.0,
                                                                              0.0),
                                                                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                font: GoogleFonts.ibmPlexMono(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                                color: Colors.white,
                                                                                fontSize: 8.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                          elevation:
                                                                              3.0,
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.transparent,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(24.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        KeepAliveWidgetWrapper(
                                          builder: (context) => Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, -1.0),
                                                child: Container(
                                                  width: 350.0,
                                                  constraints: BoxConstraints(
                                                    minHeight: 400.0,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFD1F3FF),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, -1.0),
                                                    child: StreamBuilder<
                                                        List<GardensRecord>>(
                                                      stream:
                                                          queryGardensRecord(
                                                        queryBuilder:
                                                            (gardensRecord) =>
                                                                gardensRecord
                                                                    .where(
                                                          'uid',
                                                          isEqualTo:
                                                              currentUserUid,
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
                                                        List<GardensRecord>
                                                            columnGardensRecordList =
                                                            snapshot.data!;

                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: List.generate(
                                                                columnGardensRecordList
                                                                    .length,
                                                                (columnIndex) {
                                                              final columnGardensRecord =
                                                                  columnGardensRecordList[
                                                                      columnIndex];
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            30.0,
                                                                            15.0,
                                                                            0.0,
                                                                            15.0),
                                                                        child:
                                                                            Text(
                                                                          columnGardensRecord
                                                                              .gardenName
                                                                              .maybeHandleOverflow(
                                                                            maxChars:
                                                                                18,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                          maxLines:
                                                                              1,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.ibmPlexMono(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                fontSize: 24.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (!((_model
                                                                            .todayPlantTasks!
                                                                            .where((e) =>
                                                                                (columnGardensRecord.reference == e.gardenCreatorRef) &&
                                                                                functions.checkToday(e.startDate!, e.frequencyNum, e.frequencyType))
                                                                            .toList()
                                                                            .isNotEmpty) ||
                                                                        (_model.todayGardenTasks!.where((e) => (columnGardensRecord.reference == e.gardenCreatorRef) && functions.checkToday(e.startDate!, e.frequencyNum, e.frequencyType)).toList().isNotEmpty)))
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            AutoSizeText(
                                                                          'No Tasks Today for ${columnGardensRecord.gardenName}',
                                                                          maxLines:
                                                                              1,
                                                                          minFontSize:
                                                                              8.0,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.ibmPlexMono(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child: StreamBuilder<
                                                                          List<
                                                                              GardenTasksRecord>>(
                                                                        stream:
                                                                            queryGardenTasksRecord(
                                                                          queryBuilder: (gardenTasksRecord) => gardenTasksRecord
                                                                              .where(
                                                                                'uid',
                                                                                isEqualTo: columnGardensRecord.uid,
                                                                              )
                                                                              .where(
                                                                                'gardenCreatorRef',
                                                                                isEqualTo: columnGardensRecord.reference,
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                          List<GardenTasksRecord>
                                                                              todayTasksListGardenTasksRecordList =
                                                                              snapshot.data!;

                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                List.generate(todayTasksListGardenTasksRecordList.length, (todayTasksListIndex) {
                                                                              final todayTasksListGardenTasksRecord = todayTasksListGardenTasksRecordList[todayTasksListIndex];
                                                                              return Visibility(
                                                                                visible: functions.checkToday(todayTasksListGardenTasksRecord.startDate!, todayTasksListGardenTasksRecord.frequencyNum, todayTasksListGardenTasksRecord.frequencyType),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Theme(
                                                                                      data: ThemeData(
                                                                                        checkboxTheme: CheckboxThemeData(
                                                                                          visualDensity: VisualDensity.compact,
                                                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                        ),
                                                                                        unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                      ),
                                                                                      child: Checkbox(
                                                                                        value: _model.checkboxValueMap3[todayTasksListGardenTasksRecord] ??= todayTasksListGardenTasksRecord.completedToday,
                                                                                        onChanged: (newValue) async {
                                                                                          safeSetState(() => _model.checkboxValueMap3[todayTasksListGardenTasksRecord] = newValue!);
                                                                                          if (newValue!) {
                                                                                            await todayTasksListGardenTasksRecord.reference.update(createGardenTasksRecordData(
                                                                                              completedToday: true,
                                                                                            ));
                                                                                          } else {
                                                                                            await todayTasksListGardenTasksRecord.reference.update(createGardenTasksRecordData(
                                                                                              completedToday: false,
                                                                                            ));
                                                                                          }
                                                                                        },
                                                                                        side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                            ? BorderSide(
                                                                                                width: 2,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              )
                                                                                            : null,
                                                                                        activeColor: FlutterFlowTheme.of(context).accent1,
                                                                                        checkColor: FlutterFlowTheme.of(context).info,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      todayTasksListGardenTasksRecord.objective.maybeHandleOverflow(
                                                                                        maxChars: 30,
                                                                                        replacement: '…',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.inter(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child: StreamBuilder<
                                                                          List<
                                                                              PlantTasksRecord>>(
                                                                        stream:
                                                                            queryPlantTasksRecord(
                                                                          queryBuilder: (plantTasksRecord) => plantTasksRecord
                                                                              .where(
                                                                                'userCreatorID',
                                                                                isEqualTo: currentUserUid,
                                                                              )
                                                                              .where(
                                                                                'gardenCreatorRef',
                                                                                isEqualTo: columnGardensRecord.reference,
                                                                              ),
                                                                        ),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          // Customize what your widget looks like when it's loading.
                                                                          if (!snapshot
                                                                              .hasData) {
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
                                                                          List<PlantTasksRecord>
                                                                              todayTasksListPlantTasksRecordList =
                                                                              snapshot.data!;

                                                                          return Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                List.generate(todayTasksListPlantTasksRecordList.length, (todayTasksListIndex) {
                                                                              final todayTasksListPlantTasksRecord = todayTasksListPlantTasksRecordList[todayTasksListIndex];
                                                                              return Visibility(
                                                                                visible: functions.checkToday(todayTasksListPlantTasksRecord.startDate!, todayTasksListPlantTasksRecord.frequencyNum, todayTasksListPlantTasksRecord.frequencyType),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Theme(
                                                                                      data: ThemeData(
                                                                                        checkboxTheme: CheckboxThemeData(
                                                                                          visualDensity: VisualDensity.compact,
                                                                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(4.0),
                                                                                          ),
                                                                                        ),
                                                                                        unselectedWidgetColor: FlutterFlowTheme.of(context).secondaryText,
                                                                                      ),
                                                                                      child: Checkbox(
                                                                                        value: _model.checkboxValueMap4[todayTasksListPlantTasksRecord] ??= todayTasksListPlantTasksRecord.completedToday,
                                                                                        onChanged: (newValue) async {
                                                                                          safeSetState(() => _model.checkboxValueMap4[todayTasksListPlantTasksRecord] = newValue!);
                                                                                          if (newValue!) {
                                                                                            await todayTasksListPlantTasksRecord.reference.update(createPlantTasksRecordData(
                                                                                              completedToday: true,
                                                                                            ));
                                                                                          } else {
                                                                                            await todayTasksListPlantTasksRecord.reference.update(createPlantTasksRecordData(
                                                                                              completedToday: false,
                                                                                            ));
                                                                                          }
                                                                                        },
                                                                                        side: (FlutterFlowTheme.of(context).secondaryText != null)
                                                                                            ? BorderSide(
                                                                                                width: 2,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              )
                                                                                            : null,
                                                                                        activeColor: FlutterFlowTheme.of(context).accent1,
                                                                                        checkColor: FlutterFlowTheme.of(context).info,
                                                                                      ),
                                                                                    ),
                                                                                    StreamBuilder<PlantsRecord>(
                                                                                      stream: PlantsRecord.getDocument(todayTasksListPlantTasksRecord.plantCreatorRef!),
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

                                                                                        final textPlantsRecord = snapshot.data!;

                                                                                        return Text(
                                                                                          '${textPlantsRecord.plantID}: ${todayTasksListPlantTasksRecord.objective}'.maybeHandleOverflow(
                                                                                            maxChars: 30,
                                                                                            replacement: '…',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        );
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    if ((_model
                                                                            .todayPlantTasks!
                                                                            .where((e) =>
                                                                                columnGardensRecord.reference ==
                                                                                e
                                                                                    .gardenCreatorRef)
                                                                            .toList()
                                                                            .isNotEmpty) ||
                                                                        (_model
                                                                            .todayGardenTasks!
                                                                            .where((e) =>
                                                                                columnGardensRecord.reference ==
                                                                                e.gardenCreatorRef)
                                                                            .toList()
                                                                            .isNotEmpty))
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            10.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            context.pushNamed(
                                                                              EditTaskMenuWidget.routeName,
                                                                              queryParameters: {
                                                                                'gardenRef': serializeParam(
                                                                                  columnGardensRecord.reference,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          },
                                                                          text:
                                                                              'Edit Task for ${columnGardensRecord.gardenName}',
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                30.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                24.0,
                                                                                0.0,
                                                                                24.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).accent4,
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.ibmPlexMono(
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 16.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                3.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Colors.transparent,
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ].addToEnd(
                                                                      SizedBox(
                                                                          height:
                                                                              15.0)),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        KeepAliveWidgetWrapper(
                                          builder: (context) => Align(
                                            alignment:
                                                AlignmentDirectional(0.0, -1.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                30.0,
                                                                10.0,
                                                                30.0,
                                                                0.0),
                                                    child: TextFormField(
                                                      controller: _model
                                                          .textController4,
                                                      focusNode: _model
                                                          .textFieldFocusNode4,
                                                      onFieldSubmitted:
                                                          (_) async {
                                                        await queryPlantsRecordOnce()
                                                            .then(
                                                              (records) => _model
                                                                      .simpleSearchResults4 =
                                                                  TextSearch(
                                                                records
                                                                    .map(
                                                                      (record) =>
                                                                          TextSearchItem.fromTerms(
                                                                              record,
                                                                              [
                                                                            record.plantID
                                                                          ]),
                                                                    )
                                                                    .toList(),
                                                              )
                                                                      .search(_model
                                                                          .textController4
                                                                          .text)
                                                                      .map((r) =>
                                                                          r.object)
                                                                      .toList(),
                                                            )
                                                            .onError((_, __) =>
                                                                _model.simpleSearchResults4 =
                                                                    [])
                                                            .whenComplete(() =>
                                                                safeSetState(
                                                                    () {}));

                                                        _model.showAllPlants =
                                                            false;
                                                        safeSetState(() {});
                                                      },
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            'Search Plants...',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .ibmPlexMono(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .ibmPlexMono(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .fontStyle,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0xFF00ADEA),
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFEDF7FF),
                                                      ),
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
                                                      validator: _model
                                                          .textController4Validator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (_model
                                                              .showAllPlants ==
                                                          true) {
                                                        return StreamBuilder<
                                                            List<PlantsRecord>>(
                                                          stream:
                                                              queryPlantsRecord(
                                                            queryBuilder:
                                                                (plantsRecord) =>
                                                                    plantsRecord
                                                                        .where(
                                                              'userCreatorID',
                                                              isEqualTo:
                                                                  currentUserUid,
                                                            ),
                                                          ),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
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
                                                            List<PlantsRecord>
                                                                columnPlantsRecordList =
                                                                snapshot.data!;

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                  columnPlantsRecordList
                                                                      .length,
                                                                  (columnIndex) {
                                                                final columnPlantsRecord =
                                                                    columnPlantsRecordList[
                                                                        columnIndex];
                                                                return Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          -0.44),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          350.0,
                                                                      height:
                                                                          150.0,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(24.0),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 60.0),
                                                                              child: Text(
                                                                                columnPlantsRecord.plantID.maybeHandleOverflow(
                                                                                  maxChars: 12,
                                                                                  replacement: '…',
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                columnPlantsRecord.plantSpecies.maybeHandleOverflow(
                                                                                  maxChars: 12,
                                                                                  replacement: '…',
                                                                                ),
                                                                                maxLines: 1,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.ibmPlexMono(
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFFA1A1A1),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(200.0, 60.0, 0.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  context.pushNamed(
                                                                                    PlantInfoWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'plantDoc': serializeParam(
                                                                                        columnPlantsRecord,
                                                                                        ParamType.Document,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      'plantDoc': columnPlantsRecord,
                                                                                    },
                                                                                  );
                                                                                },
                                                                                text: 'View Details',
                                                                                options: FFButtonOptions(
                                                                                  width: 95.0,
                                                                                  height: 30.0,
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.ibmPlexMono(
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
                                                                                        fontSize: 8.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                      ),
                                                                                  elevation: 3.0,
                                                                                  borderSide: BorderSide(
                                                                                    color: Colors.transparent,
                                                                                    width: 1.0,
                                                                                  ),
                                                                                  borderRadius: BorderRadius.circular(24.0),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.network(
                                                                                valueOrDefault<String>(
                                                                                  columnPlantsRecord.plantIMGURL,
                                                                                  'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                                                                                ),
                                                                                width: 170.0,
                                                                                height: 200.0,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, -1.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    EditPlantWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'plantDoc': serializeParam(
                                                                                        columnPlantsRecord,
                                                                                        ParamType.Document,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                    extra: <String, dynamic>{
                                                                                      'plantDoc': columnPlantsRecord,
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Icon(
                                                                                  Icons.mode_edit,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  size: 24.0,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                            );
                                                          },
                                                        );
                                                      } else {
                                                        return Align(
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
                                                            child: StreamBuilder<
                                                                List<
                                                                    PlantsRecord>>(
                                                              stream:
                                                                  queryPlantsRecord(
                                                                queryBuilder: (plantsRecord) => plantsRecord
                                                                    .whereIn(
                                                                        'plantID',
                                                                        _model
                                                                            .simpleSearchResults4
                                                                            .map((e) =>
                                                                                e.plantID)
                                                                            .toList())
                                                                    .where(
                                                                      'userCreatorID',
                                                                      isEqualTo:
                                                                          currentUserUid,
                                                                    ),
                                                              ),
                                                              builder: (context,
                                                                  snapshot) {
                                                                // Customize what your widget looks like when it's loading.
                                                                if (!snapshot
                                                                    .hasData) {
                                                                  return Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          50.0,
                                                                      height:
                                                                          50.0,
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<PlantsRecord>
                                                                    columnPlantsRecordList =
                                                                    snapshot
                                                                        .data!;

                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: List.generate(
                                                                      columnPlantsRecordList
                                                                          .length,
                                                                      (columnIndex) {
                                                                    final columnPlantsRecord =
                                                                        columnPlantsRecordList[
                                                                            columnIndex];
                                                                    return Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              -0.44),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            10.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              350.0,
                                                                          height:
                                                                              150.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(24.0),
                                                                          ),
                                                                          child:
                                                                              Stack(
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 60.0),
                                                                                  child: Text(
                                                                                    columnPlantsRecord.plantID.maybeHandleOverflow(
                                                                                      maxChars: 12,
                                                                                      replacement: '…',
                                                                                    ),
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.ibmPlexMono(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          fontSize: 16.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(200.0, 0.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    columnPlantsRecord.plantSpecies.maybeHandleOverflow(
                                                                                      maxChars: 12,
                                                                                      replacement: '…',
                                                                                    ),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.ibmPlexMono(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFFA1A1A1),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(1.0, -1.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 10.0, 0.0),
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    focusColor: Colors.transparent,
                                                                                    hoverColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () async {
                                                                                      context.pushNamed(
                                                                                        EditPlantWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'plantDoc': serializeParam(
                                                                                            columnPlantsRecord,
                                                                                            ParamType.Document,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                        extra: <String, dynamic>{
                                                                                          'plantDoc': columnPlantsRecord,
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                    child: Icon(
                                                                                      Icons.mode_edit,
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      size: 24.0,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                  child: Image.network(
                                                                                    valueOrDefault<String>(
                                                                                      columnPlantsRecord.plantIMGURL,
                                                                                      'https://firebasestorage.googleapis.com/v0/b/plantculture-mltpm2.appspot.com/o/defaultPhotos%2FnoImageAdded.jpg?alt=media&token=21daa889-0eb6-4f66-a18a-93831ec82dae',
                                                                                    ),
                                                                                    width: 170.0,
                                                                                    height: 300.0,
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(200.0, 60.0, 0.0, 0.0),
                                                                                  child: FFButtonWidget(
                                                                                    onPressed: () async {
                                                                                      context.pushNamed(
                                                                                        ViewGardenWidget.routeName,
                                                                                        queryParameters: {
                                                                                          'gardenRef': serializeParam(
                                                                                            columnPlantsRecord.gardenCreatorRef,
                                                                                            ParamType.DocumentReference,
                                                                                          ),
                                                                                        }.withoutNulls,
                                                                                      );
                                                                                    },
                                                                                    text: 'View Details',
                                                                                    options: FFButtonOptions(
                                                                                      width: 100.0,
                                                                                      height: 30.0,
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 2.0, 0.0),
                                                                                      iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                      color: FlutterFlowTheme.of(context).secondary,
                                                                                      textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                            font: GoogleFonts.ibmPlexMono(
                                                                                              fontWeight: FontWeight.w500,
                                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                            ),
                                                                                            color: Colors.white,
                                                                                            fontSize: 8.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w500,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                      elevation: 3.0,
                                                                                      borderSide: BorderSide(
                                                                                        color: Colors.transparent,
                                                                                        width: 1.0,
                                                                                      ),
                                                                                      borderRadius: BorderRadius.circular(24.0),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }).divide(SizedBox(
                                                                      height:
                                                                          10.0)),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ].divide(
                                                    SizedBox(height: 10.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                  if (_model.tabBarCurrentIndex2 == 0) {
                                    context
                                        .pushNamed(AddGardenWidget.routeName);
                                  } else {
                                    if (_model.tabBarCurrentIndex2 == 1) {
                                      if (_model.userGardens != null &&
                                          (_model.userGardens)!.isNotEmpty) {
                                        context.pushNamed(
                                            AddTaskMenuWidget.routeName);
                                      } else {
                                        context.pushNamed(
                                            CreateGardenTaskWidget.routeName);
                                      }
                                    } else {
                                      if (_model.userGardens != null &&
                                          (_model.userGardens)!.isNotEmpty) {
                                        context.pushNamed(
                                            AddPlantMenuWidget.routeName);
                                      } else {
                                        context.pushNamed(
                                            CreateGardenPlantWidget.routeName);
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 13.0, 0.0, 0.0),
                                child: Text(
                                  'My Gardens',
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
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0.0, -1.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 80.0, 0.0, 0.0),
                                child: Text(
                                  dateTimeFormat("MMMEd", getCurrentTimestamp),
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
                                        fontSize: 22.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          decoration: BoxDecoration(
                            color: Color(0x4D242424),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 50.0, 0.0, 0.0),
                                child: Container(
                                  width: 251.0,
                                  height: 165.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 10.0),
                                        child: Text(
                                          'Log in to access My Gardens!',
                                          style: FlutterFlowTheme.of(context)
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
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
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
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 10.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                                LogInPageWidget.routeName);
                                          },
                                          text: 'sign in',
                                          options: FFButtonOptions(
                                            width: 150.0,
                                            height: 40.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24.0, 0.0, 24.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .titleSmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w300,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondary,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                            elevation: 3.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed(
                                              RegisterPageWidget.routeName);
                                        },
                                        text: 'register',
                                        options: FFButtonOptions(
                                          width: 150.0,
                                          height: 40.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontStyle,
                                                ),
                                                color: Colors.white,
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w300,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            width: 2.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
