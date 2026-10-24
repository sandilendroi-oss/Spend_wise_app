/// Small helpers that read values out of decoded JSON safely.
///
/// A Mock API can return numbers where we expect text (e.g. `"id": 1`),
/// `null`, or leave a field out completely. These helpers turn all of that
/// into a predictable Dart value instead of letting the app crash.

/// Returns [value] as a trimmed String, or `null` if it is missing / unusable.
String? readString(Object? value) {
  if (value == null) return null;
  if (value is String) return value.trim();
  if (value is num || value is bool) return value.toString();
  return null;
}

/// Returns [value] as a list of Strings.
///
/// - A JSON list becomes a list of Strings (null items are skipped).
/// - A single non-empty String becomes a one-item list.
/// - Anything else (missing, null, wrong type) becomes an empty list.
List<String> readStringList(Object? value) {
  if (value is List) {
    return value
        .where((item) => item != null)
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toList();
  }
  if (value is String && value.trim().isNotEmpty) {
    return [value.trim()];
  }
  return const [];
}
