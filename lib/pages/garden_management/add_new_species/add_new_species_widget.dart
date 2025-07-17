import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_new_species_model.dart';
export 'add_new_species_model.dart';

class AddNewSpeciesWidget extends StatefulWidget {
  const AddNewSpeciesWidget({super.key});

  static String routeName = 'addNewSpecies';
  static String routePath = '/addNewSpecies';

  @override
  State<AddNewSpeciesWidget> createState() => _AddNewSpeciesWidgetState();
}

class _AddNewSpeciesWidgetState extends State<AddNewSpeciesWidget> {
  late AddNewSpeciesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddNewSpeciesModel());

    _model.nameFieldTextController1 ??= TextEditingController();
    _model.nameFieldFocusNode1 ??= FocusNode();

    _model.nameFieldTextController2 ??= TextEditingController();
    _model.nameFieldFocusNode2 ??= FocusNode();
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
                  if (_model.isDataUploading_uploadData17y) {
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
                  _model.valid = true;
                  if (_model.formKey.currentState == null ||
                      !_model.formKey.currentState!.validate()) {
                    _model.valid = false;
                  }
                  _shouldSetState = true;
                  if (!_model.valid!) {
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

                  await CustomSpeciesRecord.collection
                      .doc()
                      .set(createCustomSpeciesRecordData(
                        uid: currentUserUid,
                        imageURL: _model.uploadedFileUrl_uploadData17y,
                        speciesName: _model.nameFieldTextController1.text,
                        blurb: _model.nameFieldTextController2.text,
                      ));

                  context.goNamed(TabsWidget.routeName);

                  if (_shouldSetState) safeSetState(() {});
                },
                backgroundColor: FlutterFlowTheme.of(context).secondary,
                elevation: 0.0,
                label: Text(
                  'Save Species',
                  style: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.ibmPlexMono(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleSmall
                              .fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).info,
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleSmall.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleSmall.fontStyle,
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
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: SingleChildScrollView(
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
                                  borderRadius: 20.0,
                                  borderWidth: 0.0,
                                  buttonSize: 48.0,
                                  fillColor: Colors.white,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
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
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 20.0),
                            child: Text(
                              'Add New Species',
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
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                20.0, 0.0, 20.0, 0.0),
                            child: TextFormField(
                              controller: _model.nameFieldTextController1,
                              focusNode: _model.nameFieldFocusNode1,
                              autofocus: true,
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.ibmPlexMono(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
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
                                hintText: 'Species name...',
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
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
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
                                    color: Color(0xFFAEAEAE),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFAEAEAE),
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
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              minLines: 1,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model
                                  .nameFieldTextController1Validator
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
                                20.0, 15.0, 20.0, 0.0),
                            child: TextFormField(
                              controller: _model.nameFieldTextController2,
                              focusNode: _model.nameFieldFocusNode2,
                              autofocus: true,
                              textCapitalization: TextCapitalization.words,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.ibmPlexMono(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                alignLabelWithHint: true,
                                hintText: 'Description...',
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
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
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
                                    color: Color(0xFFAEAEAE),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFAEAEAE),
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
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                              minLines: 1,
                              cursorColor: FlutterFlowTheme.of(context).primary,
                              validator: _model
                                  .nameFieldTextController2Validator
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 15.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 20,
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
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
                                                    m.storagePath, context))) {
                                          safeSetState(() => _model
                                                  .isDataUploading_uploadData17y =
                                              true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          var downloadUrls = <String>[];
                                          try {
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.storagePath
                                                              .split('/')
                                                              .last,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
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
                                            _model.isDataUploading_uploadData17y =
                                                false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                                  selectedMedia.length &&
                                              downloadUrls.length ==
                                                  selectedMedia.length) {
                                            safeSetState(() {
                                              _model.uploadedLocalFile_uploadData17y =
                                                  selectedUploadedFiles.first;
                                              _model.uploadedFileUrl_uploadData17y =
                                                  downloadUrls.first;
                                            });
                                          } else {
                                            safeSetState(() {});
                                            return;
                                          }
                                        }

                                        if (_model.uploadedFileUrl_uploadData17y !=
                                                '') {
                                          await showDialog(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: Text('Image Uploaded!'),
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
                                      width: 235.0,
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
                                            fontSize: 20.0,
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
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(36.0),
                                    ),
                                  ),
                                ),
                              ),
                              if (_model.uploadedFileUrl_uploadData17y != '')
                                Flexible(
                                  flex: 1,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        _model.uploadedFileUrl_uploadData17y,
                                        width: 50.0,
                                        height: 40.0,
                                        fit: BoxFit.cover,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
