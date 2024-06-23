class ValidationErrorTexts {
  ValidationErrorTexts._();

  static String? otpValidation(
    String? field,
  ) {
    if (field == null || field.isEmpty) {
      return '                                                  برجاء إدخال الرمز';
    }
    if (field.length < 6) {
      return '                                           الرمز يجب أن يكون 6 أرقام';
    }
    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.isEmpty || name.trim().isEmpty) {
      return 'please enter your name';
    }
    if (name.contains(RegExp(r'[^\w\s]+')) || name.contains('_')) {
      return 'do not use special characters';
    }
    if (name.contains(' ')) {
      return 'do not use spaces';
    }
    if (!name.contains(RegExp(r'\D+'))) {
      return 'do not use numbers';
    }
    if (name.length < 2) {
      return 'should not be less than two letters';
    }
    return null;
  }

  static String? signUpPasswordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*\-+=_(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    if (password.contains(' ')) {
      return 'No spaces allowed';
    }
    return null;
  }

  static String? loginPasswordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (password.contains(' ')) {
      return 'No spaces allowed';
    }
    return null;
  }

  static String? confirmPasswordValidation(
    String? passwordConfirmation,
    String? password,
  ) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return 'please enter the password confirmation';
    }
    if (password != passwordConfirmation) {
      return 'passwords do not match';
    }
    if (passwordConfirmation.contains(' ')) {
      return 'do not use spaces';
    }
    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'please enter your email';
    }
    if (email.length < 5 ||
        !RegExp(r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,}$')
            .hasMatch(email)) {
      return 'please enter a valid email';
    }

    if (email.contains(' ')) {
      return 'do not use spaces';
    }
    return null;
  }
}
