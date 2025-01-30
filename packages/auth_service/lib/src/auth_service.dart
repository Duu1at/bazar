import 'package:auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:mb_storage/mb_storage.dart';

class AuthService {
  AuthService(
    MbStorage cache,
    firebase_auth.FirebaseAuth auth,
  )   : _cache = cache,
        _auth = auth;

  final MbStorage _cache;
  final firebase_auth.FirebaseAuth _auth;
  String? _verificationId;

  static const String userKey = 'user';
  static const String _isLoggedIn = 'isLoggedIn';

  Stream<User> get user {
    return _auth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
        _cache.saveUser(key: userKey, value: user);
        return user;
      },
    );
  }

  Future<User> get currentUser async {
    return _cache.getUser;
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _cache.cacheUser(key: userKey, value: true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _cache.cacheUser(key: userKey, value: true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> loginWithPhone(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (firebase_auth.PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          await _cache.cacheUser(key: userKey, value: true);
        },
        verificationFailed: (firebase_auth.FirebaseAuthException e) {
          throw LoginWithPhoneException.fromCode(e.code);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      throw LoginWithPhoneException();
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      await _cache.cacheUser(key: _isLoggedIn, value: true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpVerifyOtpException.fromCode(e.code);
    } catch (e) {
      throw const SignUpVerifyOtpException();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _cache.deleteUser(key: _isLoggedIn, value: false);
  }

  Future<bool> isUserCached() async {
    return _cache.isUserCached(key: _isLoggedIn);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
