import 'package:authentication_client/authentication_client.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:supabase_client/supabase_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:token_storage/token_storage.dart';

class UserRepository implements AuthenticationClient {
  UserRepository({
    required TokenStorage tokenStorage,
    SupabaseClient? client,
    PersistentStorage? persistentStorage,
  })  : _tokenStorage = tokenStorage,
        _client = client ?? SupabaseClientProvider.client,
        _persistentStorage = persistentStorage;

  final TokenStorage _tokenStorage;
  final SupabaseClient _client;
  final PersistentStorage? _persistentStorage;

  /// Stream of [UserModel] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserModel.anonymous] if the user is not authenticated.

  @override
  Stream<UserModel> get user {
    return _client.auth.onAuthStateChange.map((state) {
      final user = state.session?.user;
      if (user == null) return UserModel.anonymous;
      _tokenStorage.saveToken(state.session!.accessToken);
      _persistentStorage?.writeString(key: 'user_id', value: user.id);
      return UserModel.fromSupabase(user.toJson());
    });
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await Future.wait([
        _client.auth.admin.deleteUser(
          _client.auth.currentUser!.id,
        ),
        _client.auth.signOut(),
        _tokenStorage.clearToken(),
      ]);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(DeleteAccountFailure(error), stackTrace);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(
        email,
        redirectTo: 'io.supabase.myflutterapp://reset-callback/',
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ResetPasswordFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignInFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signInWithApple() async {
    try {
      await _client.auth.signInWithOAuth(
        OAuthProvider.apple,
        redirectTo: 'io.supabase.myflutterapp://login-callback/',
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithAppleFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signInWithEmailLink({required String email}) async {
    try {
      await _client.auth.signInWithOtp(
        email: email,
        emailRedirectTo: 'io.supabase.myflutterapp://login-callback/',
      );
    } catch (e) {
      throw LogInWithEmailLinkFailure(e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      await _client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.myflutterapp://login-callback/',
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
      await _tokenStorage.clearToken();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  @override
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignUpFailure(error), stackTrace);
    }
  }

  @override
  Future<void> updateProfile({String? name, String? avatarUrl}) async {
    try {
      await _client.auth.updateUser(
        UserAttributes(
          data: {
            if (name != null) 'name': name,
            if (avatarUrl != null) 'avatar_url': avatarUrl,
          },
        ),
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(UpdateProfileFailure(error), stackTrace);
    }
  }

  @override
  Future<bool> checkUserExists({required String email}) async {
    try {
      final response = await _client.from('profiles').select('email').eq('email', email).maybeSingle();
      return response != null;
    } catch (error, stackTrace) {
      // log(error.toString());
      // log(stackTrace.toString());
      Error.throwWithStackTrace(CheckUserExistsFailure(error), stackTrace);
    }
  }
}
