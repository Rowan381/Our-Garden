import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'basket_item_widget.dart' show BasketItemWidget;
import 'package:flutter/material.dart';

class BasketItemModel extends FlutterFlowModel<BasketItemWidget> {
  ///  Local state fields for this component.

  bool allItemQuantsZero = true;

  int index = 0;

  double cartTotal = 0.0;

  int loadIndex = 0;

  List<BasketItemStruct> newBasket = [];
  void addToNewBasket(BasketItemStruct item) => newBasket.add(item);
  void removeFromNewBasket(BasketItemStruct item) => newBasket.remove(item);
  void removeAtIndexFromNewBasket(int index) => newBasket.removeAt(index);
  void insertAtIndexInNewBasket(int index, BasketItemStruct item) =>
      newBasket.insert(index, item);
  void updateNewBasketAtIndex(int index, Function(BasketItemStruct) updateFn) =>
      newBasket[index] = updateFn(newBasket[index]);

  List<DocumentReference> usersList = [];
  void addToUsersList(DocumentReference item) => usersList.add(item);
  void removeFromUsersList(DocumentReference item) => usersList.remove(item);
  void removeAtIndexFromUsersList(int index) => usersList.removeAt(index);
  void insertAtIndexInUsersList(int index, DocumentReference item) =>
      usersList.insert(index, item);
  void updateUsersListAtIndex(
          int index, Function(DocumentReference) updateFn) =>
      usersList[index] = updateFn(usersList[index]);

  List<OrderItemsStruct> orderItems = [];
  void addToOrderItems(OrderItemsStruct item) => orderItems.add(item);
  void removeFromOrderItems(OrderItemsStruct item) => orderItems.remove(item);
  void removeAtIndexFromOrderItems(int index) => orderItems.removeAt(index);
  void insertAtIndexInOrderItems(int index, OrderItemsStruct item) =>
      orderItems.insert(index, item);
  void updateOrderItemsAtIndex(
          int index, Function(OrderItemsStruct) updateFn) =>
      orderItems[index] = updateFn(orderItems[index]);

  int orderIndex = 0;

  List<BasketItemStruct> orderBasketItems = [];
  void addToOrderBasketItems(BasketItemStruct item) =>
      orderBasketItems.add(item);
  void removeFromOrderBasketItems(BasketItemStruct item) =>
      orderBasketItems.remove(item);
  void removeAtIndexFromOrderBasketItems(int index) =>
      orderBasketItems.removeAt(index);
  void insertAtIndexInOrderBasketItems(int index, BasketItemStruct item) =>
      orderBasketItems.insert(index, item);
  void updateOrderBasketItemsAtIndex(
          int index, Function(BasketItemStruct) updateFn) =>
      orderBasketItems[index] = updateFn(orderBasketItems[index]);

  double orderTotalPrice = 0.0;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Read Document] action in basketItem widget.
  ProductRecord? productCheck;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  PendingBasketRecord? orderPBasket;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  ProductRecord? productCheck1;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  OrdersRecord? orderIP;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? orderChat;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  ProductRecord? productToArchive;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ProductRecord? archivedProduct;
  // Stores action output result for [Backend Call - Read Document] action in Button widget.
  ProductRecord? currProduct;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  ChatsRecord? existingChat;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  ChatsRecord? newListingChatThread3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
