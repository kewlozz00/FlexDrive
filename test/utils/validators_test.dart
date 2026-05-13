import 'package:flex_drive/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('search validator allows empty value', () {
    expect(validateSearchQuery(''), isNull);
  });

  test('search validator rejects one character', () {
    expect(validateSearchQuery('a'), 'Enter at least 2 characters');
  });

  test('search validator allows two characters and more', () {
    expect(validateSearchQuery('bm'), isNull);
    expect(validateSearchQuery('Tesla'), isNull);
  });
}
