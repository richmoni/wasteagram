import 'package:test/test.dart';
import 'package:wasteagram/src/models/db_message.dart';

/// Test food waste post model functionality.
void main() {
  /// Ensure that constructor initializes model properties correctly.
  test('Post created from Map should have appropriate property values', () {
    final DateTime date = DateTime.parse('2021-01-31');
    const String imageURL = 'This is a test';
    const int quantity = 3;
    const double latitude = 1.0;
    const double longitude = 2.0;

    final DbMessage msg = DbMessage(
        date: date,
        imageURL: imageURL,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude);

    expect(msg.date, date);
    expect(msg.imageURL, imageURL);
    expect(msg.quantity, quantity);
    expect(msg.latitude, latitude);
    expect(msg.longitude, longitude);
  });

  /// Ensure that formattedDate getter correctly formats submission datetime.
  test('formattedDate getter should return a formatted submission date', () {
    final DateTime date = DateTime.parse('2021-01-31');

    final DbMessage msg =
        DbMessage(date: date, imageURL: '', quantity: 0, latitude: 0.0, longitude: 0.0);

    expect(msg.formattedDate, 'Sunday, January 31, 2021');
  });

  /// Ensure that abbreviatedDate getter correctly formats submission datetime.
  test('abbreviatedDate getter should return an abbreviated submission date', () {
    final DateTime date = DateTime.parse('2021-01-31');

    final DbMessage msg =
        DbMessage(date: date, imageURL: '', quantity: 0, latitude: 0.0, longitude: 0.0);

    expect(msg.abbreviatedDate, 'Sun, Jan 31, 2021');
  });

  /// Ensure that formattedLatitude and formattedLongitude getters correctly format submission location.
  test(
      'formattedLatitude and formattedLongitude getters should truncate precision to 6 decimal digits at most',
      () {
    const double latitude = 1.122333444455555;
    const double longitude = 2.553421138532110;

    final DbMessage msg = DbMessage(
        date: DateTime.now(), imageURL: '', quantity: 0, latitude: latitude, longitude: longitude);

    expect(msg.formattedLatitude, '1.122333');
    expect(msg.formattedLongitude, '2.553421');
  });
}
