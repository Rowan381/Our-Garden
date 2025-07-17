import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/marketplace/marketplace_assets/empty_list_message/empty_list_message_widget.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'search_listings_copy_model.dart';
export 'search_listings_copy_model.dart';

class SearchListingsCopyWidget extends StatefulWidget {
  const SearchListingsCopyWidget({super.key});

  static String routeName = 'SearchListingsCopy';
  static String routePath = '/searchListingsCopy';

  @override
  State<SearchListingsCopyWidget> createState() =>
      _SearchListingsCopyWidgetState();
}

class _SearchListingsCopyWidgetState extends State<SearchListingsCopyWidget> {
  late SearchListingsCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchListingsCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.temp = await queryProductRecordOnce(
        queryBuilder: (productRecord) => productRecord.where(
          'isArchived',
          isEqualTo: false,
        ),
        limit: 50,
      );

      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
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
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
              'Search Listings',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.ibmPlexMono(
                      fontWeight: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
                    fontSize: 27.0,
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 2.0,
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 10.0, 5.0),
                    child: Container(
                      width: 412.0,
                      height: 113.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 4.0, 16.0, 0.0),
                                      child: TextFormField(
                                        controller: _model.textController,
                                        focusNode: _model.textFieldFocusNode,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: false,
                                          labelText: 'Search for listings',
                                          labelStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
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
                                                color: Colors.black,
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
                                              color: Color(0xFF00ADEA),
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(36.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(36.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 2.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(36.0),
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
                                                BorderRadius.circular(36.0),
                                          ),
                                          filled: true,
                                          fillColor: Color(0xFFEDF7FF),
                                          prefixIcon: Icon(
                                            Icons.search_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                        ),
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
                                              color: Colors.black,
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
                                        maxLines: null,
                                        validator: _model
                                            .textControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      await queryProductRecordOnce()
                                          .then(
                                            (records) =>
                                                _model.simpleSearchResults =
                                                    TextSearch(
                                              records
                                                  .map(
                                                    (record) => TextSearchItem
                                                        .fromTerms(record, [
                                                      record.id,
                                                      record.description,
                                                      record.title,
                                                      record.sellerName,
                                                      record.locationCity
                                                    ]),
                                                  )
                                                  .toList(),
                                            )
                                                        .search(_model
                                                            .textController
                                                            .text)
                                                        .map((r) => r.object)
                                                        .toList(),
                                          )
                                          .onError((_, __) =>
                                              _model.simpleSearchResults = [])
                                          .whenComplete(
                                              () => safeSetState(() {}));

                                      _model.isShowFullList = false;
                                      safeSetState(() {});
                                    },
                                    text: 'Search',
                                    options: FFButtonOptions(
                                      height: 40.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24.0, 0.0, 24.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
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
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(36.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (currentUserDocument?.location != null)
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'Filter by Distance: ',
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
                                              fontSize: 15.0,
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
                                    SliderTheme(
                                      data: SliderThemeData(
                                        showValueIndicator:
                                            ShowValueIndicator.always,
                                      ),
                                      child: Slider(
                                        activeColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        inactiveColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        min: 1.0,
                                        max: 200.0,
                                        value: _model.sliderValue ??= 100.0,
                                        label: _model.sliderValue
                                            ?.toStringAsFixed(0),
                                        onChanged: (newValue) {
                                          newValue = double.parse(
                                              newValue.toStringAsFixed(0));
                                          safeSetState(() =>
                                              _model.sliderValue = newValue);
                                        },
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
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            if (_model.isShowFullList &&
                                (currentUserDocument?.location != null)) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final gridView = functions
                                            .getProductsDistance(
                                                _model.temp?.toList(),
                                                _model.sliderValue,
                                                currentUserDocument?.location)
                                            ?.toList() ??
                                        [];
                                    if (gridView.isEmpty) {
                                      return Center(
                                        child: EmptyListMessageWidget(
                                          message1:
                                              'No Listings For Sale Near Your Current Location',
                                          message2:
                                              'Please check for more listings at a later time!',
                                        ),
                                      );
                                    }

                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: gridView.length,
                                      itemBuilder: (context, gridViewIndex) {
                                        final gridViewItem =
                                            gridView[gridViewIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (gridViewItem.seller ==
                                                currentUserReference) {
                                              context.pushNamed(
                                                MyListingWidget.routeName,
                                                queryParameters: {
                                                  'listingtoPost':
                                                      serializeParam(
                                                    gridViewItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              context.pushNamed(
                                                ListingDetailsWidget.routeName,
                                                queryParameters: {
                                                  'listingtoPost':
                                                      serializeParam(
                                                    gridViewItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            }
                                          },
                                          child: wrapWithModel(
                                            model:
                                                _model.listingModels1.getModel(
                                              currentUserUid,
                                              gridViewIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ListingWidget(
                                              key: Key(
                                                'Keyno5_${currentUserUid}',
                                              ),
                                              listingPrice:
                                                  valueOrDefault<String>(
                                                functions.displayValidPrice(
                                                    gridViewItem.price),
                                                '0.00',
                                              ),
                                              listingName:
                                                  valueOrDefault<String>(
                                                gridViewItem.title,
                                                'New Listing',
                                              ),
                                              listingImage:
                                                  valueOrDefault<String>(
                                                gridViewItem.image,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                              ),
                                              listingUnit:
                                                  valueOrDefault<String>(
                                                gridViewItem.unitType,
                                                'pound',
                                              ),
                                              numUnits: valueOrDefault<int>(
                                                gridViewItem.units,
                                                0,
                                              ),
                                              listing: gridViewItem,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            } else if (!_model.isShowFullList &&
                                (currentUserDocument?.location == null)) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: Builder(
                                  builder: (context) {
                                    final searchResult =
                                        _model.simpleSearchResults.toList();
                                    if (searchResult.isEmpty) {
                                      return Center(
                                        child: EmptyListMessageWidget(
                                          message1: 'No Matching',
                                          message2: 'Search Results',
                                        ),
                                      );
                                    }

                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: searchResult.length,
                                      itemBuilder:
                                          (context, searchResultIndex) {
                                        final searchResultItem =
                                            searchResult[searchResultIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (searchResultItem.seller ==
                                                currentUserReference) {
                                              context.pushNamed(
                                                MyListingWidget.routeName,
                                                queryParameters: {
                                                  'listingtoPost':
                                                      serializeParam(
                                                    searchResultItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              context.pushNamed(
                                                ListingDetailsWidget.routeName,
                                                queryParameters: {
                                                  'listingtoPost':
                                                      serializeParam(
                                                    searchResultItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            }
                                          },
                                          child: wrapWithModel(
                                            model:
                                                _model.listingModels2.getModel(
                                              currentUserUid,
                                              searchResultIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ListingWidget(
                                              key: Key(
                                                'Keyft3_${currentUserUid}',
                                              ),
                                              listingPrice:
                                                  valueOrDefault<String>(
                                                functions.displayValidPrice(
                                                    searchResultItem.price),
                                                '0.00',
                                              ),
                                              listingName:
                                                  valueOrDefault<String>(
                                                searchResultItem.title,
                                                'New Listing',
                                              ),
                                              listingImage:
                                                  valueOrDefault<String>(
                                                searchResultItem.image,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                              ),
                                              listingUnit:
                                                  valueOrDefault<String>(
                                                searchResultItem.unitType,
                                                'pound',
                                              ),
                                              numUnits: valueOrDefault<int>(
                                                searchResultItem.units,
                                                0,
                                              ),
                                              listing: searchResultItem,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            } else if (_model.isShowFullList &&
                                (currentUserDocument?.location == null)) {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: StreamBuilder<List<ProductRecord>>(
                                  stream: queryProductRecord(
                                    queryBuilder: (productRecord) =>
                                        productRecord
                                            .where(
                                              'seller',
                                              isNotEqualTo:
                                                  currentUserReference,
                                            )
                                            .where(
                                              'isArchived',
                                              isEqualTo: false,
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
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    List<ProductRecord>
                                        gridViewProductRecordList =
                                        snapshot.data!;
                                    if (gridViewProductRecordList.isEmpty) {
                                      return Center(
                                        child: EmptyListMessageWidget(
                                          message1:
                                              'No Listings Currently For Sale',
                                          message2:
                                              'Please check for more listings at a later time!',
                                        ),
                                      );
                                    }

                                    return GridView.builder(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        childAspectRatio: 1.0,
                                      ),
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          gridViewProductRecordList.length,
                                      itemBuilder: (context, gridViewIndex) {
                                        final gridViewProductRecord =
                                            gridViewProductRecordList[
                                                gridViewIndex];
                                        return InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            if (gridViewProductRecord.seller ==
                                                currentUserReference) {
                                              context.pushNamed(
                                                MyListingWidget.routeName,
                                                queryParameters: {
                                                  'listingtoPost':
                                                      serializeParam(
                                                    gridViewProductRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              context.pushNamed(
                                                ListingDetailsWidget.routeName,
                                                queryParameters: {
                                                  'listingtoPost':
                                                      serializeParam(
                                                    gridViewProductRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            }
                                          },
                                          child: wrapWithModel(
                                            model:
                                                _model.listingModels3.getModel(
                                              currentUserUid,
                                              gridViewIndex,
                                            ),
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ListingWidget(
                                              key: Key(
                                                'Key719_${currentUserUid}',
                                              ),
                                              listingPrice:
                                                  valueOrDefault<String>(
                                                functions.displayValidPrice(
                                                    gridViewProductRecord
                                                        .price),
                                                '0.00',
                                              ),
                                              listingName:
                                                  valueOrDefault<String>(
                                                gridViewProductRecord.title,
                                                'New Listing',
                                              ),
                                              listingImage:
                                                  valueOrDefault<String>(
                                                gridViewProductRecord.image,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                              ),
                                              listingUnit:
                                                  valueOrDefault<String>(
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
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5.0, 0.0, 5.0, 0.0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Builder(
                                    builder: (context) {
                                      final gridViewLocation = functions
                                              .getProductsDistance(
                                                  _model.simpleSearchResults
                                                      .toList(),
                                                  _model.sliderValue,
                                                  currentUserDocument?.location)
                                              ?.toList() ??
                                          [];
                                      if (gridViewLocation.isEmpty) {
                                        return Center(
                                          child: EmptyListMessageWidget(
                                            message1:
                                                'No Matching Search Results',
                                            message2: ' ',
                                          ),
                                        );
                                      }

                                      return GridView.builder(
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5.0,
                                          childAspectRatio: 1.0,
                                        ),
                                        primary: false,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        itemCount: gridViewLocation.length,
                                        itemBuilder:
                                            (context, gridViewLocationIndex) {
                                          final gridViewLocationItem =
                                              gridViewLocation[
                                                  gridViewLocationIndex];
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              if (gridViewLocationItem.seller ==
                                                  currentUserReference) {
                                                context.pushNamed(
                                                  MyListingWidget.routeName,
                                                  queryParameters: {
                                                    'listingtoPost':
                                                        serializeParam(
                                                      gridViewLocationItem
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              } else {
                                                context.pushNamed(
                                                  ListingDetailsWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'listingtoPost':
                                                        serializeParam(
                                                      gridViewLocationItem
                                                          .reference,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              }
                                            },
                                            child: wrapWithModel(
                                              model: _model.listingModels4
                                                  .getModel(
                                                currentUserUid,
                                                gridViewLocationIndex,
                                              ),
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: ListingWidget(
                                                key: Key(
                                                  'Key9ow_${currentUserUid}',
                                                ),
                                                listingPrice:
                                                    valueOrDefault<String>(
                                                  functions.displayValidPrice(
                                                      gridViewLocationItem
                                                          .price),
                                                  '0.00',
                                                ),
                                                listingName:
                                                    valueOrDefault<String>(
                                                  gridViewLocationItem.title,
                                                  'New Listing',
                                                ),
                                                listingImage:
                                                    valueOrDefault<String>(
                                                  gridViewLocationItem.image,
                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                                ),
                                                listingUnit:
                                                    valueOrDefault<String>(
                                                  gridViewLocationItem.unitType,
                                                  'pound',
                                                ),
                                                numUnits: valueOrDefault<int>(
                                                  gridViewLocationItem.units,
                                                  0,
                                                ),
                                                listing: gridViewLocationItem,
                                              ),
                                            ),
                                          );
                                        },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
