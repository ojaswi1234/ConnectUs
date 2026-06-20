/// Normalises a raw phone input to +91XXXXXXXXXX format.
/// Strips spaces, dashes, parens, leading +91 prefix or leading 0,
/// then prepends +91.
///
/// Examples:
///   "9876543210"      → "+919876543210"
///   "09876543210"     → "+919876543210"
///   "+91 98765 43210" → "+919876543210"
String normalizePhone(String raw) {
  // Remove formatting characters but keep digits
  String digits = raw.replaceAll(RegExp(r'[\s\-().+]'), '');
  // Strip leading country code 91 if already present
  if (digits.startsWith('91') && digits.length == 12) {
    digits = digits.substring(2);
  } else if (digits.startsWith('0') && digits.length == 11) {
    digits = digits.substring(1);
  }
  return '+91$digits';
}
