import 'package:flutter_test/flutter_test.dart';
import 'package:new_bytebank/models/Contact.dart';
import 'package:new_bytebank/models/transaction.dart';

final contact = Contact(null, '', null);

void main() {
  test('Should return the value when create a transaction', () {
    final transaction = Transaction('', 200, contact);
    expect(transaction.value, 200);
  });
  test('Should show error when create a transaction with value less than zero',
      () {
    expect(() => Transaction('', 0, contact), throwsAssertionError);
  });
}
