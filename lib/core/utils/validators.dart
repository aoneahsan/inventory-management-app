import '../constants/app_constants.dart';

class Validators {
  Validators._();

  // Email Validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    if (!AppConstants.emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  // Password Validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    
    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must not exceed ${AppConstants.maxPasswordLength} characters';
    }
    
    if (!AppConstants.passwordRegex.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
    }
    
    return null;
  }

  // Confirm Password Validator
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  // Required Field Validator
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  // Phone Number Validator
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove any non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (!AppConstants.phoneRegex.hasMatch(digitsOnly)) {
      return 'Please enter a valid phone number';
    }
    
    return null;
  }

  // URL Validator
  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }
    
    if (!AppConstants.urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    
    return null;
  }

  // Name Validator
  static String? name(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Name'} is required';
    }
    
    if (value.length < 2) {
      return '${fieldName ?? 'Name'} must be at least 2 characters';
    }
    
    if (value.length > AppConstants.maxNameLength) {
      return '${fieldName ?? 'Name'} must not exceed ${AppConstants.maxNameLength} characters';
    }
    
    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return '${fieldName ?? 'Name'} contains invalid characters';
    }
    
    return null;
  }

  // Username Validator
  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    
    if (value.length > 30) {
      return 'Username must not exceed 30 characters';
    }
    
    if (!AppConstants.alphanumericRegex.hasMatch(value)) {
      return 'Username can only contain letters and numbers';
    }
    
    return null;
  }

  // Numeric Validator
  static String? numeric(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (!AppConstants.numericRegex.hasMatch(value)) {
      return '${fieldName ?? 'This field'} must be a number';
    }
    
    return null;
  }

  // Decimal Validator
  static String? decimal(String? value, {String? fieldName, int? maxDecimalPlaces}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final decimalPlaces = maxDecimalPlaces ?? AppConstants.priceDecimalPlaces;
    final regex = RegExp('^\\d+(\\.\\d{1,$decimalPlaces})?\$');
    
    if (!regex.hasMatch(value)) {
      return '${fieldName ?? 'This field'} must be a valid decimal number with up to $decimalPlaces decimal places';
    }
    
    return null;
  }

  // Price Validator
  static String? price(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }
    
    final error = decimal(value, fieldName: 'Price');
    if (error != null) return error;
    
    final price = double.tryParse(value);
    if (price == null) {
      return 'Invalid price format';
    }
    
    if (price < AppConstants.minPrice) {
      return 'Price must be at least \$${AppConstants.minPrice.toStringAsFixed(2)}';
    }
    
    if (price > AppConstants.maxPrice) {
      return 'Price must not exceed \$${AppConstants.maxPrice.toStringAsFixed(2)}';
    }
    
    return null;
  }

  // Quantity Validator
  static String? quantity(String? value, {int? min, int? max}) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    
    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'Quantity must be a whole number';
    }
    
    if (min != null && quantity < min) {
      return 'Quantity must be at least $min';
    }
    
    if (max != null && quantity > max) {
      return 'Quantity must not exceed $max';
    }
    
    if (quantity < 0) {
      return 'Quantity cannot be negative';
    }
    
    return null;
  }

  // SKU Validator
  static String? sku(String? value) {
    if (value == null || value.isEmpty) {
      return 'SKU is required';
    }
    
    if (value.length != AppConstants.skuLength) {
      return 'SKU must be exactly ${AppConstants.skuLength} characters';
    }
    
    if (!AppConstants.alphanumericRegex.hasMatch(value)) {
      return 'SKU can only contain letters and numbers';
    }
    
    return null;
  }

  // Barcode Validator
  static String? barcode(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Barcode is optional
    }
    
    if (value.length != AppConstants.barcodeLength) {
      return 'Barcode must be exactly ${AppConstants.barcodeLength} digits';
    }
    
    if (!AppConstants.numericRegex.hasMatch(value)) {
      return 'Barcode must contain only numbers';
    }
    
    // EAN-13 checksum validation
    if (!_isValidEAN13(value)) {
      return 'Invalid barcode checksum';
    }
    
    return null;
  }

  // Description Validator
  static String? description(String? value, {int? maxLength}) {
    if (value == null || value.isEmpty) {
      return null; // Description is optional
    }
    
    final max = maxLength ?? AppConstants.maxDescriptionLength;
    if (value.length > max) {
      return 'Description must not exceed $max characters';
    }
    
    return null;
  }

  // Notes Validator
  static String? notes(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Notes are optional
    }
    
    if (value.length > AppConstants.maxNotesLength) {
      return 'Notes must not exceed ${AppConstants.maxNotesLength} characters';
    }
    
    return null;
  }

  // Date Validator
  static String? date(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Date'} is required';
    }
    
    try {
      DateTime.parse(value);
      return null;
    } catch (_) {
      return 'Please enter a valid date';
    }
  }

  // Future Date Validator
  static String? futureDate(String? value, {String? fieldName}) {
    final dateError = date(value, fieldName: fieldName);
    if (dateError != null) return dateError;
    
    final inputDate = DateTime.parse(value!);
    if (inputDate.isBefore(DateTime.now())) {
      return '${fieldName ?? 'Date'} must be in the future';
    }
    
    return null;
  }

  // Past Date Validator
  static String? pastDate(String? value, {String? fieldName}) {
    final dateError = date(value, fieldName: fieldName);
    if (dateError != null) return dateError;
    
    final inputDate = DateTime.parse(value!);
    if (inputDate.isAfter(DateTime.now())) {
      return '${fieldName ?? 'Date'} must be in the past';
    }
    
    return null;
  }

  // Percentage Validator
  static String? percentage(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Percentage'} is required';
    }
    
    final percentage = double.tryParse(value);
    if (percentage == null) {
      return 'Invalid percentage format';
    }
    
    if (percentage < 0 || percentage > 100) {
      return '${fieldName ?? 'Percentage'} must be between 0 and 100';
    }
    
    return null;
  }

  // Discount Validator
  static String? discount(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Discount is optional
    }
    
    return percentage(value, fieldName: 'Discount');
  }

  // Zip Code Validator
  static String? zipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zip code is required';
    }
    
    if (value.length != AppConstants.zipCodeLength) {
      return 'Zip code must be ${AppConstants.zipCodeLength} digits';
    }
    
    if (!AppConstants.numericRegex.hasMatch(value)) {
      return 'Zip code must contain only numbers';
    }
    
    return null;
  }

  // Credit Card Validator
  static String? creditCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }
    
    // Remove spaces and dashes
    final cardNumber = value.replaceAll(RegExp(r'[\s-]'), '');
    
    if (cardNumber.length < 13 || cardNumber.length > 19) {
      return 'Invalid credit card number';
    }
    
    if (!AppConstants.numericRegex.hasMatch(cardNumber)) {
      return 'Credit card number must contain only numbers';
    }
    
    // Luhn algorithm validation
    if (!_isValidLuhn(cardNumber)) {
      return 'Invalid credit card number';
    }
    
    return null;
  }

  // CVV Validator
  static String? cvv(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    
    if (value.length != 3 && value.length != 4) {
      return 'CVV must be 3 or 4 digits';
    }
    
    if (!AppConstants.numericRegex.hasMatch(value)) {
      return 'CVV must contain only numbers';
    }
    
    return null;
  }

  // OTP Validator
  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    
    if (value.length != AppConstants.otpLength) {
      return 'OTP must be ${AppConstants.otpLength} digits';
    }
    
    if (!AppConstants.numericRegex.hasMatch(value)) {
      return 'OTP must contain only numbers';
    }
    
    return null;
  }

  // Min Length Validator
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }
    
    return null;
  }

  // Max Length Validator
  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return null; // Allow empty values
    }
    
    if (value.length > maxLength) {
      return '${fieldName ?? 'This field'} must not exceed $maxLength characters';
    }
    
    return null;
  }

  // Range Validator
  static String? range(String? value, num min, num max, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    
    final number = num.tryParse(value);
    if (number == null) {
      return '${fieldName ?? 'This field'} must be a number';
    }
    
    if (number < min || number > max) {
      return '${fieldName ?? 'This field'} must be between $min and $max';
    }
    
    return null;
  }

  // Helper Methods
  static bool _isValidEAN13(String barcode) {
    if (barcode.length != 13) return false;
    
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      int digit = int.parse(barcode[i]);
      sum += (i % 2 == 0) ? digit : digit * 3;
    }
    
    int checkDigit = (10 - (sum % 10)) % 10;
    return checkDigit == int.parse(barcode[12]);
  }

  static bool _isValidLuhn(String cardNumber) {
    int sum = 0;
    bool alternate = false;
    
    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);
      
      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      
      sum += digit;
      alternate = !alternate;
    }
    
    return sum % 10 == 0;
  }
}