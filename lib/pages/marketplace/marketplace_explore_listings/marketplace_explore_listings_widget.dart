import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/tour_market_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/marketplace/marketplace_assets/empty_list_message/empty_list_message_widget.dart';
import '/pages/marketplace/marketplace_assets/filter_overlay/filter_overlay_widget.dart';
import '/pages/marketplace/marketplace_assets/listing/listing_widget.dart';
import '/pages/marketplace/marketplace_assets/listing_large/listing_large_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'marketplace_explore_listings_model.dart';
export 'marketplace_explore_listings_model.dart';

class MarketplaceExploreListingsWidget extends StatefulWidget {
  const MarketplaceExploreListingsWidget({
    super.key,
    bool? onTour,
  }) : this.onTour = onTour ?? false;

  final bool onTour;

  static String routeName = 'MarketplaceExploreListings';
  static String routePath = '/marketplaceExploreListings';

  @override
  State<MarketplaceExploreListingsWidget> createState() =>
      _MarketplaceExploreListingsWidgetState();
}

class _MarketplaceExploreListingsWidgetState
    extends State<MarketplaceExploreListingsWidget>
    with TickerProviderStateMixin {
  late MarketplaceExploreListingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MarketplaceExploreListingsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        _model.tempNotMine = await queryProductRecordOnce(
          queryBuilder: (productRecord) => productRecord
              .where('isArchived', isEqualTo: false)
              .where('seller', isNotEqualTo: currentUserReference),
          limit: 50,
        );
        _model.tempMine = await queryProductRecordOnce(
          queryBuilder: (productRecord) => productRecord.where(
            'seller',
            isEqualTo: currentUserReference,
          ),
          limit: 50,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load listings: ${e.toString()}')),
          );
        }
        _model.tempNotMine = [];
        _model.tempMine = [];
      }
      if (isAndroid) {
        _model.linkToApp =
            'https://play.google.com/store/apps/details?id=com.plantculture';
        safeSetState(() {});
      }
      if (widget.onTour) {
        await showDialog(
          barrierColor: Color(0x32000000),
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
                child: TourMarketWidget(),
              ),
            );
          },
        );
      }
      if (!((valueOrDefault(currentUserDocument?.stripeAccountID, '') != '') &&
          !valueOrDefault<bool>(
              currentUserDocument?.stripeChargesEnabled, false))) {
        safeSetState(() {});
        return;
      }
      _model.stripeRetrieveOnLoad =
          await StripeGroup.retrieveAccountInfoCall.call(
        accountID: valueOrDefault(currentUserDocument?.stripeAccountID, ''),
      );

      if ((_model.stripeRetrieveOnLoad?.succeeded ?? true)) {
        if (!StripeGroup.retrieveAccountInfoCall.chargesEnabled(
          (_model.stripeRetrieveOnLoad?.jsonBody ?? ''),
        )!) {
          safeSetState(() {});
          return;
        }

        await currentUserReference!.update(createUsersRecordData(
          stripeChargesEnabled: true,
        ));
      } else {
        safeSetState(() {});
        return;
      }

      safeSetState(() {});
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    _model.tabBarController1 = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.tabBarController2 = TabController(
      vsync: this,
      length: 1,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    animationsMap.addAll({
      'textFieldOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.easeIn,
            delay: 0.0.ms,
            duration: 630.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.0, 1.0),
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
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  if (currentUserEmail != '') {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 0.0,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 134.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 1.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                if (_model
                                                        .tabBarCurrentIndex1 ==
                                                    0) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                25.0, 15.0),
                                                    child:
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          Colors.transparent,
                                                      borderRadius: 20.0,
                                                      borderWidth: 2.0,
                                                      buttonSize: 50.0,
                                                      icon: Icon(
                                                        Icons.search,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .accent2,
                                                        size: 40.0,
                                                      ),
                                                      onPressed: () async {
                                                        context.pushNamed(
                                                            SearchListingsWidget
                                                                .routeName);
                                                      },
                                                    ),
                                                  );
                                                } else {
                                                  return Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, -1.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  15.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Icon(
                                                          Icons.arrow_back,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 5.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 40.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'OurMarket',
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 32.0,
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
                                                            .fromSTEB(10.0,
                                                                40.0, 0.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        var _shouldSetState =
                                                            false;
                                                        if (valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.stripeAccountID,
                                                                    '') ==
                                                                '') {
                                                          await currentUserReference!
                                                              .update(
                                                                  createUsersRecordData(
                                                            stripeAccountID: '',
                                                          ));
                                                        }
                                                        if (valueOrDefault<
                                                                    bool>(
                                                                currentUserDocument
                                                                    ?.stripeChargesEnabled,
                                                                false) &&
                                                            (valueOrDefault(
                                                                        currentUserDocument
                                                                            ?.stripeAccountID,
                                                                        '') !=
                                                                    '')) {
                                                        } else if (valueOrDefault(
                                                                    currentUserDocument
                                                                        ?.stripeAccountID,
                                                                    '') !=
                                                                '') {
                                                          var confirmDialogResponse =
                                                              await showDialog<
                                                                      bool>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Set up Your Stripe Account'),
                                                                        content:
                                                                            Text('Please finish setting up your Stripe account to sell'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, false),
                                                                            child:
                                                                                Text('Cancel'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, true),
                                                                            child:
                                                                                Text('Proceed'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ) ??
                                                                  false;
                                                          if (!confirmDialogResponse) {
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }
                                                          _model.stripeRetrieveAccountInfo =
                                                              await StripeGroup
                                                                  .retrieveAccountInfoCall
                                                                  .call(
                                                            accountID: valueOrDefault(
                                                                currentUserDocument
                                                                    ?.stripeAccountID,
                                                                ''),
                                                          );

                                                          _shouldSetState =
                                                              true;
                                                          if (!(_model
                                                                  .stripeRetrieveAccountInfo
                                                                  ?.succeeded ??
                                                              true)) {
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }
                                                          if (StripeGroup
                                                              .retrieveAccountInfoCall
                                                              .chargesEnabled(
                                                            (_model.stripeRetrieveAccountInfo
                                                                    ?.jsonBody ??
                                                                ''),
                                                          )!) {
                                                            await currentUserReference!
                                                                .update(
                                                                    createUsersRecordData(
                                                              stripeChargesEnabled:
                                                                  true,
                                                            ));
                                                          } else {
                                                            _model.stripeCreateAccountLink2 =
                                                                await StripeGroup
                                                                    .createAccountLinkCall
                                                                    .call(
                                                              account: valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.stripeAccountID,
                                                                  ''),
                                                              type:
                                                                  'account_onboarding',
                                                              refreshUrl: _model
                                                                  .linkToApp,
                                                              returnUrl: _model
                                                                  .linkToApp,
                                                            );

                                                            _shouldSetState =
                                                                true;
                                                            if ((_model
                                                                    .stripeCreateAccountLink2
                                                                    ?.succeeded ??
                                                                true)) {
                                                              await launchURL(
                                                                  StripeGroup
                                                                      .createAccountLinkCall
                                                                      .url(
                                                                (_model.stripeCreateAccountLink2
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )!);
                                                            } else {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }

                                                            _model.stripeRetrieveAccountInfo2 =
                                                                await StripeGroup
                                                                    .retrieveAccountInfoCall
                                                                    .call(
                                                              accountID: valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.stripeAccountID,
                                                                  ''),
                                                            );

                                                            _shouldSetState =
                                                                true;
                                                            if ((_model
                                                                    .stripeRetrieveAccountInfo2
                                                                    ?.succeeded ??
                                                                true)) {
                                                              if (StripeGroup
                                                                  .retrieveAccountInfoCall
                                                                  .chargesEnabled(
                                                                (_model.stripeRetrieveAccountInfo2
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )!) {
                                                                await currentUserReference!
                                                                    .update(
                                                                        createUsersRecordData(
                                                                  stripeChargesEnabled:
                                                                      true,
                                                                ));
                                                              } else {
                                                                if (_shouldSetState)
                                                                  safeSetState(
                                                                      () {});
                                                                return;
                                                              }
                                                            } else {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }
                                                          }
                                                        } else {
                                                          var confirmDialogResponse =
                                                              await showDialog<
                                                                      bool>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Set up Your Stripe Account'),
                                                                        content:
                                                                            Text('Please set up a Stripe account to sell your produce'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, false),
                                                                            child:
                                                                                Text('Cancel'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, true),
                                                                            child:
                                                                                Text('Proceed'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ) ??
                                                                  false;
                                                          if (!confirmDialogResponse) {
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }
                                                          _model.createStripeAccount =
                                                              await StripeGroup
                                                                  .accountsCall
                                                                  .call(
                                                            businessType:
                                                                'individual',
                                                            type: 'standard',
                                                            country: 'us',
                                                            email:
                                                                currentUserEmail,
                                                          );

                                                          _shouldSetState =
                                                              true;
                                                          if ((_model
                                                                  .createStripeAccount
                                                                  ?.succeeded ??
                                                              true)) {
                                                            await currentUserReference!
                                                                .update(
                                                                    createUsersRecordData(
                                                              stripeAccountID:
                                                                  StripeGroup
                                                                      .accountsCall
                                                                      .id(
                                                                (_model.createStripeAccount
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ),
                                                            ));
                                                            _model.stripeCreateAccountLink =
                                                                await StripeGroup
                                                                    .createAccountLinkCall
                                                                    .call(
                                                              account: StripeGroup
                                                                  .accountsCall
                                                                  .id(
                                                                (_model.createStripeAccount
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ),
                                                              type:
                                                                  'account_onboarding',
                                                              refreshUrl: _model
                                                                  .linkToApp,
                                                              returnUrl: _model
                                                                  .linkToApp,
                                                            );

                                                            _shouldSetState =
                                                                true;
                                                            if ((_model
                                                                    .stripeCreateAccountLink
                                                                    ?.succeeded ??
                                                                true)) {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                stripeAccountSetup:
                                                                    StripeGroup
                                                                        .createAccountLinkCall
                                                                        .url(
                                                                  (_model.stripeCreateAccountLink
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                ),
                                                              ));
                                                              await launchURL(
                                                                  StripeGroup
                                                                      .createAccountLinkCall
                                                                      .url(
                                                                (_model.stripeCreateAccountLink
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              )!);
                                                            } else {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }
                                                          } else {
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }

                                                          _model.stripeRetrieveAccountInfo3 =
                                                              await StripeGroup
                                                                  .retrieveAccountInfoCall
                                                                  .call(
                                                            accountID: valueOrDefault(
                                                                currentUserDocument
                                                                    ?.stripeAccountID,
                                                                ''),
                                                          );

                                                          _shouldSetState =
                                                              true;
                                                          if ((_model
                                                                  .stripeRetrieveAccountInfo3
                                                                  ?.succeeded ??
                                                              true)) {
                                                            if (StripeGroup
                                                                .retrieveAccountInfoCall
                                                                .chargesEnabled(
                                                              (_model.stripeRetrieveAccountInfo3
                                                                      ?.jsonBody ??
                                                                  ''),
                                                            )!) {
                                                              await currentUserReference!
                                                                  .update(
                                                                      createUsersRecordData(
                                                                stripeChargesEnabled:
                                                                    true,
                                                              ));
                                                            } else {
                                                              if (_shouldSetState)
                                                                safeSetState(
                                                                    () {});
                                                              return;
                                                            }
                                                          } else {
                                                            if (_shouldSetState)
                                                              safeSetState(
                                                                  () {});
                                                            return;
                                                          }
                                                        }

                                                        if (_model
                                                                .tabBarCurrentIndex1 ==
                                                            0) {
                                                          safeSetState(() {
                                                            _model
                                                                .tabBarController1!
                                                                .animateTo(
                                                              1,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                              curve:
                                                                  Curves.ease,
                                                            );
                                                          });

                                                          context.pushNamed(
                                                              PostListingWidget
                                                                  .routeName);
                                                        } else {
                                                          context.pushNamed(
                                                              PostListingWidget
                                                                  .routeName);
                                                        }

                                                        if (_shouldSetState)
                                                          safeSetState(() {});
                                                      },
                                                      text: 'Sell',
                                                      options: FFButtonOptions(
                                                        width: 70.0,
                                                        height: 35.0,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .ibmPlexMono(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelSmall
                                                                      .fontStyle,
                                                                ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          if ((_model.tabBarCurrentIndex1 ==
                                                  1) &&
                                              valueOrDefault<bool>(
                                                  currentUserDocument
                                                      ?.stripeChargesEnabled,
                                                  false))
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 15.0),
                                                child: AuthUserStreamWidget(
                                                  builder: (context) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                          BasketPageWidget
                                                              .routeName);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
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
                                                          context.pushNamed(
                                                              SellerOrdersPageWidget
                                                                  .routeName);
                                                        },
                                                        child: Icon(
                                                          Icons.sell_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          size: 40.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (_model.tabBarCurrentIndex1 == 0)
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 15.0),
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
                                                    context.pushNamed(
                                                        BasketPageWidget
                                                            .routeName);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                    child: Icon(
                                                      Icons
                                                          .shopping_basket_rounded,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent2,
                                                      size: 40.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if (_model.tabBarCurrentIndex1 == 0) {
                                        return Container(
                                          width: 382.0,
                                          height: 47.0,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Builder(
                                                builder: (context) {
                                                  if (currentUserDocument
                                                          ?.location ==
                                                      null) {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  180.0,
                                                                  0.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 20.0,
                                                        borderWidth: 1.0,
                                                        buttonSize: 55.0,
                                                        icon: Icon(
                                                          Icons
                                                              .location_off_outlined,
                                                          color:
                                                              Color(0xFF00ADEA),
                                                          size: 40.0,
                                                        ),
                                                        onPressed: () async {
                                                          var confirmDialogResponse =
                                                              await showDialog<
                                                                      bool>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Location Services'),
                                                                        content:
                                                                            Text('In order to search nearby, this app requires access to your current location.'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, false),
                                                                            child:
                                                                                Text('Not Now'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, true),
                                                                            child:
                                                                                Text('Confirm'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ) ??
                                                                  false;
                                                          if (confirmDialogResponse) {
                                                            context.pushNamed(
                                                                LocationServicesWidget
                                                                    .routeName);
                                                          }
                                                        },
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                      height: 42.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          1.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        context.pushNamed(
                                                                            LocationServicesWidget.routeName);
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .location_on,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            24.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        143.0,
                                                                    height:
                                                                        20.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                                                                              child: AuthUserStreamWidget(
                                                                                builder: (context) => Text(
                                                                                  valueOrDefault(currentUserDocument?.city, ''),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.ibmPlexMono(
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        fontSize: 14.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
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
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: 175.0,
                                                              height: 1.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                border:
                                                                    Border.all(
                                                                  color: Color(
                                                                      0xFFA3A2A2),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                              if (_model.filtersImplementedHere)
                                                SizedBox(
                                                  height: 35.0,
                                                  child: VerticalDivider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              Container(
                                                width: 31.0,
                                                decoration: BoxDecoration(),
                                                child: Visibility(
                                                  visible: _model
                                                      .filtersImplementedHere,
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
                                                      await showModalBottomSheet(
                                                        isScrollControlled:
                                                            true,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        context: context,
                                                        builder: (context) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              FocusScope.of(
                                                                      context)
                                                                  .unfocus();
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                            },
                                                            child: Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child: Container(
                                                                height: 660.0,
                                                                child:
                                                                    FilterOverlayWidget(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).then((value) =>
                                                          safeSetState(() {}));
                                                    },
                                                    child: Icon(
                                                      Icons.filter_list_sharp,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 35.0,
                                                child: VerticalDivider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              Flexible(
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
                                                    _model.formatSplit =
                                                        !_model.formatSplit;
                                                    safeSetState(() {});
                                                  },
                                                  child: Container(
                                                    height: 30.0,
                                                    constraints: BoxConstraints(
                                                      maxWidth: 50.0,
                                                    ),
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.formatSplit =
                                                                !_model
                                                                    .formatSplit;
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .splitscreen_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                        InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            _model.formatSplit =
                                                                !_model
                                                                    .formatSplit;
                                                            safeSetState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .square_outlined,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          width: 382.0,
                                          height: 47.0,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 5.0, 10.0, 5.0),
                                                  child: Container(
                                                    width: 200.0,
                                                    child: TextFormField(
                                                      controller:
                                                          _model.textController,
                                                      focusNode: _model
                                                          .textFieldFocusNode,
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        hintText: 'Search',
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
                                                                  color: Color(
                                                                      0x8200ADEA),
                                                                  fontSize:
                                                                      13.0,
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
                                                                0x7900ADEA),
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
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
                                                                      24.0),
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
                                                                      24.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0x1A00ADEA),
                                                        prefixIcon: Icon(
                                                          Icons.search_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                        ),
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 13.0,
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
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .textControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ).animateOnActionTrigger(
                                                    animationsMap[
                                                        'textFieldOnActionTriggerAnimation']!,
                                                  ),
                                                ),
                                              ),
                                              if (_model.filtersImplementedHere)
                                                SizedBox(
                                                  height: 35.0,
                                                  child: VerticalDivider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              if (_model.filtersImplementedHere)
                                                Container(
                                                  width: 31.0,
                                                  decoration: BoxDecoration(),
                                                  child: Icon(
                                                    Icons.filter_list_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              SizedBox(
                                                height: 35.0,
                                                child: VerticalDivider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.formatSplit =
                                                      !_model.formatSplit;
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.splitscreen_rounded,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.formatSplit =
                                                      !_model.formatSplit;
                                                  safeSetState(() {});
                                                },
                                                child: Icon(
                                                  Icons.square_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment(0.0, 0),
                                child: FlutterFlowButtonTabBar(
                                  useToggleButtonStyle: false,
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
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                  unselectedLabelStyle:
                                      FlutterFlowTheme.of(context)
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
                                            fontSize: 14.0,
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
                                  labelColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  unselectedLabelColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).accent2,
                                  unselectedBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  borderColor:
                                      FlutterFlowTheme.of(context).secondary,
                                  unselectedBorderColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  borderWidth: 1.5,
                                  borderRadius: 20.0,
                                  elevation: 0.0,
                                  buttonMargin: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 0.0, 8.0, 0.0),
                                  padding: EdgeInsets.all(2.0),
                                  tabs: [
                                    Tab(
                                      text: 'Community',
                                    ),
                                    Tab(
                                      text: 'My Listings',
                                    ),
                                  ],
                                  controller: _model.tabBarController1,
                                  onTap: (i) async {
                                    [() async {}, () async {}][i]();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: _model.tabBarController1,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        if ((currentUserDocument?.location !=
                                                null) &&
                                            (valueOrDefault(
                                                    currentUserDocument?.city,
                                                    '') !=
                                                'N/A')) {
                                          return Builder(
                                            builder: (context) {
                                              if (_model.formatSplit) {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final gridView = functions
                                                              .getProductsDistance(
                                                                  _model
                                                                      .tempNotMine
                                                                      ?.toList(),
                                                                  1000.0,
                                                                  currentUserDocument
                                                                      ?.location)
                                                              ?.toList() ??
                                                          [];
                                                      if (gridView.isEmpty) {
                                                        return EmptyListMessageWidget(
                                                          message1:
                                                              'No Listings For Sale Near Your Current Location',
                                                          message2:
                                                              'Please check for more listings at a later time!',
                                                        );
                                                      }

                                                      return GridView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 5.0,
                                                          childAspectRatio: 1.0,
                                                        ),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            gridView.length,
                                                        itemBuilder: (context,
                                                            gridViewIndex) {
                                                          final gridViewItem =
                                                              gridView[
                                                                  gridViewIndex];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (gridViewItem
                                                                      .seller ==
                                                                  currentUserReference) {
                                                                context
                                                                    .pushNamed(
                                                                  MyListingWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'listingtoPost':
                                                                        serializeParam(
                                                                      gridViewItem
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  ListingDetailsWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'listingtoPost':
                                                                        serializeParam(
                                                                      gridViewItem
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .listingModels1
                                                                  .getModel(
                                                                currentUserUid,
                                                                gridViewIndex,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  ListingWidget(
                                                                key: Key(
                                                                  'Keyk33_${currentUserUid}',
                                                                ),
                                                                listingPrice:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  functions.displayValidPrice(
                                                                      gridViewItem
                                                                          .price),
                                                                  '0.00',
                                                                ),
                                                                listingName:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  gridViewItem
                                                                      .title,
                                                                  'New Listing',
                                                                ),
                                                                listingImage:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  gridViewItem
                                                                      .image,
                                                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                                                ),
                                                                listingUnit:
                                                                    valueOrDefault<
                                                                        String>(
                                                                  gridViewItem
                                                                      .unitType,
                                                                  'pound',
                                                                ),
                                                                numUnits:
                                                                    valueOrDefault<
                                                                        int>(
                                                                  gridViewItem
                                                                      .units,
                                                                  0,
                                                                ),
                                                                listing:
                                                                    gridViewItem,
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final listView = functions
                                                              .getProductsDistance(
                                                                  _model
                                                                      .tempNotMine
                                                                      ?.toList(),
                                                                  1000.0,
                                                                  currentUserDocument
                                                                      ?.location)
                                                              ?.toList() ??
                                                          [];
                                                      if (listView.isEmpty) {
                                                        return EmptyListMessageWidget(
                                                          message1:
                                                              'No Listings For Sale Near Your Current Location',
                                                          message2:
                                                              'Please check for more listings at a later time!',
                                                        );
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            listView.length,
                                                        itemBuilder: (context,
                                                            listViewIndex) {
                                                          final listViewItem =
                                                              listView[
                                                                  listViewIndex];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                ListingDetailsWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'listingtoPost':
                                                                      serializeParam(
                                                                    listViewItem
                                                                        .reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .listingLargeModels1
                                                                  .getModel(
                                                                currentUserUid,
                                                                listViewIndex,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  ListingLargeWidget(
                                                                key: Key(
                                                                  'Keywb2_${currentUserUid}',
                                                                ),
                                                                listingPrice: functions
                                                                    .displayValidPrice(
                                                                        listViewItem
                                                                            .price)!,
                                                                listingName:
                                                                    listViewItem
                                                                        .title,
                                                                listingImage:
                                                                    listViewItem
                                                                        .image,
                                                                listingUnit:
                                                                    listViewItem
                                                                        .unitType,
                                                                numUnits:
                                                                    listViewItem
                                                                        .units,
                                                                listing:
                                                                    listViewItem,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        } else if (_model
                                            .enoughListingsToFilterByLoc) {
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 10.0, 5.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final grid = _model.tempNotMine
                                                        ?.where((e) =>
                                                            (e.seller !=
                                                                currentUserReference) &&
                                                            (e.isArchived ==
                                                                false))
                                                        .toList()
                                                        .toList() ??
                                                    [];
                                                if (grid.isEmpty) {
                                                  return Center(
                                                    child:
                                                        EmptyListMessageWidget(
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: grid.length,
                                                  itemBuilder:
                                                      (context, gridIndex) {
                                                    final gridItem =
                                                        grid[gridIndex];
                                                    return Visibility(
                                                      visible: gridItem
                                                              .seller !=
                                                          currentUserReference,
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
                                                          if (gridItem.seller ==
                                                              currentUserReference) {
                                                            context.pushNamed(
                                                              MyListingWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'listingtoPost':
                                                                    serializeParam(
                                                                  gridItem
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
                                                                  gridItem
                                                                      .reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        },
                                                        child: wrapWithModel(
                                                          model: _model
                                                              .listingModels2
                                                              .getModel(
                                                            currentUserUid,
                                                            gridIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: ListingWidget(
                                                            key: Key(
                                                              'Keyxik_${currentUserUid}',
                                                            ),
                                                            listingPrice: functions
                                                                .displayValidPrice(
                                                                    gridItem
                                                                        .price)!,
                                                            listingName:
                                                                gridItem.title,
                                                            listingImage:
                                                                gridItem.image,
                                                            listingUnit:
                                                                gridItem
                                                                    .unitType,
                                                            numUnits:
                                                                gridItem.units,
                                                            listing: gridItem,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        } else {
                                          return Builder(
                                            builder: (context) {
                                              if (_model.formatSplit) {
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 10.0, 5.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final grid2 = _model
                                                              .tempNotMine
                                                              ?.toList() ??
                                                          [];
                                                      if (grid2.isEmpty) {
                                                        return Center(
                                                          child:
                                                              EmptyListMessageWidget(
                                                            message1:
                                                                'No Listings Currently For Sale',
                                                            message2:
                                                                'Please check for more listings at a later time!',
                                                          ),
                                                        );
                                                      }

                                                      return GridView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 2,
                                                          crossAxisSpacing: 5.0,
                                                          childAspectRatio: 1.0,
                                                        ),
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount: grid2.length,
                                                        itemBuilder: (context,
                                                            grid2Index) {
                                                          final grid2Item =
                                                              grid2[grid2Index];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              if (grid2Item
                                                                      .seller ==
                                                                  currentUserReference) {
                                                                context
                                                                    .pushNamed(
                                                                  MyListingWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'listingtoPost':
                                                                        serializeParam(
                                                                      grid2Item
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              } else {
                                                                context
                                                                    .pushNamed(
                                                                  ListingDetailsWidget
                                                                      .routeName,
                                                                  queryParameters:
                                                                      {
                                                                    'listingtoPost':
                                                                        serializeParam(
                                                                      grid2Item
                                                                          .reference,
                                                                      ParamType
                                                                          .DocumentReference,
                                                                    ),
                                                                  }.withoutNulls,
                                                                );
                                                              }
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .listingModels3
                                                                  .getModel(
                                                                currentUserUid,
                                                                grid2Index,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  ListingWidget(
                                                                key: Key(
                                                                  'Keyphm_${currentUserUid}',
                                                                ),
                                                                listingPrice: functions
                                                                    .displayValidPrice(
                                                                        grid2Item
                                                                            .price)!,
                                                                listingName:
                                                                    grid2Item
                                                                        .title,
                                                                listingImage:
                                                                    grid2Item
                                                                        .image,
                                                                listingUnit:
                                                                    grid2Item
                                                                        .unitType,
                                                                numUnits:
                                                                    grid2Item
                                                                        .units,
                                                                listing:
                                                                    grid2Item,
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
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 10.0, 5.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final listView1 = _model
                                                              .tempNotMine
                                                              ?.toList() ??
                                                          [];
                                                      if (listView1.isEmpty) {
                                                        return Center(
                                                          child:
                                                              EmptyListMessageWidget(
                                                            message1:
                                                                'No Listings Currently For Sale',
                                                            message2:
                                                                'Please check for more listings at a later time!',
                                                          ),
                                                        );
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            listView1.length,
                                                        itemBuilder: (context,
                                                            listView1Index) {
                                                          final listView1Item =
                                                              listView1[
                                                                  listView1Index];
                                                          return InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              context.pushNamed(
                                                                ListingDetailsWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'listingtoPost':
                                                                      serializeParam(
                                                                    listView1Item
                                                                        .reference,
                                                                    ParamType
                                                                        .DocumentReference,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .listingLargeModels2
                                                                  .getModel(
                                                                currentUserUid,
                                                                listView1Index,
                                                              ),
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  ListingLargeWidget(
                                                                key: Key(
                                                                  'Keycwq_${currentUserUid}',
                                                                ),
                                                                listingPrice: functions
                                                                    .displayValidPrice(
                                                                        listView1Item
                                                                            .price)!,
                                                                listingName:
                                                                    listView1Item
                                                                        .title,
                                                                listingImage:
                                                                    listView1Item
                                                                        .image,
                                                                listingUnit:
                                                                    listView1Item
                                                                        .unitType,
                                                                numUnits:
                                                                    listView1Item
                                                                        .units,
                                                                listing:
                                                                    listView1Item,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                        }
                                      },
                                    ),
                                    Builder(
                                      builder: (context) {
                                        if (_model.formatSplit) {
                                          return Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final grid3 =
                                                    _model.tempMine?.toList() ??
                                                        [];
                                                if (grid3.isEmpty) {
                                                  return Center(
                                                    child:
                                                        EmptyListMessageWidget(
                                                      message1:
                                                          'No Current Active Listings',
                                                      message2:
                                                          'You can create one now by pressing the Sell button above! ',
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: grid3.length,
                                                  itemBuilder:
                                                      (context, grid3Index) {
                                                    final grid3Item =
                                                        grid3[grid3Index];
                                                    return Visibility(
                                                      visible: functions
                                                              .easyTextSearch(
                                                                  _model
                                                                      .textController
                                                                      .text,
                                                                  grid3Item
                                                                      .title) ??
                                                          true,
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
                                                          context.pushNamed(
                                                            MyListingWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'listingtoPost':
                                                                  serializeParam(
                                                                grid3Item
                                                                    .reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: wrapWithModel(
                                                          model: _model
                                                              .listingModels4
                                                              .getModel(
                                                            currentUserUid,
                                                            grid3Index,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: ListingWidget(
                                                            key: Key(
                                                              'Keylqr_${currentUserUid}',
                                                            ),
                                                            listingPrice:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .displayValidPrice(
                                                                      grid3Item
                                                                          .price),
                                                              '0.00',
                                                            ),
                                                            listingName:
                                                                grid3Item.title,
                                                            listingImage:
                                                                grid3Item.image,
                                                            listingUnit:
                                                                grid3Item
                                                                    .unitType,
                                                            numUnits:
                                                                grid3Item.units,
                                                            listing: grid3Item,
                                                          ),
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final listView2 =
                                                    _model.tempMine?.toList() ??
                                                        [];

                                                return ListView.separated(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: listView2.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 100.0),
                                                  itemBuilder: (context,
                                                      listView2Index) {
                                                    final listView2Item =
                                                        listView2[
                                                            listView2Index];
                                                    return Visibility(
                                                      visible: functions
                                                              .easyTextSearch(
                                                                  _model
                                                                      .textController
                                                                      .text,
                                                                  listView2Item
                                                                      .title) ??
                                                          true,
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
                                                          context.pushNamed(
                                                            MyListingWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'listingtoPost':
                                                                  serializeParam(
                                                                listView2Item
                                                                    .reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: wrapWithModel(
                                                          model: _model
                                                              .listingLargeModels3
                                                              .getModel(
                                                            currentUserUid,
                                                            listView2Index,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child:
                                                              ListingLargeWidget(
                                                            key: Key(
                                                              'Keyjpz_${currentUserUid}',
                                                            ),
                                                            listingPrice: functions
                                                                .displayValidPrice(
                                                                    listView2Item
                                                                        .price)!,
                                                            listingName:
                                                                listView2Item
                                                                    .title,
                                                            listingImage:
                                                                listView2Item
                                                                    .image,
                                                            listingUnit:
                                                                listView2Item
                                                                    .unitType,
                                                            numUnits:
                                                                listView2Item
                                                                    .units,
                                                            listing:
                                                                listView2Item,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 1.0, 0.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 13.0, 0.0, 0.0),
                                      child: Text(
                                        'Marketplace',
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
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 32.0,
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
                                  Container(
                                    width: 382.0,
                                    height: 62.0,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Builder(
                                          builder: (context) {
                                            if (currentUserDocument?.location ==
                                                null) {
                                              return Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 180.0, 0.0),
                                                child: FlutterFlowIconButton(
                                                  borderColor:
                                                      Colors.transparent,
                                                  borderRadius: 20.0,
                                                  borderWidth: 1.0,
                                                  buttonSize: 55.0,
                                                  icon: Icon(
                                                    Icons.location_off_outlined,
                                                    color: Color(0xFF00ADEA),
                                                    size: 40.0,
                                                  ),
                                                  onPressed: () async {
                                                    var confirmDialogResponse =
                                                        await showDialog<bool>(
                                                              context: context,
                                                              builder:
                                                                  (alertDialogContext) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      'Location Services'),
                                                                  content: Text(
                                                                      'In order to search nearby, this app requires access to your current location.'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          false),
                                                                      child: Text(
                                                                          'Not Now'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () => Navigator.pop(
                                                                          alertDialogContext,
                                                                          true),
                                                                      child: Text(
                                                                          'Confirm'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            ) ??
                                                            false;
                                                    if (confirmDialogResponse) {
                                                      context.pushNamed(
                                                          LocationServicesWidget
                                                              .routeName);
                                                    }
                                                  },
                                                ),
                                              );
                                            } else {
                                              return Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  3.0,
                                                                  0.0),
                                                      child:
                                                          FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 20.0,
                                                        borderWidth: 2.0,
                                                        buttonSize: 55.0,
                                                        icon: Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondary,
                                                          size: 40.0,
                                                        ),
                                                        onPressed: () async {
                                                          var confirmDialogResponse =
                                                              await showDialog<
                                                                      bool>(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (alertDialogContext) {
                                                                      return AlertDialog(
                                                                        title: Text(
                                                                            'Update Location Services'),
                                                                        content:
                                                                            Text('Would you like to update your current location?'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, false),
                                                                            child:
                                                                                Text('Not Now'),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed: () =>
                                                                                Navigator.pop(alertDialogContext, true),
                                                                            child:
                                                                                Text('Confirm'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ) ??
                                                                  false;
                                                          if (confirmDialogResponse) {
                                                            context.pushNamed(
                                                                LocationServicesWidget
                                                                    .routeName);
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 0.0),
                                                    child: Container(
                                                      width: 180.0,
                                                      height: 35.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1.0,
                                                                      0.0),
                                                              child:
                                                                  AuthUserStreamWidget(
                                                                builder:
                                                                    (context) =>
                                                                        Text(
                                                                  valueOrDefault(
                                                                      currentUserDocument
                                                                          ?.city,
                                                                      ''),
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
                                                                        fontSize:
                                                                            25.0,
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
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 7.0, 0.0),
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                  LogInPageWidget.routeName);
                                            },
                                            text: 'Sell',
                                            options: FFButtonOptions(
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .fontStyle,
                                                        ),
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 25.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35.0,
                                          child: VerticalDivider(
                                            thickness: 2.0,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: Colors.transparent,
                                            borderRadius: 20.0,
                                            borderWidth: 2.0,
                                            buttonSize: 55.0,
                                            icon: Icon(
                                              Icons.search,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                              size: 40.0,
                                            ),
                                            onPressed: () async {
                                              context.pushNamed(
                                                  SearchListingsWidget
                                                      .routeName);
                                            },
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
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
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
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                    unselectedLabelStyle: TextStyle(),
                                    labelColor: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    unselectedLabelColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    unselectedBackgroundColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    unselectedBorderColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderWidth: 2.0,
                                    borderRadius: 8.0,
                                    elevation: 3.0,
                                    buttonMargin:
                                        EdgeInsetsDirectional.fromSTEB(
                                            8.0, 0.0, 8.0, 0.0),
                                    padding: EdgeInsets.all(4.0),
                                    tabs: [
                                      Tab(
                                        text: 'Community',
                                      ),
                                    ],
                                    controller: _model.tabBarController2,
                                    onTap: (i) async {
                                      [() async {}][i]();
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: _model.tabBarController2,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (currentUserDocument?.location !=
                                              null) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      5.0, 10.0, 5.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final gridView = functions
                                                          .getProductsDistance(
                                                              _model.tempNotMine
                                                                  ?.toList(),
                                                              1000.0,
                                                              currentUserDocument
                                                                  ?.location)
                                                          ?.toList() ??
                                                      [];
                                                  if (gridView.isEmpty) {
                                                    return EmptyListMessageWidget(
                                                      message1:
                                                          'No Listings For Sale Near Your Current Location',
                                                      message2:
                                                          'Please check for more listings at a later time!',
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
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: gridView.length,
                                                    itemBuilder: (context,
                                                        gridViewIndex) {
                                                      final gridViewItem =
                                                          gridView[
                                                              gridViewIndex];
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          context.pushNamed(
                                                            ListingDetailsWidget
                                                                .routeName,
                                                            queryParameters: {
                                                              'listingtoPost':
                                                                  serializeParam(
                                                                gridViewItem
                                                                    .reference,
                                                                ParamType
                                                                    .DocumentReference,
                                                              ),
                                                            }.withoutNulls,
                                                          );
                                                        },
                                                        child: wrapWithModel(
                                                          model: _model
                                                              .listingModels5
                                                              .getModel(
                                                            currentUserUid,
                                                            gridViewIndex,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: ListingWidget(
                                                            key: Key(
                                                              'Key9sf_${currentUserUid}',
                                                            ),
                                                            listingPrice:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .displayValidPrice(
                                                                      gridViewItem
                                                                          .price),
                                                              '0.00',
                                                            ),
                                                            listingName:
                                                                valueOrDefault<
                                                                    String>(
                                                              gridViewItem
                                                                  .title,
                                                              'New Listing',
                                                            ),
                                                            listingImage:
                                                                valueOrDefault<
                                                                    String>(
                                                              gridViewItem
                                                                  .image,
                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/plantculture-mltpm2/assets/krb97ghfkdfv/applogostransparent2-24.png',
                                                            ),
                                                            listingUnit:
                                                                valueOrDefault<
                                                                    String>(
                                                              gridViewItem
                                                                  .unitType,
                                                              'pound',
                                                            ),
                                                            numUnits:
                                                                valueOrDefault<
                                                                    int>(
                                                              gridViewItem
                                                                  .units,
                                                              0,
                                                            ),
                                                            listing:
                                                                gridViewItem,
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      5.0, 10.0, 5.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final grid5 = _model
                                                          .tempNotMine
                                                          ?.toList() ??
                                                      [];
                                                  if (grid5.isEmpty) {
                                                    return Center(
                                                      child:
                                                          EmptyListMessageWidget(
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
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount: grid5.length,
                                                    itemBuilder:
                                                        (context, grid5Index) {
                                                      final grid5Item =
                                                          grid5[grid5Index];
                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (grid5Item
                                                                  .seller ==
                                                              currentUserReference) {
                                                            context.pushNamed(
                                                              MyListingWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'listingtoPost':
                                                                    serializeParam(
                                                                  grid5Item
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
                                                                  grid5Item
                                                                      .reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          }
                                                        },
                                                        child: wrapWithModel(
                                                          model: _model
                                                              .listingModels6
                                                              .getModel(
                                                            currentUserUid,
                                                            grid5Index,
                                                          ),
                                                          updateCallback: () =>
                                                              safeSetState(
                                                                  () {}),
                                                          child: ListingWidget(
                                                            key: Key(
                                                              'Keyr3m_${currentUserUid}',
                                                            ),
                                                            listingPrice: functions
                                                                .displayValidPrice(
                                                                    grid5Item
                                                                        .price)!,
                                                            listingName:
                                                                grid5Item.title,
                                                            listingImage:
                                                                grid5Item.image,
                                                            listingUnit:
                                                                grid5Item
                                                                    .unitType,
                                                            numUnits:
                                                                grid5Item.units,
                                                            listing: grid5Item,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
