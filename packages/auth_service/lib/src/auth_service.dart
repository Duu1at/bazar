import 'package:auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:mb_storage/mb_storage.dart';

/// The service providing access to Firebase Authentication
class AuthService {
  /// The key used to store the user in the cache
  static const String _userKey = 'user';
  static const String _isLoggedIn = 'isLoggedIn';

  /// Creates a new instance of [AuthService]
  AuthService(
    MbStorage cache,
  ) : _cache = cache;

  final MbStorage _cache;

  /// The instance of Firebase Authentication
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  /// The verification ID used to store the PhoneAuthCredential
  String? _verificationId;

  /// Stream of the current user
  Stream<User> get user {
    return _auth.authStateChanges().map(
      (firebaseUser) {
        final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
        _cache.saveUser(key: _userKey, value: user);
        return user;
      },
    );
  }

  /// Signs in with the given [email] and [password]
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _cache.cacheUser(key: _userKey, value: true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs up with the given [email] and [password]
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _cache.cacheUser(key: _userKey, value: true);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the given [phoneNumber]
  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (firebase_auth.PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          await _cache.cacheUser(key: _userKey, value: true);
        },
        verificationFailed: (firebase_auth.FirebaseAuthException e) {
          print("Verification failed: $e");
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Error signing in with phone: $e");
      rethrow;
    }
  }

  /// Verifies the OTP for the given [otp]
  Future<void> verifyOTP(String otp) async {
    try {
      final firebase_auth.PhoneAuthCredential credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      await _cache.cacheUser(key: _isLoggedIn, value: true);
    } catch (e) {
      rethrow;
    }
  }

  /// Checks if the user is cached
  Future<bool> isUserCached() async {
    return _cache.isUserCached(key: _isLoggedIn);
  }

  /// Signs out of the current user
  Future<void> signOut() async {
    await _auth.signOut();
    await _cache.deleteUser(key: _isLoggedIn, value: false);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
