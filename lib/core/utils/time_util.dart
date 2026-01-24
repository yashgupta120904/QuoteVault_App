import 'package:intl/intl.dart';

/// Converts "08:30 AM" → "03:00" (UTC)


/// "08:30 AM" → "08:30"
/// "11:45 PM" → "23:45"
/// "23:00"    → "23:00"
/// "08:05"    → "08:05"
String convert12hToUtcHHmm(String time) {
  try {
    // If contains AM or PM → 12-hour format
    if (time.toUpperCase().contains('AM') ||
        time.toUpperCase().contains('PM')) {
      final parsed12h = DateFormat('hh:mm a').parseStrict(time);
      return DateFormat('HH:mm').format(parsed12h);
    }

    // Otherwise assume 24-hour format
    final parsed24h = DateFormat('HH:mm').parseStrict(time);
    return DateFormat('HH:mm').format(parsed24h);
  } catch (e) {
    throw FormatException(
        'Invalid time format. Use "hh:mm AM/PM" or "HH:mm"');
  }
}

