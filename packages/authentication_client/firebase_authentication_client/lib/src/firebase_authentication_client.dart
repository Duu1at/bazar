import 'package:authentication_client/authentication_client.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:token_storage/token_storage.dart';

/// Signature for [SignInWithApple.getAppleIDCredential].
typedef GetAppleCredentials = Future<AuthorizationCredentialAppleID> Function({
  required List<AppleIDAuthorizationScopes> scopes,
  WebAuthenticationOptions webAuthenticationOptions,
  String nonce,
  String state,
});

/// {@template firebase_authentication_client}
/// A Firebase implementation of the [AuthenticationClient] interface.
/// {@endtemplate}
class FirebaseAuthenticationClient implements AuthenticationClient {
  /// {@macro firebase_authentication_client}
  FirebaseAuthenticationClient({
    required TokenStorage tokenStorage,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    GetAppleCredentials? getAppleCredentials,
  })  : _tokenStorage = tokenStorage,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _getAppleCredentials =
            getAppleCredentials ?? SignInWithApple.getAppleIDCredential
       
             {
    user.listen(_onUserChanged);
  }

  final TokenStorage _tokenStorage;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final GetAppleCredentials _getAppleCredentials;

  /// Stream of [AuthenticationUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthenticationUser.anonymous] if the user is not authenticated.
  @override
  Stream<AuthenticationUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthenticationUser.anonymous
          : firebaseUser.toUser;
    });
  }

  /// Starts the Sign In with Apple Flow.
  ///
  /// Throws a [LogInWithAppleFailure] if an exception occurs.
  @override
  Future<void> logInWithApple() async {
    try {
      final appleIdCredential = await _getAppleCredentials(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oAuthProvider = firebase_auth.OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithAppleFailure(error), stackTrace);
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  @override
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw LogInWithGoogleCanceled(
          Exception('Sign in with Google canceled'),
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
    }
  }

  /// Sends an authentication link to the provided [email].
  ///
  /// Opening the link redirects to the app with [appPackageName]
  /// using Firebase Dynamic Links and authenticates the user
  /// based on the provided email link.
  ///
  /// Throws a [SendLoginEmailLinkFailure] if an exception occurs.
  @override
  Future<void> sendLoginEmailLink({
    required String email,
    required String appPackageName,
  }) async {
    try {
      final redirectUrl = Uri.https(
        const String.fromEnvironment('FLAVOR_DEEP_LINK_DOMAIN'),
        const String.fromEnvironment('FLAVOR_DEEP_LINK_PATH'),
        <String, String>{'email': email},
      );

      final actionCodeSettings = firebase_auth.ActionCodeSettings(
        url: redirectUrl.toString(),
        handleCodeInApp: true,
        iOSBundleId: appPackageName,
        androidPackageName: appPackageName,
        androidInstallApp: true,
      );

      await _firebaseAuth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: actionCodeSettings,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SendLoginEmailLinkFailure(error), stackTrace);
    }
  }

  /// Checks if an incoming [emailLink] is a sign-in with email link.
  ///
  /// Throws a [IsLogInWithEmailLinkFailure] if an exception occurs.
  @override
  bool isLogInWithEmailLink({required String emailLink}) {
    try {
      return _firebaseAuth.isSignInWithEmailLink(emailLink);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(IsLogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  /// Signs in with the provided [emailLink].
  ///
  /// Throws a [LogInWithEmailLinkFailure] if an exception occurs.
  @override
  Future<void> logInWithEmailLink({
    required String email,
    required String emailLink,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithEmailLinkFailure(error), stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [AuthenticationUser.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  /// Deletes and signs out the user.
  @override
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw DeleteAccountFailure(
          Exception('User is not authenticated'),
        );
      }

      await user.delete();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(DeleteAccountFailure(error), stackTrace);
    }
  }

  /// Updates the user token in [TokenStorage] if the user is authenticated.
  Future<void> _onUserChanged(AuthenticationUser user) async {
    if (!user.isAnonymous) {
      await _tokenStorage.saveToken(user.id);
    } else {
      await _tokenStorage.clearToken();
    }
  }
}

extension on firebase_auth.User {
  AuthenticationUser get toUser {
    return AuthenticationUser(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isNewUser: metadata.creationTime == metadata.lastSignInTime,
    );
  }
}
