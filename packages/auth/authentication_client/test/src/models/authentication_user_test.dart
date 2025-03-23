// ignore_for_file: prefer_const_constructors

import 'package:authentication_client/authentication_client.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('supports value equality', () {
      final userA = UserModel(id: 'A');
      final secondUserA = UserModel(id: 'A');
      final userB = UserModel(id: 'B');

      expect(userA, equals(secondUserA));
      expect(userA, isNot(equals(userB)));
    });

    test('isAnonymous returns true for anonymous user', () {
      expect(UserModel.anonymous.isAnonymous, isTrue);
    });
  });
}
