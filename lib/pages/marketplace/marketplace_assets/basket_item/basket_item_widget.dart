import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'basket_item_model.dart';
export 'basket_item_model.dart';

class BasketItemWidget extends StatefulWidget {
  const BasketItemWidget({
    super.key,
    required this.seller,
    required this.basketItems,
    required this.pendingBasketRef,
    bool? pending,
  }) : this.pending = pending ?? true;

  final DocumentReference? seller;
  final List<BasketItemStruct>? basketItems;
  final DocumentReference? pendingBasketRef;
  final bool pending;

  @override
  State<BasketItemWidget> createState() => _BasketItemWidgetState();
}

class _BasketItemWidgetState extends State<BasketItemWidget> {
  late BasketItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BasketItemModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loadIndex = 0;
      while (_model.loadIndex < widget.basketItems!.length) {
        _model.productCheck = await ProductRecord.getDocumentOnce(
            (widget.basketItems!.elementAtOrNull(_model.loadIndex))!
                .productRef!);
        if ((_model.productCheck != null) &&
                ((widget.basketItems!.elementAtOrNull(_model.loadIndex))!
                        .quantity <=
                    _model.productCheck!.units)
            ? true
            : false) {
          _model.addToNewBasket(BasketItemStruct(
            productRef: _model.productCheck?.reference,
            quantity: (widget.basketItems?.elementAtOrNull(_model.loadIndex))
                ?.quantity,
            pricepu: _model.productCheck?.price,
          ));
          _model.cartTotal = _model.cartTotal +
              ((widget.basketItems!.elementAtOrNull(_model.loadIndex))!
                      .quantity *
                  _model.productCheck!.price);
        } else if (_model.productCheck != null) {
          _model.addToNewBasket(BasketItemStruct(
            productRef: _model.productCheck?.reference,
            quantity: _model.productCheck?.units,
            pricepu: _model.productCheck?.price,
          ));
          _model.cartTotal = _model.cartTotal +
              (_model.productCheck!.units * _model.productCheck!.price);
        }

        _model.loadIndex = _model.loadIndex + 1;
      }

      await widget.pendingBasketRef!.update({
        ...mapToFirestore(
          {
            'basketItems': getBasketItemListFirestoreData(
              _model.newBasket,
            ),
          },
        ),
      });
      _model.newBasket = [];
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(widget.seller!),
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

        final containerUsersRecord = snapshot.data!;

