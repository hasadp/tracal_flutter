class FormValidators {
  static String? validateDouble(String? value) {
    if (double.tryParse(value!) == null) {
      return 'Invalid value';
    } else {
      return null;
    }
  }

  FormValidators._();

  static String? validateInt(String? value) {
    if (int.tryParse(value!) == null) {
      return 'Invalid value';
    } else {
      return null;
    }
  }

  String? validateNoNull(String? value) {
    if (value == null) {
      return 'Invalid';
    } else {
      return null;
    }
  }
}
