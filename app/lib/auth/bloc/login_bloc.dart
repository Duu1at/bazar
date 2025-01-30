import 'package:auth_service/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthService authService})
      : _authService = authService,
        super(LoginState()) {
    on<AppUserSubscriptionRequested>(_onUserSubscriptionRequested);
    on<AppLogoutPressed>(_onLogoutPressed);
    on<AppSingInWithEmail>(_onAppSingInWithEmail);
  }

  final AuthService _authService;

  Future<void> _onUserSubscriptionRequested(
    AppUserSubscriptionRequested event,
    Emitter<LoginState> emit,
  ) {
    return emit.onEach(
      _authService.user,
      onData: (user) => emit(LoginState(user: user)),
      onError: addError,
    );
  }

  Future<void> _onAppSingInWithEmail(
    AppSingInWithEmail event,
    Emitter<LoginState> emit,
  ) {
    return emit.onEach(
      _authService.user,
      onData: (user) => emit(LoginState(user: user)),
      onError: addError,
    );
  }

  void _onLogoutPressed(
    AppLogoutPressed event,
    Emitter<LoginState> emit,
  ) {
    _authService.signOut();
  }
}
