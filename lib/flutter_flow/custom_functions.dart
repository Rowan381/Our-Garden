import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

double? getLong(LatLng? latlong) {
  return latlong?.longitude;
}

bool compareDates(
  DateTime firstDate,
  DateTime secondDate,
) {
  return firstDate.day == secondDate.day &&
      firstDate.month == secondDate.month &&
      firstDate.year == secondDate.year;
}

List<ProductRecord>? getProductsDistance(
  List<ProductRecord>? products,
  double? radius,
  LatLng? location,
) {
  List<ProductRecord> result = [];

  if (products == null || radius == null || location == null) {
    return result;
  }

  for (ProductRecord p in products) {
    if (p.location != null &&
        p.locationCity != "None" &&
        getDistanceBetweenLocations(p.location!, location)! <= radius) {
      result.add(p);
    }
  }
  return result;
}

String? guestName(
  List<String> participantsNames,
  String? authUserName,
) {
  // Ensure authUserName is not null and participantsNames is not empty
  if (authUserName != null && participantsNames.isNotEmpty) {
    // Find the first participant name that is not authUserName
    String? otherName;
    for (var name in participantsNames) {
      if (name != authUserName) {
        otherName = name;
        break;
      }
    }

    // Return the otherName if found, otherwise return the first participant's name
    return otherName ?? participantsNames.first;
  }

  // Return a default name or handle the case where participantsNames is empty
  return 'Guest'; // Default value or appropriate handling when participantsNames is empty
}

double? getDistanceBetweenLocations(
  LatLng currentLocation,
  LatLng targetLocation,
) {
  final double earthRadius = 3958.8; // in miles
  final double lat1 = math.pi / 180.0 * currentLocation.latitude;
  final double lon1 = math.pi / 180.0 * currentLocation.longitude;
  final double lat2 = math.pi / 180.0 * targetLocation.latitude;
  final double lon2 = math.pi / 180.0 * targetLocation.longitude;
  final double dLat = lat2 - lat1;
  final double dLon = lon2 - lon1;
  final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
  final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  final double distance = earthRadius * c;
  return double.parse(distance.toStringAsFixed(1));
}

String? displayValidPrice(double price) {
  //ensures all prices only display 2 decimals (adds/deletes digits as needed)
  return price.toStringAsFixed(2);
}

double? getLat(LatLng? latlong) {
  return latlong?.latitude;
}

bool checkIfTwelveHoursPassed(
  DateTime prevUpdatedTime,
  DateTime currTime,
) {
  final difference = currTime.difference(prevUpdatedTime);
  return difference.inHours >= 12;
}

double formatPriceAsDouble(String? number) {
  if (number == null) {
    return 0.00;
  } else if (!number.contains('.')) {
    number += '.00';
  } else if (number.substring(0, number.length - 1) == '.') {
    number += '00';
  }

  // if the last number of the decimal is a 0, it will truncate it out
  // turns 5.00 --> 5.0 and 5 --> 5.0 because of the inherent properties in Dart's double.parse
  double number2 = double.parse(number);
  double simplifiedNumber = double.parse(number2.toStringAsFixed(2));
  return simplifiedNumber;
}

DocumentReference findPlantUsingID(String plantID) {
  // using plantID, find the doc reference of "plants" collection that has a matching plantID variable
  return FirebaseFirestore.instance.collection('plants').doc(plantID);
}

String? singularUnitType(String? unitType) {
  String lowerCaseUnitType = unitType!.toLowerCase();

  if (lowerCaseUnitType.endsWith('s')) {
    return lowerCaseUnitType.substring(0, unitType.length - 1);
  }
  return lowerCaseUnitType;
}

bool isNearBy(
  LatLng? location1,
  LatLng? location2,
  double? radius,
) {
  if (location1 == null || location2 == null || radius == null) {
    return false;
  }

  final double earthRadius = 3958.8; // in miles
  final double lat1 = math.pi / 180.0 * location1.latitude;
  final double lon1 = math.pi / 180.0 * location1.longitude;
  final double lat2 = math.pi / 180.0 * location2.latitude;
  final double lon2 = math.pi / 180.0 * location2.longitude;
  final double dLat = lat2 - lat1;
  final double dLon = lon2 - lon1;
  final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
  final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  final double distance = earthRadius * c;
  double d = double.parse(distance.toStringAsFixed(1));

  return d <= radius;
}

bool? easyTextSearch(
  String sfor,
  String sin,
) {
  return sin.toLowerCase().contains(sfor.toLowerCase());
}

String? guestImage(
  List<String> participantsImages,
  String? authUserImages,
) {
  // Ensure authUserImages is not null and participantsImages is not empty
  if (authUserImages != null && participantsImages.isNotEmpty) {
    // Find the first participant image that is not authUserImages
    String? otherImages;
    for (var image in participantsImages) {
      if (image != authUserImages) {
        otherImages = image;
        break;
      }
    }

    // Return the otherImages if found, otherwise return the first participant's image
    return otherImages ?? participantsImages.first;
  }

  // Return a default image or handle the case where participantsImages is empty
  return null; // Default value or appropriate handling when participantsImages is empty
}

bool? filterListing(
  List<String>? userFilters,
  List<String>? productFilters,
) {
  if (userFilters == null || productFilters == null) return null;

  if (userFilters.isEmpty) return true;

  return userFilters.every((filter) => productFilters.contains(filter));
}

bool checkToday(
  DateTime startDate,
  int frequencyNum,
  String frequencyType,
) {
  final today = DateTime.now();
  Duration frequencyDuration;

  if (startDate.day == today.day &&
      startDate.month == today.month &&
      startDate.year == today.year) {
    return true;
  } else {
    if (frequencyType == 'Days') {
      frequencyDuration = Duration(days: frequencyNum);
    } else if (frequencyType == 'Weeks') {
      frequencyDuration = Duration(days: frequencyNum * 7);
    } else {
      frequencyDuration = Duration(days: frequencyNum * 30);
    }

    DateTime nextDueDate = startDate;
    while (nextDueDate.isBefore(today)) {
      nextDueDate = nextDueDate.add(frequencyDuration);
      // Break the loop if the nextDueDate matches today
      if (nextDueDate.day == today.day &&
          nextDueDate.month == today.month &&
          nextDueDate.year == today.year) {
        return true;
      }
    }

    return false;
  }
}

double? pricetimesQuant(
  double? price,
  double? quantity,
) {
  return price! * quantity!;
}
