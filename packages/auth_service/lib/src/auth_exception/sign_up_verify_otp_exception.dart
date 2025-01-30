class SignUpVerifyOtpException implements Exception {
  const SignUpVerifyOtpException([
    this.message = 'An unknown exception occurred.',
  ]);

  factory SignUpVerifyOtpException.fromCode(String code) {
    switch (code) {
      case 'invalid-verification-code':
        return const SignUpVerifyOtpException('The provided verification code is invalid.');
      case 'invalid-verification-id':
        return const SignUpVerifyOtpException('The provided verification ID is invalid.');
      case 'user-disabled':
        return const SignUpVerifyOtpException('The user corresponding to this verification has been disabled.');
      case 'user-not-found':
        return const SignUpVerifyOtpException('No user corresponding to this verification could be found.');
      case 'too-many-requests':
        return const SignUpVerifyOtpException(
            'We have blocked all requests from this device due to unusual activity. Try again later.');
      default:
        return const SignUpVerifyOtpException();
    }
  }

  final String message;
}
