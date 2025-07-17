import '/flutter_flow/flutter_flow_credit_card_form.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'checkout_overlay_widget.dart' show CheckoutOverlayWidget;
import 'package:flutter/material.dart';

class CheckoutOverlayModel extends FlutterFlowModel<CheckoutOverlayWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for CreditCardForm widget.
  final creditCardFormKey = GlobalKey<FormState>();
  CreditCardModel creditCardInfo = emptyCreditCard();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
