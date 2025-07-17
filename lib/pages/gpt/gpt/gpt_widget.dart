import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/gpt/list_view_a_i/list_view_a_i_widget.dart';
import '/pages/gpt/new_logo/new_logo_widget.dart';
import '/pages/gpt/uploaded_image/uploaded_image_widget.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'gpt_model.dart';
export 'gpt_model.dart';

class GptWidget extends StatefulWidget {
  const GptWidget({
    super.key,
    bool? onTour,
  }) : this.onTour = onTour ?? false;

  final bool onTour;

  static String routeName = 'GPT';
  static String routePath = '/gpt';

  @override
  State<GptWidget> createState() => _GptWidgetState();
}

class _GptWidgetState extends State<GptWidget> with TickerProviderStateMixin {
  late GptModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  var hasListViewTriggered = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GptModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!(valueOrDefault(currentUserDocument?.threadID, '') != '')) {
        _model.apiThreadsResult = await OpenAIChatGPTGroup.threadsCall.call(
          token:
              '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',
        );

        if ((_model.apiThreadsResult?.succeeded ?? true)) {
          await currentUserReference!.update(createUsersRecordData(
            threadID: OpenAIChatGPTGroup.threadsCall.threadid(
              (_model.apiThreadsResult?.jsonBody ?? ''),
            ),
          ));
        }
      }
    });

    _model.questionTestFieldTextController ??= TextEditingController();
    _model.questionTestFieldFocusNode ??= FocusNode();

    animationsMap.addAll({
      'listViewOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: false,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'containerOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 300.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

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
          drawer: Drawer(
            elevation: 16.0,
            child: SingleChildScrollView(
              controller: _model.columnController,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 0.0,
                      height: 60.0,
                      constraints: BoxConstraints(
                        minWidth: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, -1.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 0.0),
                                    child: Text(
                                      'Chat History',
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
                                            fontSize: 30.0,
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
                          SizedBox(
                            width: 275.0,
                            child: Divider(
                              thickness: 4.0,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    height: MediaQuery.sizeOf(context).height * 0.759,
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(0.0),
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(6.0, 6.0, 6.0, 6.0),
                      child: StreamBuilder<List<AIsavedChatsRecord>>(
                        stream: queryAIsavedChatsRecord(
                          queryBuilder: (aIsavedChatsRecord) =>
                              aIsavedChatsRecord
                                  .where(
                                    'user',
                                    isEqualTo: currentUserReference,
                                  )
                                  .orderBy('date', descending: true),
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
                          List<AIsavedChatsRecord>
                              listViewAIsavedChatsRecordList = snapshot.data!;

                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listViewAIsavedChatsRecordList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 5.0),
                            itemBuilder: (context, listViewIndex) {
                              final listViewAIsavedChatsRecord =
                                  listViewAIsavedChatsRecordList[listViewIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 6.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    _model.chatHistory =
                                        listViewAIsavedChatsRecord.chatHist
                                            .toList()
                                            .cast<ContentStruct>();
                                    safeSetState(() {});
                                    FFAppState().DisplaySuggestedQuestions =
                                        false;
                                    FFAppState().AIScrollingChatHeight = 0;
                                    safeSetState(() {});
                                    _model.currentChat =
                                        listViewAIsavedChatsRecord;
                                    safeSetState(() {});
                                    Navigator.pop(context);
                                    await _model.chatListView?.animateTo(
                                      0,
                                      duration: Duration(milliseconds: 0),
                                      curve: Curves.ease,
                                    );
                                  },
                                  child: Container(
                                    width: 110.0,
                                    height: 59.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x2500ADEA),
                                      borderRadius: BorderRadius.circular(24.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                      ),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            7.0, 6.0, 7.0, 3.0),
                                        child: ListViewAIWidget(
                                          key: Key(
                                              'Keyduo_${listViewIndex}_of_${listViewAIsavedChatsRecordList.length}'),
                                          savedChatObjectJ:
                                              listViewAIsavedChatsRecord,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            controller: _model.listViewController1,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent3,
                    ),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            width: 275.0,
                            child: Divider(
                              thickness: 4.0,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 58.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Container(
                      width: 100.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 61.0,
                            height: 107.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  6.0, 6.0, 6.0, 6.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 120.0,
                                  height: 120.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    currentUserPhoto,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 171.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 0.0, 0.0, 0.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Text(
                                          currentUserDisplayName,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              context
                                  .pushNamed(AccountSettingsWidget.routeName);
                            },
                            text: '',
                            icon: Icon(
                              Icons.keyboard_control,
                              size: 27.0,
                            ),
                            options: FFButtonOptions(
                              width: 53.0,
                              height: 62.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsets.all(18.0),
                              iconColor: Colors.black,
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    fontSize: 100.0,
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
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 0.0,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(0.0),
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
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
          appBar: currentUserEmail != ''
              ? PreferredSize(
                  preferredSize: Size.fromHeight(60.0),
                  child: AppBar(
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                    iconTheme: IconThemeData(
                        color: FlutterFlowTheme.of(context).primaryText),
                    automaticallyImplyLeading: true,
                    title: Container(
                      width: double.infinity,
                      height: 100.0,
                      constraints: BoxConstraints(
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 1.0, 0.0, 0.0),
                            child: Container(
                              width: 102.0,
                              height: 103.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Align(
                                alignment: AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0.0),
                                    child: Image.network(
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/yycpavmuy9wd/applogostransparent-23.png',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment(1.0, 0.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: AnimatedDefaultTextStyle(
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
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeIn,
                              child: Text(
                                'SageAI',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Container(
                        width: 100.0,
                        height: 100.0,
                        constraints: BoxConstraints(
                          maxWidth: double.infinity,
                          maxHeight: double.infinity,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 40.0,
                              height: 100.0,
                              constraints: BoxConstraints(
                                maxWidth: double.infinity,
                                maxHeight: double.infinity,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              alignment: AlignmentDirectional(1.0, 0.0),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    _model.chatHistory = [];
                                    safeSetState(() {});
                                    FFAppState().DisplaySuggestedQuestions =
                                        true;
                                    FFAppState().AIScrollingChatHeight = 65;
                                    safeSetState(() {});
                                    _model.currentChat = null;
                                    safeSetState(() {});
                                  },
                                  text: '',
                                  icon: Icon(
                                    Icons.add_circle,
                                    size: 33.0,
                                  ),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: double.infinity,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    iconColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.inter(
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
                                    elevation: 0.0,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    centerTitle: true,
                    toolbarHeight: double.infinity,
                    elevation: 0.0,
                  ),
                )
              : null,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/blur_bg@1x.png',
                      ).image,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                          'assets/images/blur_bg@1x.png',
                        ).image,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 770.0,
                        ),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                      Container(
                                        width: 100.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 12.0, 12.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5.0,
                                              sigmaY: 4.0,
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(0.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                controller:
                                                    _model.scollingChatColumn,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final chat = _model
                                                                .chatHistory
                                                                .toList();
                                                            if (chat.isEmpty) {
                                                              return Container(
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.25,
                                                                child:
                                                                    NewLogoWidget(),
                                                              );
                                                            }

                                                            return ListView
                                                                .separated(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                0,
                                                                16.0,
                                                                0,
                                                                16.0,
                                                              ),
                                                              primary: false,
                                                              shrinkWrap: true,
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              itemCount:
                                                                  chat.length,
                                                              separatorBuilder: (_,
                                                                      __) =>
                                                                  SizedBox(
                                                                      height:
                                                                          16.0),
                                                              itemBuilder:
                                                                  (context,
                                                                      chatIndex) {
                                                                final chatItem =
                                                                    chat[
                                                                        chatIndex];
                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if ((int
                                                                        index) {
                                                                      return index %
                                                                              2 !=
                                                                          0;
                                                                    }(chatIndex))
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Container(
                                                                                constraints: BoxConstraints(
                                                                                  maxWidth: () {
                                                                                    if (MediaQuery.sizeOf(context).width >= 1170.0) {
                                                                                      return 700.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width <= 470.0) {
                                                                                      return 330.0;
                                                                                    } else {
                                                                                      return 530.0;
                                                                                    }
                                                                                  }(),
                                                                                ),
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFDDDDDD),
                                                                                  boxShadow: [
                                                                                    BoxShadow(
                                                                                      blurRadius: 3.0,
                                                                                      color: Color(0x33000000),
                                                                                      offset: Offset(
                                                                                        0.0,
                                                                                        1.0,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                  borderRadius: BorderRadius.circular(12.0),
                                                                                  border: Border.all(
                                                                                    color: Color(0xFF393939),
                                                                                    width: 1.0,
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(12.0),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        constraints: BoxConstraints(
                                                                                          maxWidth: () {
                                                                                            if (MediaQuery.sizeOf(context).width >= 1170.0) {
                                                                                              return 700.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width <= 470.0) {
                                                                                              return 245.0;
                                                                                            } else {
                                                                                              return 530.0;
                                                                                            }
                                                                                          }(),
                                                                                        ),
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFDDDDDD),
                                                                                        ),
                                                                                        child: MarkdownBody(
                                                                                          data: chatItem.text.value,
                                                                                          selectable: true,
                                                                                          onTapLink: (_, url, __) => launchURL(url!),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation1']!),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    await Clipboard.setData(ClipboardData(text: chatItem.text.value));
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: Text(
                                                                                          'Response copied to clipboard.',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.inter(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                        duration: Duration(milliseconds: 2000),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                        child: Icon(
                                                                                          Icons.content_copy,
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          size: 10.0,
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        'Copy response',
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.inter(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                              fontSize: 10.0,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    if (chatIndex %
                                                                            2 ==
                                                                        0)
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Container(
                                                                            constraints:
                                                                                BoxConstraints(
                                                                              maxWidth: () {
                                                                                if (MediaQuery.sizeOf(context).width >= 1170.0) {
                                                                                  return 700.0;
                                                                                } else if (MediaQuery.sizeOf(context).width <= 470.0) {
                                                                                  return 330.0;
                                                                                } else {
                                                                                  return 530.0;
                                                                                }
                                                                              }(),
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xFFB4ECFF),
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsets.all(12.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    chatItem.text.value,
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
                                                                            ),
                                                                          ).animateOnPageLoad(
                                                                              animationsMap['containerOnPageLoadAnimation2']!),
                                                                        ],
                                                                      ),
                                                                  ],
                                                                );
                                                              },
                                                              controller: _model
                                                                  .chatListView,
                                                            ).animateOnActionTrigger(
                                                                animationsMap[
                                                                    'listViewOnActionTriggerAnimation']!,
                                                                hasBeenTriggered:
                                                                    hasListViewTriggered);
                                                          },
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Container(
                                width: 100.0,
                                height: 60.0,
                                decoration: BoxDecoration(),
                              ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(),
                            ),
                            if (FFAppState().DisplaySuggestedQuestions)
                              Align(
                                alignment: AlignmentDirectional(0.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 5.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: Visibility(
                                      visible: FFAppState()
                                          .DisplaySuggestedQuestions,
                                      child: Builder(
                                        builder: (context) {
                                          if (FFAppState()
                                              .DisplaySuggestedQuestions) {
                                            return StreamBuilder<
                                                List<AIsuggestedQsRecord>>(
                                              stream: queryAIsuggestedQsRecord(
                                                queryBuilder:
                                                    (aIsuggestedQsRecord) =>
                                                        aIsuggestedQsRecord
                                                            .orderBy('Order'),
                                                limit: 5,
                                              ),
                                              builder: (context, snapshot) {
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
                                                List<AIsuggestedQsRecord>
                                                    listViewAIsuggestedQsRecordList =
                                                    snapshot.data!;

                                                return ListView.separated(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      listViewAIsuggestedQsRecordList
                                                          .length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(width: 12.0),
                                                  itemBuilder:
                                                      (context, listViewIndex) {
                                                    final listViewAIsuggestedQsRecord =
                                                        listViewAIsuggestedQsRecordList[
                                                            listViewIndex];
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
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
                                                          if (listViewAIsuggestedQsRecord
                                                                      .image !=
                                                                  '') {
                                                            _model.uploadedImages =
                                                                [];
                                                            _model.addToUploadedImages(
                                                                listViewAIsuggestedQsRecord
                                                                    .image);
                                                            safeSetState(() {});
                                                            safeSetState(() {
                                                              _model.questionTestFieldTextController
                                                                      ?.text =
                                                                  listViewAIsuggestedQsRecord
                                                                      .question;
                                                            });
                                                          } else {
                                                            safeSetState(() {
                                                              _model.questionTestFieldTextController
                                                                      ?.text =
                                                                  listViewAIsuggestedQsRecord
                                                                      .question;
                                                            });
                                                            _model.uploadedImages =
                                                                [];
                                                            safeSetState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 245.0,
                                                            maxHeight: 170.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0x2500ADEA),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              if (listViewAIsuggestedQsRecord
                                                                          .image !=
                                                                      '')
                                                                Flexible(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        maxWidth:
                                                                            100.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              4.0,
                                                                              8.0,
                                                                              2.0,
                                                                              7.0),
                                                                          child:
                                                                              InkWell(
                                                                            splashColor:
                                                                                Colors.transparent,
                                                                            focusColor:
                                                                                Colors.transparent,
                                                                            hoverColor:
                                                                                Colors.transparent,
                                                                            highlightColor:
                                                                                Colors.transparent,
                                                                            onTap:
                                                                                () async {
                                                                              if (listViewAIsuggestedQsRecord.image != '') {
                                                                                _model.uploadedImages = [];
                                                                                _model.addToUploadedImages(listViewAIsuggestedQsRecord.image);
                                                                                safeSetState(() {});
                                                                                safeSetState(() {
                                                                                  _model.questionTestFieldTextController?.text = listViewAIsuggestedQsRecord.question;
                                                                                });
                                                                              } else {
                                                                                safeSetState(() {
                                                                                  _model.questionTestFieldTextController?.text = listViewAIsuggestedQsRecord.question;
                                                                                });
                                                                                _model.uploadedImages = [];
                                                                                safeSetState(() {});
                                                                              }
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              listViewAIsuggestedQsRecord.question,
                                                                              textAlign: TextAlign.start,
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
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (valueOrDefault<
                                                                  bool>(
                                                                listViewAIsuggestedQsRecord
                                                                            .image !=
                                                                        '',
                                                                false,
                                                              ))
                                                                Flexible(
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      listViewAIsuggestedQsRecord
                                                                          .image,
                                                                      width:
                                                                          140.0,
                                                                      height:
                                                                          140.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (listViewAIsuggestedQsRecord
                                                                          .image ==
                                                                      '')
                                                                Flexible(
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          8.0,
                                                                          0.0,
                                                                          7.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          if (listViewAIsuggestedQsRecord.image != '') {
                                                                            _model.uploadedImages =
                                                                                [];
                                                                            _model.addToUploadedImages(listViewAIsuggestedQsRecord.image);
                                                                            safeSetState(() {});
                                                                            safeSetState(() {
                                                                              _model.questionTestFieldTextController?.text = listViewAIsuggestedQsRecord.question;
                                                                            });
                                                                          } else {
                                                                            safeSetState(() {
                                                                              _model.questionTestFieldTextController?.text = listViewAIsuggestedQsRecord.question;
                                                                            });
                                                                            _model.uploadedImages =
                                                                                [];
                                                                            safeSetState(() {});
                                                                          }
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          listViewAIsuggestedQsRecord
                                                                              .question,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.inter(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
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
                                                  },
                                                  controller: _model
                                                      .listViewController2,
                                                );
                                              },
                                            );
                                          } else {
                                            return Container(
                                              width: 0.0,
                                              height: 0.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Stack(
                                      children: [
                                        if (!(_model.uploadedImages.isNotEmpty))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: FlutterFlowIconButton(
                                              borderRadius: 8.0,
                                              buttonSize: 40.0,
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 30.0,
                                              ),
                                              onPressed: () async {
                                                // Ask User for Image
                                                final selectedMedia =
                                                    await selectMediaWithSourceBottomSheet(
                                                  context: context,
                                                  imageQuality: 80,
                                                  allowPhoto: true,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) =>
                                                        validateFileFormat(
                                                            m.storagePath,
                                                            context))) {
                                                  safeSetState(() => _model
                                                          .isDataUploading_tempImageUpload =
                                                      true);
                                                  var selectedUploadedFiles =
                                                      <FFUploadedFile>[];

                                                  var downloadUrls = <String>[];
                                                  try {
                                                    selectedUploadedFiles =
                                                        selectedMedia
                                                            .map((m) =>
                                                                FFUploadedFile(
                                                                  name: m
                                                                      .storagePath
                                                                      .split(
                                                                          '/')
                                                                      .last,
                                                                  bytes:
                                                                      m.bytes,
                                                                  height: m
                                                                      .dimensions
                                                                      ?.height,
                                                                  width: m
                                                                      .dimensions
                                                                      ?.width,
                                                                  blurHash: m
                                                                      .blurHash,
                                                                ))
                                                            .toList();

                                                    downloadUrls = (await Future
                                                            .wait(
                                                      selectedMedia.map(
                                                        (m) async =>
                                                            await uploadData(
                                                                m.storagePath,
                                                                m.bytes),
                                                      ),
                                                    ))
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                                  } finally {
                                                    _model.isDataUploading_tempImageUpload =
                                                        false;
                                                  }
                                                  if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length &&
                                                      downloadUrls.length ==
                                                          selectedMedia
                                                              .length) {
                                                    safeSetState(() {
                                                      _model.uploadedLocalFile_tempImageUpload =
                                                          selectedUploadedFiles
                                                              .first;
                                                      _model.uploadedFileUrl_tempImageUpload =
                                                          downloadUrls.first;
                                                    });
                                                  } else {
                                                    safeSetState(() {});
                                                    return;
                                                  }
                                                }

                                                if (_model.uploadedFileUrl_tempImageUpload !=
                                                        '') {
                                                  // Add Raw and Firebase Images to Page States
                                                  _model.addToUploadedImages(_model
                                                      .uploadedFileUrl_tempImageUpload);
                                                  safeSetState(() {});
                                                  safeSetState(() {
                                                    _model.isDataUploading_tempImageUpload =
                                                        false;
                                                    _model.uploadedLocalFile_tempImageUpload =
                                                        FFUploadedFile(
                                                            bytes: Uint8List
                                                                .fromList([]));
                                                    _model.uploadedFileUrl_tempImageUpload =
                                                        '';
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        if (_model.uploadedImages.isNotEmpty)
                                          Align(
                                            alignment: AlignmentDirectional(
                                                1.56, -1.6),
                                            child: Builder(
                                              builder: (context) => InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, 0.0)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child:
                                                              UploadedImageWidget(
                                                            uploadedImagesLength:
                                                                _model
                                                                    .uploadedImages
                                                                    .length,
                                                            uploadImageAction:
                                                                () async {
                                                              FFAppState()
                                                                      .gardenCreateBool =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            removeImagesAction:
                                                                () async {
                                                              _model.uploadedImages =
                                                                  [];
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ).then((value) =>
                                                      safeSetState(() => _model
                                                              .additionalImage =
                                                          value));

                                                  if (_model.additionalImage !=
                                                          null &&
                                                      _model.additionalImage !=
                                                          '') {
                                                    _model.addToUploadedImages(
                                                        _model
                                                            .additionalImage!);
                                                    safeSetState(() {});
                                                  }

                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width: 55.0,
                                                  height: 55.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      _model.uploadedImages
                                                          .lastOrNull!,
                                                      width: 200.0,
                                                      height: 200.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 4.0, 12.0, 4.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0x2500ADEA),
                                          borderRadius:
                                              BorderRadius.circular(35.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            width: 2.0,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 0.0, 0.0),
                                                child: TextFormField(
                                                  controller: _model
                                                      .questionTestFieldTextController,
                                                  focusNode: _model
                                                      .questionTestFieldFocusNode,
                                                  onFieldSubmitted: (_) async {
                                                    await _model
                                                        .currentChat!.reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'chatHist':
                                                              getContentListFirestoreData(
                                                            _model.chatHistory,
                                                          ),
                                                        },
                                                      ),
                                                    });
                                                  },
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  textInputAction:
                                                      TextInputAction.send,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        'Enter Question Here...',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .bodySmall
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmall
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 18.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodySmall
                                                                  .fontStyle,
                                                        ),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            Color(0x00000000),
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(
                                                                4.0),
                                                        topRight:
                                                            Radius.circular(
                                                                4.0),
                                                      ),
                                                    ),
                                                  ),
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
                                                  maxLines: 8,
                                                  minLines: 1,
                                                  validator: _model
                                                      .questionTestFieldTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    if (!isAndroid && !isiOS)
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        return TextEditingValue(
                                                          selection: newValue
                                                              .selection,
                                                          text: newValue.text
                                                              .toCapitalization(
                                                                  TextCapitalization
                                                                      .sentences),
                                                        );
                                                      }),
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp('[^\\n]'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 30.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 45.0,
                                                  icon: Icon(
                                                    Icons.send,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    size: 30.0,
                                                  ),
                                                  showLoadingIndicator: true,
                                                  onPressed: () async {
                                                    if (_model.questionTestFieldTextController
                                                                .text !=
                                                            '') {
                                                      _model.threadMessageCreation =
                                                          await OpenAIChatGPTGroup
                                                              .messageCall
                                                              .call(
                                                        threadId: valueOrDefault(
                                                            currentUserDocument
                                                                ?.threadID,
                                                            ''),
                                                        content: _model
                                                            .questionTestFieldTextController
                                                            .text,
                                                      );

                                                      _model.addToChatHistory(
                                                          ContentStruct(
                                                        type: 'user',
                                                        text: TextStruct(
                                                          value: _model
                                                              .questionTestFieldTextController
                                                              .text,
                                                        ),
                                                      ));
                                                      safeSetState(() {});
                                                      if ((_model
                                                              .threadMessageCreation
                                                              ?.succeeded ??
                                                          true)) {
                                                        _model.assistantrun =
                                                            await OpenAIChatGPTGroup
                                                                .runCall
                                                                .call(
                                                          threadId: valueOrDefault(
                                                              currentUserDocument
                                                                  ?.threadID,
                                                              ''),
                                                          assistantId:
                                                              FFAppConstants
                                                                  .assistantId,
                                                        );

                                                        if ((_model.assistantrun
                                                                ?.succeeded ??
                                                            true)) {
                                                          while (
                                                              _model.status ==
                                                                  'queued') {
                                                            _model.assistantStatus =
                                                                await OpenAIChatGPTGroup
                                                                    .retrieverunCall
                                                                    .call(
                                                              threadId: valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.threadID,
                                                                  ''),
                                                            );

                                                            if ((_model
                                                                    .assistantStatus
                                                                    ?.succeeded ??
                                                                true)) {
                                                              if (OpenAIChatGPTGroup
                                                                      .retrieverunCall
                                                                      .status(
                                                                    (_model.assistantStatus
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ) !=
                                                                  OpenAIChatGPTGroup
                                                                      .retrieverunCall
                                                                      .status(
                                                                    (_model.assistantStatus
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  )) {
                                                                _model.chatMessagesList =
                                                                    await OpenAIChatGPTGroup
                                                                        .messagesCall
                                                                        .call(
                                                                  threadId: valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.threadID,
                                                                      ''),
                                                                );

                                                                if ((_model
                                                                        .chatMessagesList
                                                                        ?.succeeded ??
                                                                    true)) {
                                                                  _model.addToChatHistory(ContentStruct.maybeFromMap(
                                                                      OpenAIChatGPTGroup
                                                                          .messagesCall
                                                                          .data(
                                                                    (_model.chatMessagesList
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                  ))!);
                                                                  _model.status =
                                                                      'completed';
                                                                  safeSetState(
                                                                      () {});
                                                                }
                                                              }
                                                            }
                                                          }
                                                          _model.status =
                                                              'queued';
                                                          safeSetState(() {});
                                                        }
                                                      }
                                                    }

                                                    safeSetState(() {});
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (currentUserEmail == '')
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
                                    'Log in to access SageAI',
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
                                          color: FlutterFlowTheme.of(context)
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
                                      context
                                          .pushNamed(LogInPageWidget.routeName);
                                    },
                                    text: 'sign in',
                                    options: FFButtonOptions(
                                      width: 150.0,
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w300,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
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
                                      borderRadius: BorderRadius.circular(20.0),
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
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 24.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w300,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
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
                                          decoration: TextDecoration.underline,
                                        ),
                                    elevation: 3.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
