import 'package:test/test.dart';

import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test('Post created from Map should have appropriate property values', () {
    final date = DateTime.parse('2021-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = FoodWastePost(
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

  test('formattedDate getter should return a formatted submission date', () {
    final date = DateTime.parse('2021-01-01');

    final foodWastePost = FoodWastePost(
        date: date, imageURL: '', quantity: 0, latitude: 0, longitude: 0);

    expect(foodWastePost.formattedDate, 'Friday, January 1, 2021');
  });

  test('abbreviatedDate getter should return an abbreviated submission date',
      () {
    final date = DateTime.parse('2021-01-01');

    final foodWastePost = FoodWastePost(
        date: date, imageURL: '', quantity: 0, latitude: 0, longitude: 0);

    expect(foodWastePost.abbreviatedDate, 'Fri, Jan 1, 2021');
  });

  test(
      'formattedLatitude and formattedLongitude getters should return 6 decimal digits at most',
      () {
    const latitude = 1.123456789;
    const longitude = 2.987654321;

    final foodWastePost = FoodWastePost(
        date: DateTime.now(),
        imageURL: '',
        quantity: 0,
        latitude: latitude,
        longitude: longitude);

    expect(foodWastePost.formattedLatitude, '1.123457');
    expect(foodWastePost.formattedLongitude, '2.987654');
  });
}
