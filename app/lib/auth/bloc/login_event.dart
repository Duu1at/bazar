part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

final class AppUserSubscriptionRequested extends LoginEvent {
  const AppUserSubscriptionRequested();
}

final class AppLogoutPressed extends LoginEvent {
  const AppLogoutPressed();
}
