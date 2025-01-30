class LoginWithPhoneException {
  LoginWithPhoneException([
    this.message = 'An unknown exception occurred.',
  ]);

  factory LoginWithPhoneException.fromCode(String code) {
    switch (code) {
      case 'invalid-verification-code':
        return LoginWithPhoneException('invalid-verification-code');
      case 'invalid-verification-id':
        return LoginWithPhoneException('invalid-verification-id');
      case 'user-disabled':
        return LoginWithPhoneException('user-disabled');
      case 'user-not-found':
        return LoginWithPhoneException('user-not-found');
      case 'too-many-requests':
        return LoginWithPhoneException('too-many-requests');
      case 'network-request-failed':
        return LoginWithPhoneException('network-request-failed');
      case 'operation-not-allowed':
        return LoginWithPhoneException('operation-not-allowed');
      case 'invalid-phone-number':
        return LoginWithPhoneException('invalid-phone-number');
      case 'invalid-credential':
        return LoginWithPhoneException('invalid-credential');
      default:
        return LoginWithPhoneException('An unknown error occurred.');
    }
  }

  final String message;
}
