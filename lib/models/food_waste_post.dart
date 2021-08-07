import 'package:intl/intl.dart';

class FoodWastePost {
  final DateTime date;
  final String imageURL;
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost(
      {required this.date,
      required this.imageURL,
      required this.quantity,
      required this.latitude,
      required this.longitude});

  String get formattedDate => DateFormat('EEEE, MMMM d, yyyy').format(date);

  String get abbreviatedDate => DateFormat('E, MMM d, yyyy').format(date);

  String get formattedLatitude => latitude.toStringAsFixed(6);

  String get formattedLongitude => longitude.toStringAsFixed(6);
}
