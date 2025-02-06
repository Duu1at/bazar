// ignore_for_file: prefer_const_constructors

import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('User', () {
    group('fromAuthenticationUser', () {});

    group('isAnonymous', () {
      test('sets isAnonymous correctly', () {
        const anonymousUser = User.anonymous;
        expect(anonymousUser.isAnonymous, isTrue);
      });
    });
  });
}
