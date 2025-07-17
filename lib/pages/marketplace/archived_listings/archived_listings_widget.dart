import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/marketplace/marketplace_assets/empty_list_message/empty_list_message_widget.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'archived_listings_model.dart';
export 'archived_listings_model.dart';

class ArchivedListingsWidget extends StatefulWidget {
  const ArchivedListingsWidget({super.key});

  static String routeName = 'ArchivedListings';
  static String routePath = '/archivedListings';

  @override
  State<ArchivedListingsWidget> createState() => _ArchivedListingsWidgetState();
}

class _ArchivedListingsWidgetState extends State<ArchivedListingsWidget> {
  late ArchivedListingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArchivedListingsModel());
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
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Text(
              'Archived Listings',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    font: GoogleFonts.ibmPlexMono(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 27.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 5.0, 0.0),
                child: StreamBuilder<List<ProductRecord>>(
                  stream: queryProductRecord(
                    queryBuilder: (productRecord) => productRecord
                        .where(
                          'seller',
                          isEqualTo: currentUserReference,
                        )
                        .where(
                          'isArchived',
                          isEqualTo: true,
                        ),
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
                    List<ProductRecord> gridViewProductRecordList =
                        snapshot.data!;
                    if (gridViewProductRecordList.isEmpty) {
                      return Center(
                        child: EmptyListMessageWidget(
                          message1: 'No Archived Listings',
                          message2: 'From The Marketplace',
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        childAspectRatio: 1.0,
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: gridViewProductRecordList.length,
                      itemBuilder: (context, gridViewIndex) {
                        final gridViewProductRecord =
                            gridViewProductRecordList[gridViewIndex];
                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              MyArchivedListingWidget.routeName,
                              queryParameters: {
                                'listingtoPost': serializeParam(
                                  gridViewProductRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: wrapWithModel(
                            model: _model.listingModels.getModel(
                              currentUserUid,
                              gridViewIndex,
                            ),
                            updateCallback: () => safeSetState(() {}),
                            child: ListingWidget(
                              key: Key(
                                'Keyx9x_${currentUserUid}',
                              ),
                              listingPrice: valueOrDefault<String>(
                                functions.displayValidPrice(
                                    gridViewProductRecord.price),
                                '0.00',
                              ),
                              listingName: valueOrDefault<String>(
                                gridViewProductRecord.title,
                                'New Listing',
                              ),
                              listingImage: valueOrDefault<String>(
                                gridViewProductRecord.image,
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                              ),
                              listingUnit: valueOrDefault<String>(
                                gridViewProductRecord.unitType,
                                'pound',
                              ),
                              numUnits: valueOrDefault<int>(
                                gridViewProductRecord.units,
                                0,
                              ),
                              listing: gridViewProductRecord,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
