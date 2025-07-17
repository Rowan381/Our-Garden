import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/index.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_thread_update_model.dart';
export 'chat_thread_update_model.dart';

class ChatThreadUpdateWidget extends StatefulWidget {
  const ChatThreadUpdateWidget({
    super.key,
    required this.chatMessagesRef,
  });

  final ChatMessagesRecord? chatMessagesRef;

  @override
  State<ChatThreadUpdateWidget> createState() => _ChatThreadUpdateWidgetState();
}

class _ChatThreadUpdateWidgetState extends State<ChatThreadUpdateWidget> {
  late ChatThreadUpdateModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatThreadUpdateModel());
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.chatMessagesRef?.user != currentUserReference)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(12.0, 12.0, 12.0, 0.0),
                child: FutureBuilder<UsersRecord>(
                  future: _model.chatUser(
                    uniqueQueryKey: widget.chatMessagesRef?.reference.id,
                    requestFn: () => UsersRecord.getDocumentOnce(
                        widget.chatMessagesRef!.user!),
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

                    final otherUserUsersRecord = snapshot.data!;

                    return Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 8.0, 16.0),
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).secondary,
                                width: 2.0,
                              ),
                            ),
                            child: Builder(
                              builder: (context) {
                                if (otherUserUsersRecord.photoUrl != '') {
                                  return Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 200),
                                        fadeOutDuration:
                                            Duration(milliseconds: 200),
                                        imageUrl: valueOrDefault<String>(
                                          otherUserUsersRecord.photoUrl,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                        ),
                                        width: 44.0,
                                        height: 44.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.all(2.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: Image.asset(
                                            'assets/images/noProfile.webp',
                                          ).image,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, 0.0),
                                        child: SelectionArea(
                                            child: AutoSizeText(
                                          valueOrDefault<String>(
                                            otherUserUsersRecord.displayName,
                                            'OurGarden User',
                                          ),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .labelSmall
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelSmall
                                                          .fontStyle,
                                                ),
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                        )),
                                      ),
                                      Text(
                                        valueOrDefault<String>(
                                          dateTimeFormat(
                                              "relative",
                                              widget
                                                  .chatMessagesRef?.timestamp),
                                          '--',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .fontStyle,
                                              ),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 4.0)),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
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
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.0),
                                    bottomRight: Radius.circular(12.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(12.0),
                                  ),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SelectionArea(
                                          child: AutoSizeText(
                                        valueOrDefault<String>(
                                          widget.chatMessagesRef?.text,
                                          '--',
                                        ),
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyLarge
                                                        .fontStyle,
                                              ),
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .fontStyle,
                                              lineHeight: 1.5,
                                            ),
                                      )),
                                      if (widget.chatMessagesRef?.image !=
                                              null &&
                                          widget.chatMessagesRef?.image != '')
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 4.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                ImageDetailsWidget.routeName,
                                                queryParameters: {
                                                  'chatMessage': serializeParam(
                                                    widget.chatMessagesRef,
                                                    ParamType.Document,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'chatMessage':
                                                      widget.chatMessagesRef,
                                                },
                                              );
                                            },
                                            child: FlutterFlowMediaDisplay(
                                              path: widget
                                                  .chatMessagesRef!.image,
                                              imageBuilder: (path) => ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: CachedNetworkImage(
                                                  fadeInDuration: Duration(
                                                      milliseconds: 500),
                                                  fadeOutDuration: Duration(
                                                      milliseconds: 500),
                                                  imageUrl: path,
                                                  width: 300.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              videoPlayerBuilder: (path) =>
                                                  FlutterFlowVideoPlayer(
                                                path: path,
                                                width: 300.0,
                                                autoPlay: false,
                                                looping: false,
                                                showControls: true,
                                                allowFullScreen: true,
                                                allowPlaybackSpeedMenu: false,
                                              ),
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        if (widget.chatMessagesRef?.user == currentUserReference)
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(65.0, 12.0, 12.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 8.0),
                      child: Text(
                        valueOrDefault<String>(
                          dateTimeFormat(
                              "relative", widget.chatMessagesRef?.timestamp),
                          '--',
                        ),
                        style: FlutterFlowTheme.of(context).labelSmall.override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .fontStyle,
                              ),
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .fontStyle,
                            ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFD1F3FF),
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
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(0.0),
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).secondary,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SelectionArea(
                                child: Text(
                              valueOrDefault<String>(
                                widget.chatMessagesRef?.text,
                                '--',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                    lineHeight: 1.5,
                                  ),
                            )),
                            if (widget.chatMessagesRef?.image != null &&
                                widget.chatMessagesRef?.image != '')
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 12.0, 0.0, 4.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ImageDetailsWidget.routeName,
                                      queryParameters: {
                                        'chatMessage': serializeParam(
                                          widget.chatMessagesRef,
                                          ParamType.Document,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        'chatMessage': widget.chatMessagesRef,
                                      },
                                    );
                                  },
                                  child: FlutterFlowMediaDisplay(
                                    path: widget.chatMessagesRef!.image,
                                    imageBuilder: (path) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 500),
                                        fadeOutDuration:
                                            Duration(milliseconds: 500),
                                        imageUrl: path,
                                        width: 300.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    videoPlayerBuilder: (path) =>
                                        FlutterFlowVideoPlayer(
                                      path: path,
                                      width: 300.0,
                                      autoPlay: false,
                                      looping: true,
                                      showControls: true,
                                      allowFullScreen: true,
                                      allowPlaybackSpeedMenu: false,
                                    ),
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
          ),
      ],
    );
  }
}
