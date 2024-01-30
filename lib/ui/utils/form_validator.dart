String? nameValidator(String? input) {
  if (input == null || input.trim().length < 2) {
    return 'Name must be 2 characters long';
  } else {
    return null;
  }
}

String? phoneValidator(String? input) {
  if (input == null || input == '') {
    return 'Please enter your phone number';
  } else if (input.trim().length < 10) {
    return 'Phone number must be 10 numbers long';
  } else {
    return null;
  }
}

String? addressValidator(String? input) {
  if (input == null || input == '') {
    return 'Please enter your address';
  } else if (input.trim().length < 5) {
    return 'Address must be 5 characters long';
  } else {
    return null;
  }
}

String? emailValidator(String? input) {
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (input == null || !emailRegex.hasMatch(input)) {
    return 'Enter valid email Address';
  } else {
    return null;
  }
}

String? passValidator(String? input) {
  if (input == null || input.trim().length < 8) {
    return 'Password must be 8 characters long';
  } else {
    return null;
  }
}

String? strongPassValidator(String? input) {
  RegExp regex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]).{8,}$',
  );

  if (input == null || input.trim().length < 8) {
    return 'Password must be 8 characters long';
  } else if (!regex.hasMatch(input)) {
    return 'Enter Strong password';
  } else {
    return null;
  }
}
