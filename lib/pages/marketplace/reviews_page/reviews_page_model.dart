import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reviews_page_widget.dart' show ReviewsPageWidget;
import 'package:flutter/material.dart';
import 'dart:async';

class ReviewsPageModel extends FlutterFlowModel<ReviewsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for reviews
  Query? reviewsQuery;
  List<StreamSubscription?> reviewsStreamSubscriptions = [];
  Stream<List<ReviewsRecord>>? _reviewsStream;
  StreamController<List<ReviewsRecord>>? _reviewsController;

  // Getter for the reviews stream that handles errors gracefully
  Stream<List<ReviewsRecord>> get reviewsStream {
    if (_reviewsStream == null) {
      _initReviewsStream();
    }
    return _reviewsStream!;
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    // Cancel all stream subscriptions
    reviewsStreamSubscriptions.forEach((s) => s?.cancel());
    // Close the controller if it exists
    _reviewsController?.close();
  }

  /// Set up the reviews query
  Query setupReviewsQuery(DocumentReference sellerReference) {
    // If query changes, update the stream
    final oldQuery = reviewsQuery;
    reviewsQuery = ReviewsRecord.collection
        .where('userRef', isEqualTo: sellerReference)
        .orderBy('timestamp', descending: true)
        .limit(50);

    // If the query has changed, reinitialize the stream
    if (oldQuery != reviewsQuery) {
      _initReviewsStream();
    }

    return reviewsQuery!;
  }

  /// Initialize the reviews stream with error handling
  void _initReviewsStream() {
    // Cancel any existing subscriptions
    reviewsStreamSubscriptions.forEach((s) => s?.cancel());
    reviewsStreamSubscriptions.clear();

    // Close any existing controller
    _reviewsController?.close();

    // Create a new controller for the stream
    _reviewsController = StreamController<List<ReviewsRecord>>.broadcast();
    _reviewsStream = _reviewsController!.stream;

    // If there's no query, emit an empty list and return
    if (reviewsQuery == null) {
      _reviewsController!.add([]);
      return;
    }

    // Subscribe to the query stream and forward events to our controller
    final subscription = fetchReviews().listen(
      (data) => _reviewsController!.add(data),
      onError: (error) {
        // Handle errors but keep the stream alive
        print('Error fetching reviews: $error');
        _reviewsController!.addError(error);
      },
    );

    // Add the subscription to our list for later cleanup
    reviewsStreamSubscriptions.add(subscription);
  }

  /// Fetch reviews as a stream from Firestore
  Stream<List<ReviewsRecord>> fetchReviews() {
    if (reviewsQuery == null) {
      return Stream.value([]);
    }

    try {
      return queryReviewsRecord(
        queryBuilder: (_) => reviewsQuery!,
        limit: 50,
      );
    } catch (e) {
      print('Exception in fetchReviews: $e');
      return Stream.error(e);
    }
  }
}
