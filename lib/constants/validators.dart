class Validator {
  /// Validate phone number format
  static String? validatePhoneNumber(String? value, String dialCode) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove all spaces and special characters
    String phone = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Basic length check (customizable)
    if (phone.length < 6 || phone.length > 15) {
      return 'Invalid phone number length';
    }

    // Example validation for India
    if (dialCode == '+91' && !RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) {
      return 'Enter a valid Indian mobile number';
    }

    return null; // Valid number
  }

  static validatePassword(String? value) {}
}
