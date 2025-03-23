import 'dart:async';
import 'package:authentication_client/authentication_client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required UserRepository userRepository, required UserModel user})
    : _userRepository = userRepository,
      super(user == UserModel.anonymous ? const AppState.unauthenticated() : AppState.authenticated(user)) {
    on<AppUserChanged>(_onUserChanged);
    on<AppOnboardingCompleted>(_onOnboardingCompleted);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppDeleteAccountRequested>(_onDeleteAccountRequested);
    on<AppOpened>(_onAppOpened);
  }

  final UserRepository _userRepository;
  late StreamSubscription<UserModel> _user;

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    final user = event.user;

    switch (state.status) {
      case AppStatus.onboardingRequired:
      case AppStatus.authenticated:
      case AppStatus.unauthenticated:
        return user != UserModel.anonymous
            ? emit(AppState.onboardingRequired(user))
            : user == UserModel.anonymous
            ? emit(const AppState.unauthenticated())
            : emit(AppState.authenticated(user));
    }
  }

  void _onOnboardingCompleted(AppOnboardingCompleted event, Emitter<AppState> emit) {
    if (state.status == AppStatus.onboardingRequired) {
      return state.user == UserModel.anonymous
          ? emit(const AppState.unauthenticated())
          : emit(AppState.authenticated(state.user));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_userRepository.signOut());
  }

  Future<void> _onDeleteAccountRequested(AppDeleteAccountRequested event, Emitter<AppState> emit) async {
    try {
      await _userRepository.deleteAccount();
    } catch (error, stackTrace) {
      await _userRepository.signOut();
      addError(error, stackTrace);
    }
  }

  Future<void> _onAppOpened(AppOpened event, Emitter<AppState> emit) async {
    // if (state.user.isAnonymous) {
    //   final appOpenedCount = await _userRepository.fetchAppOpenedCount();

    //   if (appOpenedCount == _appOpenedCountForLoginOverlay - 1) {
    //     emit(state.copyWith(showLoginOverlay: true));
    //   }

    //   if (appOpenedCount < _appOpenedCountForLoginOverlay + 1) {
    //     await _userRepository.incrementAppOpenedCount();
    //   }
    // }
  }

  @override
  Future<void> close() {
    _user.cancel();
    return super.close();
  }
}