        return Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(36.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).primaryText,
              width: 1.0,
            ),
          ),
          child: StreamBuilder<PendingBasketRecord>(
            stream: PendingBasketRecord.getDocument(widget.pendingBasketRef!),
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

              final columnPendingBasketRecord = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  StreamBuilder<UsersRecord>(
                    stream: UsersRecord.getDocument(
                        columnPendingBasketRecord.buyerRef!),
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

                      final columnUsersRecord = snapshot.data!;

                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 15.0, 0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width: 50.0,
                                    height: 50.0,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      containerUsersRecord.reference !=
                                              currentUserReference
                                          ? containerUsersRecord.photoUrl
                                          : columnUsersRecord.photoUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if ((widget.seller == currentUserReference) &&
                                    !widget.pending)
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20.0, 0.0, 0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          _model.orderPBasket =
                                              await PendingBasketRecord
                                                  .getDocumentOnce(widget
                                                      .pendingBasketRef!);
                                          _model.orderBasketItems = _model
                                              .orderPBasket!.basketItems
                                              .toList()
                                              .cast<BasketItemStruct>();
                                          _model.loadIndex = 0;
                                          while (_model.loadIndex <
                                              widget.basketItems!.length) {
                                            _model.productCheck1 =
                                                await ProductRecord
                                                    .getDocumentOnce((widget
                                                            .basketItems!
                                                            .elementAtOrNull(
                                                                _model
                                                                    .loadIndex))!
                                                        .productRef!);
                                            if ((_model.productCheck1 !=
                                                        null) &&
                                                    ((widget.basketItems!
                                                                .elementAtOrNull(
                                                                    _model
                                                                        .loadIndex))!
                                                            .quantity <=
                                                        _model.productCheck1!
                                                            .units)
                                                ? true
                                                : false) {
                                              _model.addToNewBasket(
                                                  BasketItemStruct(
                                                productRef: _model
                                                    .productCheck1?.reference,
                                                quantity: (widget.basketItems
                                                        ?.elementAtOrNull(
                                                            _model.loadIndex))
                                                    ?.quantity,
                                                pricepu:
                                                    _model.productCheck1?.price,
                                              ));
                                              _model.cartTotal = _model
                                                      .cartTotal +
                                                  ((widget.basketItems!
                                                              .elementAtOrNull(
                                                                  _model
                                                                      .loadIndex))!
                                                          .quantity *
                                                      _model.productCheck1!
                                                          .price);
                                            } else if (_model.productCheck1 !=
                                                null) {
                                              _model.addToNewBasket(
                                                  BasketItemStruct(
                                                productRef: _model
                                                    .productCheck1?.reference,
                                                quantity:
                                                    _model.productCheck1?.units,
                                                pricepu:
                                                    _model.productCheck1?.price,
                                              ));
                                              _model.cartTotal = _model
                                                      .cartTotal +
                                                  (_model.productCheck1!.units *
                                                      _model
                                                          .productCheck!.price);
                                            }

                                            _model.loadIndex =
                                                _model.loadIndex + 1;
                                          }

                                          await widget.pendingBasketRef!
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'basketItems':
                                                    getBasketItemListFirestoreData(
                                                  _model.newBasket,
                                                ),
                                              },
                                            ),
                                          });
                                          _model.newBasket = [];
                                          safeSetState(() {});

                                          var ordersRecordReference =
                                              OrdersRecord.collection.doc();
                                          await ordersRecordReference
                                              .set(createOrdersRecordData(
                                            buyer: columnPendingBasketRecord
                                                .buyerRef,
                                            seller: columnPendingBasketRecord
                                                .sellerRef,
                                            totalPrice: 0.0,
                                          ));
                                          _model.orderIP =
                                              OrdersRecord.getDocumentFromData(
                                                  createOrdersRecordData(
                                                    buyer:
                                                        columnPendingBasketRecord
                                                            .buyerRef,
                                                    seller:
                                                        columnPendingBasketRecord
                                                            .sellerRef,
                                                    totalPrice: 0.0,
                                                  ),
                                                  ordersRecordReference);
                                          _model.orderIndex = 0;
                                          _model.orderChat =
                                              await queryChatsRecordOnce(
                                            queryBuilder: (chatsRecord) =>
                                                chatsRecord.where(
                                              'pendingBasket',
                                              isEqualTo:
                                                  widget.pendingBasketRef,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);
                                          _model.productToArchive =
                                              await ProductRecord
                                                  .getDocumentOnce(_model
                                                      .orderChat!.productRef!);

                                          var productRecordReference3 =
                                              ProductRecord.collection.doc();
                                          await productRecordReference3.set({
                                            ...createProductRecordData(
                                              description: _model
                                                  .productToArchive
                                                  ?.description,
                                              price: _model
                                                  .productToArchive?.price,
                                              createdAt: _model
                                                  .productToArchive?.createdAt,
                                              modifiedAt: _model
                                                  .productToArchive?.modifiedAt,
                                              id: _model.productToArchive?.id,
                                              seller: _model
                                                  .productToArchive?.seller,
                                              image: _model
                                                  .productToArchive?.image,
                                              units: _model
                                                  .productToArchive?.units,
                                              forSale: _model
                                                  .productToArchive?.forSale,
                                              title: _model
                                                  .productToArchive?.title,
                                              sellerName: '',
                                              unitType: _model
                                                  .productToArchive?.unitType,
                                              produceType: _model
                                                  .productToArchive
                                                  ?.produceType,
                                              gardenType: _model
                                                  .productToArchive?.gardenType,
                                              location: _model
                                                  .productToArchive?.location,
                                              sellerImage: _model
                                                  .productToArchive
                                                  ?.sellerImage,
                                              locationCity: _model
                                                  .productToArchive
                                                  ?.locationCity,
                                              isArchived: true,
                                              psold: _model
                                                  .productToArchive?.psold,
                                              itemForm: _model
                                                  .productToArchive?.itemForm,
                                              tempCondition: _model
                                                  .productToArchive
                                                  ?.tempCondition,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'listingFilters': _model
                                                    .productToArchive
                                                    ?.listingFilters,
                                              },
                                            ),
                                          });
                                          _model.archivedProduct = ProductRecord
                                              .getDocumentFromData({
                                            ...createProductRecordData(
                                              description: _model
                                                  .productToArchive
                                                  ?.description,
                                              price: _model
                                                  .productToArchive?.price,
                                              createdAt: _model
                                                  .productToArchive?.createdAt,
                                              modifiedAt: _model
                                                  .productToArchive?.modifiedAt,
                                              id: _model.productToArchive?.id,
                                              seller: _model
                                                  .productToArchive?.seller,
                                              image: _model
                                                  .productToArchive?.image,
                                              units: _model
                                                  .productToArchive?.units,
                                              forSale: _model
                                                  .productToArchive?.forSale,
                                              title: _model
                                                  .productToArchive?.title,
                                              sellerName: '',
                                              unitType: _model
                                                  .productToArchive?.unitType,
                                              produceType: _model
                                                  .productToArchive
                                                  ?.produceType,
                                              gardenType: _model
                                                  .productToArchive?.gardenType,
                                              location: _model
                                                  .productToArchive?.location,
                                              sellerImage: _model
                                                  .productToArchive
                                                  ?.sellerImage,
                                              locationCity: _model
                                                  .productToArchive
                                                  ?.locationCity,
                                              isArchived: true,
                                              psold: _model
                                                  .productToArchive?.psold,
                                              itemForm: _model
                                                  .productToArchive?.itemForm,
                                              tempCondition: _model
                                                  .productToArchive
                                                  ?.tempCondition,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'listingFilters': _model
                                                    .productToArchive
                                                    ?.listingFilters,
                                              },
                                            ),
                                          }, productRecordReference3);

                                          await _model.orderChat!.reference
                                              .update(createChatsRecordData(
                                            productRef: _model
                                                .archivedProduct?.reference,
                                          ));
                                          while (_model.orderIndex <
                                              widget.basketItems!.length) {
                                            _model.currProduct =
                                                await ProductRecord
                                                    .getDocumentOnce(_model
                                                        .orderBasketItems
                                                        .elementAtOrNull(
                                                            _model.orderIndex)!
                                                        .productRef!);
                                            _model.addToOrderItems(
                                                OrderItemsStruct(
                                              quantity: _model.orderBasketItems
                                                  .elementAtOrNull(
                                                      _model.orderIndex)
                                                  ?.quantity,
                                              totalPrice: _model
                                                      .orderBasketItems
                                                      .elementAtOrNull(
                                                          _model.orderIndex)!
                                                      .quantity *
                                                  _model.orderBasketItems
                                                      .elementAtOrNull(
                                                          _model.orderIndex)!
                                                      .pricepu,
                                              image: _model.currProduct?.image,
                                              productName:
                                                  _model.currProduct?.title,
                                            ));
                                            _model.orderTotalPrice = _model
                                                    .orderTotalPrice +
                                                (_model.orderBasketItems
                                                        .elementAtOrNull(
                                                            _model.orderIndex)!
                                                        .quantity *
                                                    _model.orderBasketItems
                                                        .elementAtOrNull(
                                                            _model.orderIndex)!
                                                        .pricepu);
                                            if (_model.orderBasketItems
                                                    .elementAtOrNull(
                                                        _model.orderIndex)!
                                                    .quantity >=
                                                _model.currProduct!.units) {
                                              await _model
                                                  .currProduct!.reference
                                                  .delete();
                                            } else {
                                              if (_model.currProduct?.psold ==
                                                  null) {
                                                await _model
                                                    .currProduct!.reference
                                                    .update(
                                                        createProductRecordData(
                                                  psold: 0,
                                                ));
                                              }

                                              await _model
                                                  .currProduct!.reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'units': FieldValue
                                                        .increment(-(_model
                                                            .orderBasketItems
                                                            .elementAtOrNull(
                                                                _model
                                                                    .orderIndex)!
                                                            .quantity)),
                                                    'psold': FieldValue
                                                        .increment(_model
                                                            .orderBasketItems
                                                            .elementAtOrNull(
                                                                _model
                                                                    .orderIndex)!
                                                            .quantity),
                                                  },
                                                ),
                                              });
                                            }

                                            _model.orderIndex =
                                                _model.orderIndex + 1;
                                          }

                                          await _model.orderChat!.reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'pendingBasket':
                                                    FieldValue.delete(),
                                              },
                                            ),
                                          });
                                          await widget.pendingBasketRef!
                                              .delete();

                                          await _model.orderIP!.reference
                                              .update({
                                            ...createOrdersRecordData(
                                              totalPrice:
                                                  _model.orderTotalPrice,
                                              buyerPaid: false,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'items':
                                                    getOrderItemsListFirestoreData(
                                                  _model.orderItems,
                                                ),
                                              },
                                            ),
                                          });
                                          triggerPushNotification(
                                            notificationTitle:
                                                '${currentUserDisplayName} just approved your produce request!',
                                            notificationText:
                                                'It\'s time to pay for your produce and set up a pick-up',
                                            notificationImageUrl:
                                                currentUserPhoto,
                                            notificationSound: 'default',
                                            userRefs: [
                                              columnPendingBasketRecord
                                                  .buyerRef!
                                            ],
                                            initialPageName:
                                                'chat_2_Details_Cart',
                                            parameterData: {
                                              'chatDoc': _model.orderChat,
                                            },
                                          );

                                          context.goNamed(
                                            SellerOrdersPageWidget.routeName,
                                            queryParameters: {
                                              'justApproved': serializeParam(
                                                true,
                                                ParamType.bool,
                                              ),
                                            }.withoutNulls,
                                          );

                                          safeSetState(() {});
                                        },
                                        text: 'Approve Request',
                                        options: FFButtonOptions(
                                          height: 35.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
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
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: Text(
                              widget.seller != currentUserReference
                                  ? containerUsersRecord.displayName
                                  : columnUsersRecord.displayName,
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
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Divider(
                      thickness: 2.0,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ),
                  Container(
                    width: 320.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        final items = widget.basketItems!
                            .sortedList(keyOf: (e) => e.pricepu, desc: false)
                            .toList();

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: items.length,
                          itemBuilder: (context, itemsIndex) {
                            final itemsItem = items[itemsIndex];
                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 5.0, 0.0, 10.0),
                              child: StreamBuilder<ProductRecord>(
                                stream: ProductRecord.getDocument(
                                    itemsItem.productRef!),
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

                                  final containerProductRecord = snapshot.data!;

                                  return Container(
                                    height: 100.0,
                                    constraints: BoxConstraints(
                                      maxWidth: 100.0,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 5.0, 0.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              valueOrDefault<String>(
                                                containerProductRecord.image,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                              ),
                                              width: 75.0,
                                              height: 75.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 222.0,
                                          height: 100.0,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 212.0,
                                                height: 48.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        containerProductRecord
                                                            .title,
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
                                                                      15.0,
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
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  5.0,
                                                                  0.0),
                                                      child: Text(
                                                        '\$${itemsItem.pricepu.toString()}',
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
                                                                      15.0,
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
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 214.0,
                                                height: 46.0,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Visibility(
                                                  visible: widget.pending,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          if (itemsItem
                                                                  .quantity >
                                                              1) {
                                                            await widget
                                                                .pendingBasketRef!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'basketItems':
                                                                      FieldValue
                                                                          .arrayUnion([
                                                                    getBasketItemFirestoreData(
                                                                      createBasketItemStruct(
                                                                        productRef:
                                                                            itemsItem.productRef,
                                                                        quantity:
                                                                            itemsItem.quantity -
                                                                                1,
                                                                        pricepu:
                                                                            itemsItem.pricepu,
                                                                        clearUnsetFields:
                                                                            false,
                                                                      ),
                                                                      true,
                                                                    )
                                                                  ]),
                                                                },
                                                              ),
                                                            });

                                                            await widget
                                                                .pendingBasketRef!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'basketItems':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    getBasketItemFirestoreData(
                                                                      createBasketItemStruct(
                                                                        productRef:
                                                                            itemsItem.productRef,
                                                                        quantity:
                                                                            itemsItem.quantity,
                                                                        pricepu:
                                                                            itemsItem.pricepu,
                                                                        clearUnsetFields:
                                                                            false,
                                                                      ),
                                                                      true,
                                                                    )
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                          } else {
                                                            await widget
                                                                .pendingBasketRef!
                                                                .update({
                                                              ...mapToFirestore(
                                                                {
                                                                  'basketItems':
                                                                      FieldValue
                                                                          .arrayRemove([
                                                                    getBasketItemFirestoreData(
                                                                      createBasketItemStruct(
                                                                        productRef:
                                                                            itemsItem.productRef,
                                                                        quantity:
                                                                            itemsItem.quantity,
                                                                        pricepu:
                                                                            itemsItem.pricepu,
                                                                        clearUnsetFields:
                                                                            false,
                                                                      ),
                                                                      true,
                                                                    )
                                                                  ]),
                                                                },
                                                              ),
                                                            });
                                                            while (_model
                                                                    .index <
                                                                widget
                                                                    .basketItems!
                                                                    .length) {
                                                              if ((widget.basketItems
                                                                          ?.elementAtOrNull(
                                                                              _model.index))
                                                                      ?.quantity !=
                                                                  0) {
                                                                _model.allItemQuantsZero =
                                                                    false;
                                                              }
                                                              _model.index =
                                                                  _model.index +
                                                                      1;
                                                            }
                                                            if (_model
                                                                .allItemQuantsZero) {
                                                              await widget
                                                                  .pendingBasketRef!
                                                                  .delete();
                                                            }
                                                            _model.index = 0;
                                                          }

                                                          _model
                                                              .cartTotal = _model
                                                                  .cartTotal +
                                                              (-1 *
                                                                  itemsItem
                                                                      .pricepu);
                                                          safeSetState(() {});
                                                        },
                                                        text: '',
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          size: 18.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 34.0,
                                                          height: 27.69,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      2.5,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment
                                                                  .start,
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      5.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          color:
                                                              Color(0xFFBDEDFF),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    0.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    16.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    0.0),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            itemsItem.quantity
                                                                .toString(),
                                                            '1',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
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
                                                                fontSize: 18.0,
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
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          await widget
                                                              .pendingBasketRef!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'basketItems':
                                                                    FieldValue
                                                                        .arrayRemove([
                                                                  getBasketItemFirestoreData(
                                                                    createBasketItemStruct(
                                                                      productRef:
                                                                          itemsItem
                                                                              .productRef,
                                                                      quantity:
                                                                          itemsItem
                                                                              .quantity,
                                                                      pricepu:
                                                                          itemsItem
                                                                              .pricepu,
                                                                      clearUnsetFields:
                                                                          false,
                                                                    ),
                                                                    true,
                                                                  )
                                                                ]),
                                                              },
                                                            ),
                                                          });

                                                          await widget
                                                              .pendingBasketRef!
                                                              .update({
                                                            ...mapToFirestore(
                                                              {
                                                                'basketItems':
                                                                    FieldValue
                                                                        .arrayUnion([
                                                                  getBasketItemFirestoreData(
                                                                    createBasketItemStruct(
                                                                      productRef:
                                                                          itemsItem
                                                                              .productRef,
                                                                      quantity:
                                                                          itemsItem.quantity +
                                                                              1,
                                                                      pricepu:
                                                                          itemsItem
                                                                              .pricepu,
                                                                      clearUnsetFields:
                                                                          false,
                                                                    ),
                                                                    true,
                                                                  )
                                                                ]),
                                                              },
                                                            ),
                                                          });
                                                          _model
                                                              .cartTotal = _model
                                                                  .cartTotal +
                                                              (-1 *
                                                                  itemsItem
                                                                      .pricepu);
                                                          safeSetState(() {});
                                                        },
                                                        text: '',
                                                        icon: Icon(
                                                          Icons.add,
                                                          size: 22.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width: 34.0,
                                                          height: 27.69,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      2.5,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconAlignment:
                                                              IconAlignment
                                                                  .start,
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                          color:
                                                              Color(0xFFBDEDFF),
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    16.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    16.0),
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
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: Text(
                      'Total: \$${_model.cartTotal.toString()}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.ibmPlexMono(
                              fontWeight: FontWeight.w800,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            fontSize: 17.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w800,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  if (widget.pending)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          var _shouldSetState = false;
                          if (currentUserEmail != '') {
                            _model.existingChat = await queryChatsRecordOnce(
                              queryBuilder: (chatsRecord) => chatsRecord.where(
                                'pendingBasket',
                                isEqualTo: widget.pendingBasketRef,
                              ),
                              singleRecord: true,
                            ).then((s) => s.firstOrNull);
                            _shouldSetState = true;
                            if (_model.existingChat?.reference != null) {
                              context.pushNamed(
                                Chat2DetailsCartWidget.routeName,
                                queryParameters: {
                                  'chatDoc': serializeParam(
                                    _model.existingChat,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'chatDoc': _model.existingChat,
                                },
                              );

                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                            _model.addToUsersList(widget.seller!);
                            _model.addToUsersList(currentUserReference!);
                            // newChat

                            var chatsRecordReference =
                                ChatsRecord.collection.doc();
                            await chatsRecordReference.set({
                              ...createChatsRecordData(
                                userA: currentUserReference,
                                userB: widget.seller,
                                lastMessage: '',
                                lastMessageTime: getCurrentTimestamp,
                                lastMessageSentBy: currentUserReference,
                                groupChatId:
                                    random_data.randomInteger(1000000, 9999999),
                                productRef: widget
                                    .basketItems?.firstOrNull?.productRef,
                                isListingMessage: true,
                                isEmptyChat: false,
                                pendingBasket: widget.pendingBasketRef,
                              ),
                              ...mapToFirestore(
                                {
                                  'users': _model.usersList,
                                },
                              ),
                            });
                            _model.newListingChatThread3 =
                                ChatsRecord.getDocumentFromData({
                              ...createChatsRecordData(
                                userA: currentUserReference,
                                userB: widget.seller,
                                lastMessage: '',
                                lastMessageTime: getCurrentTimestamp,
                                lastMessageSentBy: currentUserReference,
                                groupChatId:
                                    random_data.randomInteger(1000000, 9999999),
                                productRef: widget
                                    .basketItems?.firstOrNull?.productRef,
                                isListingMessage: true,
                                isEmptyChat: false,
                                pendingBasket: widget.pendingBasketRef,
                              ),
                              ...mapToFirestore(
                                {
                                  'users': _model.usersList,
                                },
                              ),
                            }, chatsRecordReference);
                            _shouldSetState = true;
                            triggerPushNotification(
                              notificationTitle:
                                  '${currentUserDisplayName} sent you a produce request!',
                              notificationText:
                                  'Click to view items and message them',
                              notificationImageUrl: currentUserPhoto,
                              notificationSound: 'default',
                              userRefs: [columnPendingBasketRecord.sellerRef!],
                              initialPageName: 'chat_2_Details_Cart',
                              parameterData: {
                                'chatDoc': _model.newListingChatThread3,
                              },
                            );

                            context.pushNamed(
                              Chat2DetailsCartWidget.routeName,
                              queryParameters: {
                                'chatDoc': serializeParam(
                                  _model.newListingChatThread3,
                                  ParamType.Document,
                                ),
                              }.withoutNulls,
                              extra: <String, dynamic>{
                                'chatDoc': _model.newListingChatThread3,
                              },
                            );
                          } else {
                            context.pushNamed(LogInPageWidget.routeName);
                          }

                          if (_shouldSetState) safeSetState(() {});
                        },
                        text: 'Send Purchase Request',
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).secondary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    font: GoogleFonts.ibmPlexMono(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
