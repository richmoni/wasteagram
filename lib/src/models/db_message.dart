import 'package:intl/intl.dart';

/// Represents a food waste post in the Firestore database.
class DbMessage {
  /// The submission datetime.
  final DateTime date;

  /// The URL of the submitted image.
  final String imageURL;

  /// The number of discarded items.
  final int quantity;

  /// The latitude from which the post was submitted.
  final double latitude;

  /// The longitude from which the post was submitted.
  final double longitude;

  const DbMessage(
      {required this.date,
      required this.imageURL,
      required this.quantity,
      required this.latitude,
      required this.longitude});

  /// The formatted submission datetime.
  String get formattedDate => DateFormat('EEEE, MMMM d, yyyy').format(date);

  /// The formatted submission datetime, with abbreviated day of the week and month.
  String get abbreviatedDate => DateFormat('E, MMM d, yyyy').format(date);

  /// The [latitude], truncated to six digits of precision.
  String get formattedLatitude => latitude.toStringAsFixed(6);

  /// The [longitude], truncated to six digits of precision.
  String get formattedLongitude => longitude.toStringAsFixed(6);
}
