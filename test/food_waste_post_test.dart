import 'package:test/test.dart';
import 'package:wasteagram/src/models/food_waste_post.dart';

/// Test food waste post model functionality.
void main() {
  /// Ensure that constructor initializes model properties correctly.
  test('Post created from Map should have appropriate property values', () {
    final DateTime date = DateTime.parse('2021-01-01');
    const String url = 'FAKE';
    const int quantity = 1;
    const double latitude = 1.0;
    const double longitude = 2.0;

    final FoodWastePost foodWastePost = FoodWastePost(
        date: date,
        imageURL: url,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude);

    expect(foodWastePost.date, date);
    expect(foodWastePost.imageURL, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });

  /// Ensure that formattedDate getter correctly formats submission datetime.
  test('formattedDate getter should return a formatted submission date', () {
    final DateTime date = DateTime.parse('2021-01-01');

    final FoodWastePost foodWastePost = FoodWastePost(
        date: date, imageURL: '', quantity: 0, latitude: 0, longitude: 0);

    expect(foodWastePost.formattedDate, 'Friday, January 1, 2021');
  });

  /// Ensure that abbreviatedDate getter correctly formats submission datetime.
  test('abbreviatedDate getter should return an abbreviated submission date',
      () {
    final DateTime date = DateTime.parse('2021-01-01');

    final FoodWastePost foodWastePost = FoodWastePost(
        date: date, imageURL: '', quantity: 0, latitude: 0, longitude: 0);

    expect(foodWastePost.abbreviatedDate, 'Fri, Jan 1, 2021');
  });

  /// Ensure that formattedLatitude and formattedLongitude getters correctly format submission location.
  test(
      'formattedLatitude and formattedLongitude getters should truncate precision to 6 decimal digits at most',
      () {
    const double latitude = 1.123456789;
    const double longitude = 2.987654321;

    final FoodWastePost foodWastePost = FoodWastePost(
        date: DateTime.now(),
        imageURL: '',
        quantity: 0,
        latitude: latitude,
        longitude: longitude);

    expect(foodWastePost.formattedLatitude, '1.123457');
    expect(foodWastePost.formattedLongitude, '2.987654');
  });
}
