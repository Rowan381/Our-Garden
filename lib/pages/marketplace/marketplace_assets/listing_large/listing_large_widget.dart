import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'listing_large_model.dart';
export 'listing_large_model.dart';

class ListingLargeWidget extends StatefulWidget {
  const ListingLargeWidget({
    super.key,
    required this.listingPrice,
    required this.listingName,
    required this.listingImage,
    required this.listingUnit,
    required this.numUnits,
    required this.listing,
  });

  final String? listingPrice;
  final String? listingName;
  final String? listingImage;
  final String? listingUnit;
  final int? numUnits;
  final ProductRecord? listing;

  @override
  State<ListingLargeWidget> createState() => _ListingLargeWidgetState();
}

class _ListingLargeWidgetState extends State<ListingLargeWidget> {
  late ListingLargeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListingLargeModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: 350.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 275.0,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      widget.listingImage == ''
                          ? 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png'
                          : widget.listingImage!,
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 1.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if ((widget.listing?.seller !=
                                  currentUserReference) &&
                              _model.added)
                            Align(
                              alignment: AlignmentDirectional(1.0, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.added = true;
                                  safeSetState(() {});
                                  _model.testSearch =
                                      await queryPendingBasketRecordOnce(
                                    queryBuilder: (pendingBasketRecord) =>
                                        pendingBasketRecord
                                            .where(
                                              'sellerRef',
                                              isEqualTo:
                                                  widget.listing?.seller,
                                            )
                                            .where(
                                              'buyerRef',
                                              isEqualTo: currentUserReference,
                                            ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);
                                  if (_model.testSearch != null) {
                                    while (_model.index <
                                        _model.testSearch!.basketItems.length) {
                                      if ((_model.testSearch?.basketItems
                                                  .elementAtOrNull(
                                                      _model.index))
                                              ?.productRef ==
                                          widget.listing?.reference) {
                                        await _model.testSearch!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'basketItems':
                                                  FieldValue.arrayUnion([
                                                getBasketItemFirestoreData(
                                                  createBasketItemStruct(
                                                    productRef: widget
                                                        .listing?.reference,
                                                    quantity: _model.testSearch!
                                                            .basketItems
                                                            .elementAtOrNull(
                                                                _model.index)!
                                                            .quantity +
                                                        1,
                                                    pricepu:
                                                        widget.listing?.price,
                                                    clearUnsetFields: false,
                                                  ),
                                                  true,
                                                )
                                              ]),
                                            },
                                          ),
                                        });

                                        await _model.testSearch!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'basketItems':
                                                  FieldValue.arrayRemove([
                                                getBasketItemFirestoreData(
                                                  createBasketItemStruct(
                                                    productRef: widget
                                                        .listing?.reference,
                                                    quantity: (_model.testSearch
                                                            ?.basketItems
                                                            .elementAtOrNull(
                                                                _model.index))
                                                        ?.quantity,
                                                    pricepu: (_model.testSearch
                                                            ?.basketItems
                                                            .elementAtOrNull(
                                                                _model.index))
                                                        ?.pricepu,
                                                    clearUnsetFields: false,
                                                  ),
                                                  true,
                                                )
                                              ]),
                                            },
                                          ),
                                        });
                                        _model.terminated = true;
                                        _model.index = _model.index + 100;
                                        break;
                                      }
                                      _model.index = _model.index + 1;
                                    }
                                    if (!_model.terminated) {
                                      await _model.testSearch!.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'basketItems':
                                                FieldValue.arrayUnion([
                                              getBasketItemFirestoreData(
                                                createBasketItemStruct(
                                                  productRef: widget
                                                      .listing?.reference,
                                                  quantity: 1,
                                                  pricepu:
                                                      widget.listing?.price,
                                                  clearUnsetFields: false,
                                                ),
                                                true,
                                              )
                                            ]),
                                          },
                                        ),
                                      });
                                    }
                                    _model.index = 0;
                                    _model.terminated = false;
                                  } else {
                                    await PendingBasketRecord.collection
                                        .doc()
                                        .set({
                                      ...createPendingBasketRecordData(
                                        sellerRef: widget.listing?.seller,
                                        buyerRef: currentUserReference,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'basketItems': [
                                            getBasketItemFirestoreData(
                                              createBasketItemStruct(
                                                productRef:
                                                    widget.listing?.reference,
                                                quantity: 1,
                                                pricepu: widget.listing?.price,
                                                clearUnsetFields: false,
                                                create: true,
                                              ),
                                              true,
                                            )
                                          ],
                                        },
                                      ),
                                    });
                                  }

                                  await Future.delayed(
                                      const Duration(milliseconds: 2000));
                                  _model.added = false;
                                  safeSetState(() {});
                                  _model.added = false;
                                  _model.updatePage(() {});

                                  safeSetState(() {});
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  width: 35.0,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).accent2,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.shoppingBasket,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        size: 14.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if ((widget.listing?.seller !=
                                  currentUserReference) &&
                              !_model.added)
                            Align(
                              alignment: AlignmentDirectional(1.0, 1.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.added = false;
                                  safeSetState(() {});
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                  height: 25.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).accent2,
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 0.0, 0.0),
                                        child: AnimatedDefaultTextStyle(
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
                                                        .secondaryBackground,
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
                                          duration: Duration(milliseconds: 600),
                                          curve: Curves.easeIn,
                                          child: Text(
                                            'Added to Basket ',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 8.0, 0.0),
                                        child: Icon(
                                          Icons.check_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          size: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          if (widget.listing?.isArchived ?? true)
                            Align(
                              alignment: AlignmentDirectional(1.0, 1.0),
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                                height: 25.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 0.0, 0.0),
                                      child: AnimatedDefaultTextStyle(
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
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
                                        duration: Duration(milliseconds: 600),
                                        curve: Curves.easeIn,
                                        child: Text(
                                          'Archived',
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5.0, 0.0, 8.0, 0.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.archive,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        size: 16.0,
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
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(7.5, 0.0, 7.5, 0.0),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          valueOrDefault<String>(
                            '\$${valueOrDefault<String>(
                              widget.listingPrice,
                              '0.00',
                            )} - ${valueOrDefault<String>(
                              widget.listingName,
                              'New Listing',
                            )}',
                            'NULL',
                          ).maybeHandleOverflow(
                            maxChars: 32,
                            replacement: '…',
                          ),
                          maxLines: 1,
                          minFontSize: 10.0,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                        Text(
                          '${widget.numUnits?.toString()} Units Left',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF808080),
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
