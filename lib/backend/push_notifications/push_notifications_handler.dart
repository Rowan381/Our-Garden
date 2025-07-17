import 'dart:async';

import 'serialization_util.dart';
import '/backend/backend.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


final _handledMessageIds = <String?>{};

class PushNotificationsHandler extends StatefulWidget {
  const PushNotificationsHandler({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  bool _loading = false;

  Future handleOpenedPushNotification() async {
    if (isWeb) {
      return;
    }

    final notification = await FirebaseMessaging.instance.getInitialMessage();
    if (notification != null) {
      await _handlePushNotification(notification);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(_handlePushNotification);
  }

  Future _handlePushNotification(RemoteMessage message) async {
    if (_handledMessageIds.contains(message.messageId)) {
      return;
    }
    _handledMessageIds.add(message.messageId);

    safeSetState(() => _loading = true);
    try {
      final initialPageName = message.data['initialPageName'] as String;
      final initialParameterData = getInitialParameterData(message.data);
      final parametersBuilder = parametersBuilderMap[initialPageName];
      if (parametersBuilder != null) {
        final parameterData = await parametersBuilder(initialParameterData);
        if (mounted) {
          context.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        } else {
          appNavigatorKey.currentContext?.pushNamed(
            initialPageName,
            pathParameters: parameterData.pathParameters,
            extra: parameterData.extra,
          );
        }
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      safeSetState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      handleOpenedPushNotification();
    });
  }

  @override
  Widget build(BuildContext context) => _loading
      ? Container(
          color: Color(0x00FFFFFF),
          child: Image.asset(
            'assets/images/applogostransparent2-24.svg',
            fit: BoxFit.contain,
          ),
        )
      : widget.child;
}

class ParameterData {
  const ParameterData(
      {this.requiredParams = const {}, this.allParams = const {}});
  final Map<String, String?> requiredParams;
  final Map<String, dynamic> allParams;

  Map<String, String> get pathParameters => Map.fromEntries(
        requiredParams.entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
  Map<String, dynamic> get extra => Map.fromEntries(
        allParams.entries.where((e) => e.value != null),
      );

  static Future<ParameterData> Function(Map<String, dynamic>) none() =>
      (data) async => ParameterData();
}

final parametersBuilderMap =
    <String, Future<ParameterData> Function(Map<String, dynamic>)>{
  'reviewsPage': (data) async => ParameterData(
        allParams: {
          'sellerReference':
              getParameter<DocumentReference>(data, 'sellerReference'),
        },
      ),
  'BasketPage': (data) async => ParameterData(
        allParams: {
          'ordersTab': getParameter<bool>(data, 'ordersTab'),
        },
      ),
  'landingPage': ParameterData.none(),
  'Terms_Services': ParameterData.none(),
  'editGarden': (data) async => ParameterData(
        allParams: {
          'gardenDocParam': await getDocumentParameter<GardensRecord>(
              data, 'gardenDocParam', GardensRecord.fromSnapshot),
        },
      ),
  'addGardenTask': ParameterData.none(),
  'locationServices': ParameterData.none(),
  'user_profile': ParameterData.none(),
  'addNewSpecies': ParameterData.none(),
  'forgotPass': ParameterData.none(),
  'EditListingDetails': (data) async => ParameterData(
        allParams: {
          'currListing': getParameter<DocumentReference>(data, 'currListing'),
          'oldImageURL': getParameter<String>(data, 'oldImageURL'),
        },
      ),
  'editPlant': (data) async => ParameterData(
        allParams: {
          'plantDoc': await getDocumentParameter<PlantsRecord>(
              data, 'plantDoc', PlantsRecord.fromSnapshot),
        },
      ),
  'feedback_page': (data) async => ParameterData(
        allParams: {
          'seller': getParameter<DocumentReference>(data, 'seller'),
        },
      ),
  'editPlantTask': (data) async => ParameterData(
        allParams: {
          'plantTask': await getDocumentParameter<PlantTasksRecord>(
              data, 'plantTask', PlantTasksRecord.fromSnapshot),
        },
      ),
  'Tabs': (data) async => ParameterData(
        allParams: {
          'parameterIndex': getParameter<int>(data, 'parameterIndex'),
          'onTour': getParameter<bool>(data, 'onTour'),
        },
      ),
  'ListingDetails': (data) async => ParameterData(
        allParams: {
          'listingtoPost':
              getParameter<DocumentReference>(data, 'listingtoPost'),
        },
      ),
  'chat_2_Details_Listing': (data) async => ParameterData(
        allParams: {
          'chatRef': await getDocumentParameter<ChatsRecord>(
              data, 'chatRef', ChatsRecord.fromSnapshot),
        },
      ),
  'plantInfo': (data) async => ParameterData(
        allParams: {
          'plantDoc': await getDocumentParameter<PlantsRecord>(
              data, 'plantDoc', PlantsRecord.fromSnapshot),
        },
      ),
  'FeedbackForm': ParameterData.none(),
  'addCustomPlant': (data) async => ParameterData(
        allParams: {
          'gardenDest': await getDocumentParameter<GardensRecord>(
              data, 'gardenDest', GardensRecord.fromSnapshot),
        },
      ),
  'logInPage': ParameterData.none(),
  'chat_2_InviteUsers': (data) async => ParameterData(
        allParams: {
          'chatRef': await getDocumentParameter<ChatsRecord>(
              data, 'chatRef', ChatsRecord.fromSnapshot),
        },
      ),
  'addPlantTask': (data) async => ParameterData(
        allParams: {
          'plantRef': await getDocumentParameter<PlantsRecord>(
              data, 'plantRef', PlantsRecord.fromSnapshot),
        },
      ),
  'chat_2_main_new': ParameterData.none(),
  'addPlantMenu': (data) async => ParameterData(
        allParams: {
          'gardenDestination': await getDocumentParameter<GardensRecord>(
              data, 'gardenDestination', GardensRecord.fromSnapshot),
        },
      ),
  'chat_2_Details': (data) async => ParameterData(
        allParams: {
          'chatRef': await getDocumentParameter<ChatsRecord>(
              data, 'chatRef', ChatsRecord.fromSnapshot),
        },
      ),
  'addGarden': (data) async => ParameterData(
        allParams: {
          'onTour': getParameter<bool>(data, 'onTour'),
        },
      ),
  'image_Details': (data) async => ParameterData(
        allParams: {
          'chatMessage': await getDocumentParameter<ChatMessagesRecord>(
              data, 'chatMessage', ChatMessagesRecord.fromSnapshot),
        },
      ),
  'sellerOrdersPage': (data) async => ParameterData(
        allParams: {
          'justApproved': getParameter<bool>(data, 'justApproved'),
        },
      ),
  'AccountDetails': ParameterData.none(),
  'editGardenTask': (data) async => ParameterData(
        allParams: {
          'gardenTask': await getDocumentParameter<GardenTasksRecord>(
              data, 'gardenTask', GardenTasksRecord.fromSnapshot),
        },
      ),
  'PostListing': ParameterData.none(),
  'HomePage': (data) async => ParameterData(
        allParams: {
          'onTour': getParameter<bool>(data, 'onTour'),
        },
      ),
  'SearchListings': ParameterData.none(),
  'viewGarden': (data) async => ParameterData(
        allParams: {
          'gardenRef': getParameter<DocumentReference>(data, 'gardenRef'),
        },
      ),
  'Edit_Profile_Page': ParameterData.none(),
  'createGardenTask': ParameterData.none(),
  'registerPage': ParameterData.none(),
  'chat_2_Details_Cart': (data) async => ParameterData(
        allParams: {
          'chatDoc': await getDocumentParameter<ChatsRecord>(
              data, 'chatDoc', ChatsRecord.fromSnapshot),
        },
      ),
  'AccountSettings': ParameterData.none(),
  'createGardenPlant': ParameterData.none(),
  'editTaskMenu': (data) async => ParameterData(
        allParams: {
          'gardenRef': getParameter<DocumentReference>(data, 'gardenRef'),
        },
      ),
  'MyArchivedListing': (data) async => ParameterData(
        allParams: {
          'listingtoPost':
              getParameter<DocumentReference>(data, 'listingtoPost'),
        },
      ),
  'addCommonPlant': (data) async => ParameterData(
        allParams: {
          'gardenDest': await getDocumentParameter<GardensRecord>(
              data, 'gardenDest', GardensRecord.fromSnapshot),
        },
      ),
  'addTaskMenu': ParameterData.none(),
  'MyListing': (data) async => ParameterData(
        allParams: {
          'listingtoPost':
              getParameter<DocumentReference>(data, 'listingtoPost'),
        },
      ),
  'Edit_Notif_Settings': ParameterData.none(),
  'reciept_page': ParameterData.none(),
  'SearchListingsCopy': ParameterData.none(),
  'ArchivedListings': ParameterData.none(),
  'MarketplaceExploreListings': (data) async => ParameterData(
        allParams: {
          'onTour': getParameter<bool>(data, 'onTour'),
        },
      ),
  'GPT': (data) async => ParameterData(
        allParams: {
          'onTour': getParameter<bool>(data, 'onTour'),
        },
      ),
};

Map<String, dynamic> getInitialParameterData(Map<String, dynamic> data) {
  try {
    final parameterDataStr = data['parameterData'];
    if (parameterDataStr == null ||
        parameterDataStr is! String ||
        parameterDataStr.isEmpty) {
      return {};
    }
    return jsonDecode(parameterDataStr) as Map<String, dynamic>;
  } catch (e) {
    print('Error parsing parameter data: $e');
    return {};
  }
}
