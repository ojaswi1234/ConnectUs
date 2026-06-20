// lib/utils/phone_utils.dart

String normalizePhone(String raw) {
  // Strip all non-digit characters
  String digitsOnly = raw.replaceAll(RegExp(r'\D'), '');
  
  // If it starts with 0 and is 11 digits, strip the 0
  if (digitsOnly.startsWith('0') && digitsOnly.length == 11) {
    digitsOnly = digitsOnly.substring(1);
  }
  
  // If it is just the 10 digit number, prepend +91 (default Indian country code for example)
  // Assuming the app stores numbers in E.164 format with country code
  if (digitsOnly.length == 10) {
    return '+91$digitsOnly';
  }
  
  // If it's already got the country code (e.g. 91xxxxxxxxxx), prepend +
  if (digitsOnly.length == 12 && digitsOnly.startsWith('91')) {
    return '+$digitsOnly';
  }
  
  // Otherwise, just prepend + if it looks like a full number
  if (digitsOnly.length > 10) {
    return '+$digitsOnly';
  }
  
  return raw; // Fallback if we can't parse it well
}
