import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/marketplace/marketplace_assets/basket_item/basket_item_widget.dart';
import '/pages/marketplace/marketplace_assets/order_item/order_item_widget.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seller_orders_page_model.dart';
export 'seller_orders_page_model.dart';

class SellerOrdersPageWidget extends StatefulWidget {
  const SellerOrdersPageWidget({
    super.key,
    bool? justApproved,
  }) : this.justApproved = justApproved ?? false;

  final bool justApproved;

  static String routeName = 'sellerOrdersPage';
  static String routePath = '/sellerOrdersPage';

  @override
  State<SellerOrdersPageWidget> createState() => _SellerOrdersPageWidgetState();
}

class _SellerOrdersPageWidgetState extends State<SellerOrdersPageWidget>
    with TickerProviderStateMixin {
  late SellerOrdersPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SellerOrdersPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (widget.justApproved) {
        safeSetState(() {
          _model.tabBarController!.animateTo(
            1,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        });

        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Request Approved!'),
              content: Text(
                  'Message the buyer to coordinate a pick-up time and make sure to upload a picture of the drop-off on the pending sales page to get paid.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Happy Selling!'),
                ),
              ],
            );
          },
        );
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
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
                  context.goNamed(MarketplaceExploreListingsWidget.routeName);
                },
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 10.0, 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.tag,
                      color: FlutterFlowTheme.of(context).secondary,
                      size: 35.0,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                    child: Text(
                      'My Sales',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.ibmPlexMono(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 27.0,
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
                ],
              ),
              actions: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(Chat2MainNewWidget.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                      child: Icon(
                        Icons.chat_bubble,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              toolbarHeight: 100.0,
              elevation: 0.0,
            ),
          ),
          body: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment(0.0, 0),
                          child: FlutterFlowButtonTabBar(
                            useToggleButtonStyle: false,
                            labelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.inter(
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
                            unselectedLabelStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                                  font: GoogleFonts.inter(
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
                            labelColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            unselectedLabelColor:
                                FlutterFlowTheme.of(context).primaryText,
                            backgroundColor:
                                FlutterFlowTheme.of(context).secondary,
                            unselectedBackgroundColor:
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                            unselectedBorderColor:
                                FlutterFlowTheme.of(context).primaryText,
                            borderWidth: 1.5,
                            borderRadius: 52.0,
                            elevation: 0.0,
                            buttonMargin: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            tabs: [
                              Tab(
                                text: 'Requests',
                              ),
                              Tab(
                                text: 'Pending',
                              ),
                              Tab(
                                text: 'Fulfilled',
                              ),
                            ],
                            controller: _model.tabBarController,
                            onTap: (i) async {
                              [() async {}, () async {}, () async {}][i]();
                            },
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _model.tabBarController,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: StreamBuilder<
                                          List<PendingBasketRecord>>(
                                        stream: queryPendingBasketRecord(
                                          queryBuilder: (pendingBasketRecord) =>
                                              pendingBasketRecord.where(
                                            'sellerRef',
                                            isEqualTo: currentUserReference,
                                          ),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<PendingBasketRecord>
                                              listViewPendingBasketRecordList =
                                              snapshot.data!;

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewPendingBasketRecordList
                                                    .length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewPendingBasketRecord =
                                                  listViewPendingBasketRecordList[
                                                      listViewIndex];
                                              return StreamBuilder<
                                                  List<ChatsRecord>>(
                                                stream: queryChatsRecord(
                                                  queryBuilder: (chatsRecord) =>
                                                      chatsRecord.where(
                                                    'pendingBasket',
                                                    isEqualTo:
                                                        listViewPendingBasketRecord
                                                            .reference,
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
                                                  List<ChatsRecord>
                                                      containerChatsRecordList =
                                                      snapshot.data!;
                                                  // Return an empty Container when the item does not exist.
                                                  if (snapshot.data!.isEmpty) {
                                                    return Container();
                                                  }
                                                  final containerChatsRecord =
                                                      containerChatsRecordList
                                                              .isNotEmpty
                                                          ? containerChatsRecordList
                                                              .first
                                                          : null;

                                                  return Container(
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  10.0,
                                                                  10.0,
                                                                  10.0),
                                                      child: BasketItemWidget(
                                                        key: Key(
                                                            'Keya42_${listViewIndex}_of_${listViewPendingBasketRecordList.length}'),
                                                        seller:
                                                            currentUserReference!,
                                                        basketItems:
                                                            listViewPendingBasketRecord
                                                                .basketItems,
                                                        pendingBasketRef:
                                                            containerChatsRecord!
                                                                .pendingBasket!,
                                                        pending: false,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: StreamBuilder<List<OrdersRecord>>(
                                        stream: queryOrdersRecord(
                                          queryBuilder: (ordersRecord) =>
                                              ordersRecord.where(
                                            'seller',
                                            isEqualTo: currentUserReference,
                                          ),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<OrdersRecord>
                                              listViewOrdersRecordList =
                                              snapshot.data!;

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewOrdersRecordList.length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewOrdersRecord =
                                                  listViewOrdersRecordList[
                                                      listViewIndex];
                                              return Visibility(
                                                visible: listViewOrdersRecord
                                                            .fulfillImage ==
                                                        '',
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 10.0),
                                                  child: OrderItemWidget(
                                                    key: Key(
                                                        'Keycoq_${listViewIndex}_of_${listViewOrdersRecordList.length}'),
                                                    seller: listViewOrdersRecord
                                                        .seller!,
                                                    orderItems:
                                                        listViewOrdersRecord
                                                            .items,
                                                    orderRef:
                                                        listViewOrdersRecord
                                                            .reference,
                                                    buyerPaid:
                                                        listViewOrdersRecord
                                                            .buyerPaid,
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
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: StreamBuilder<List<OrdersRecord>>(
                                        stream: queryOrdersRecord(
                                          queryBuilder: (ordersRecord) =>
                                              ordersRecord.where(
                                            'seller',
                                            isEqualTo: currentUserReference,
                                          ),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<OrdersRecord>
                                              listViewOrdersRecordList =
                                              snapshot.data!;

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listViewOrdersRecordList.length,
                                            itemBuilder:
                                                (context, listViewIndex) {
                                              final listViewOrdersRecord =
                                                  listViewOrdersRecordList[
                                                      listViewIndex];
                                              return Visibility(
                                                visible: listViewOrdersRecord
                                                            .fulfillImage !=
                                                        '',
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 10.0),
                                                  child: OrderItemWidget(
                                                    key: Key(
                                                        'Key7zd_${listViewIndex}_of_${listViewOrdersRecordList.length}'),
                                                    seller: listViewOrdersRecord
                                                        .seller!,
                                                    orderItems:
                                                        listViewOrdersRecord
                                                            .items,
                                                    orderRef:
                                                        listViewOrdersRecord
                                                            .reference,
                                                    buyerPaid:
                                                        listViewOrdersRecord
                                                            .buyerPaid,
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
