class ErrorMessages {
  ErrorMessages._();
  static String errorMessage(String? error) {
    if (error == 'Invalid credentials') {
      return 'There is an error in the username or password';
    }
    if (error == 'The email field must be a valid email address.') {
      return 'The email is invalid';
    }
    if (error == 'The email has already been taken.' ||
        error == 'The email has already been taken. (and 2 more errors)') {
      return 'The email is already in use';
    }
    if (error == 'no internet connection or server error occurred') {
      return 'No internet connection or server error';
    }
    if (error == 'error occurred, please try again later') {
      return 'Please try again later';
    }
    if (error ==
        'A reset code has already been sent to this email. Please check your email') {
      return 'A reset code has already been sent to your email';
    }
    if (error == 'The selected email is invalid.') {
      return 'The email is invalid';
    }
    if (error == 'Invalid or expired token') {
      return 'The code is invalid';
    }
    if (error == 'The token field must be 6 digits.') {
      return 'The code must be 6 digits';
    }
    if (error == 'Invalid or expired token') {
      return 'The code is invalid or has expired';
    }
    if (error == 'There Is No Diet Fit With This Information') {
      return 'There is no diet that fits this information';
    }
    if (error == null || error.isEmpty) {
      return 'Sorry, there is an error. Please try again later';
    } else {
      return 'Sorry, there is an error. Please try again later';
    }
  }
}
