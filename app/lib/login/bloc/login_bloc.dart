import 'dart:async';

import 'package:analytics_repository/analytics_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<SendEmailLinkSubmitted>(_onSendEmailLinkSubmitted);
    on<LoginGoogleSubmitted>(_onGoogleSubmitted);
    on<LoginAppleSubmitted>(_onAppleSubmitted);
  }

  final UserRepository _userRepository;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        valid: Formz.validate([email]),
      ),
    );
  }

  Future<void> _onSendEmailLinkSubmitted(
    SendEmailLinkSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.valid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _userRepository.sendLoginEmailLink(
        email: state.email.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }

  Future<void> _onGoogleSubmitted(
    LoginGoogleSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _userRepository.logInWithGoogle();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleCanceled {
      emit(state.copyWith(status: FormzSubmissionStatus.canceled));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }

  Future<void> _onAppleSubmitted(
    LoginAppleSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _userRepository.logInWithApple();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      addError(error, stackTrace);
    }
  }
}
