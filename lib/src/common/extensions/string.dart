extension StringUtils on String {
  bool get isNum => HelperUtils.isNum(this);

  bool get isNumericOnly => HelperUtils.isNumericOnly(this);

  bool get isAlphabetOnly => HelperUtils.isAlphabetOnly(this);

  bool get isBool => HelperUtils.isBool(this);

  bool get isImageFileName => HelperUtils.isImage(this);

  bool get isAudioFileName => HelperUtils.isAudio(this);

  bool get isVideoFileName => HelperUtils.isVideo(this);

  bool get isFullName => HelperUtils.isFullName(this);

  bool get isURL => HelperUtils.isURL(this);

  bool get isValidEmail => HelperUtils.isEmail(this);

  bool get isPhoneNumber => HelperUtils.isPhoneNumber(this);

  bool get isDateTime => HelperUtils.isDateTime(this);

  bool isCaseInsensitiveContains(String b) =>
      HelperUtils.isCaseInsensitiveContains(this, b);

  bool isCaseInsensitiveContainsAny(String b) =>
      HelperUtils.isContains(this, b);

  String? get capitalize => HelperUtils.capitalize(this);

  String? get capitalizeFirst => HelperUtils.capitalizeFirst(this);

  String get removeAllWhitespace => HelperUtils.removeAllWhitespace(this);

  String get spaceToUnderscore => HelperUtils.spaceToUnderscore(this);

  String? get camelCase => HelperUtils.camelCase(this);

  String? get paramCase => HelperUtils.paramCase(this);

  String numericOnly({bool firstWordOnly = false}) =>
      HelperUtils.numericOnly(this, firstWordOnly: firstWordOnly);

  String cut(int length) {
    if (this.length <= length) {
      return this;
    }
    return '${substring(0, length)}...';
  }
}

/// Returns whether a dynamic value PROBABLY
/// has the isEmpty getter/method by checking
/// standard dart types that contains it.
///
/// This is here to for the 'DRY'
bool? _isEmpty(dynamic value) {
  if (value is String) {
    return value.toString().trim().isEmpty;
  }
  if (value == null) {
    return true;
  }
  if (value is String) {
    return value.trim().isEmpty;
  }
  if (value is Iterable) {
    return value.isEmpty;
  }
  if (value is Map) {
    return value.isEmpty;
  }
  return false;
}

/// Obtains a length of a dynamic value
/// by previously validating it's type
///
/// Note: if [value] is double/int
/// it will be taking the .toString
/// length of the given value.
///
/// Note 2: **this may return null!**
///
/// Note 3: null [value] returns null.
int? _obtainDynamicLength(dynamic value) {
  if (value == null) {
    // ignore: avoid_returning_null
    return null;
  }

  if (value is String) {
    return value.length;
  }

  if (value is Iterable) {
    return value.length;
  }

  if (value is Map) {
    return value.length;
  }

  if (value is int) {
    return value.toString().length;
  }

  if (value is double) {
    return value.toString().replaceAll('.', '').length;
  }

  return null;
}

class HelperUtils {
  HelperUtils._();

  /// Checks if data is null.
  static bool isNull(dynamic value) => value == null;

  /// In dart2js (in flutter v1.17) a var by default is undefined.
  /// *Use this only if you are in version <- 1.17*.
  /// So we assure the null type in json convertions to avoid the
  /// 'value':value==null?null:value; someVar.nil will force the null type
  /// if the var is null or undefined.
  /// `nil` taken from ObjC just to have a shorter sintax.
  // static dynamic nil(dynamic s) => s == null ? null : s;

  /// Checks if data is null or blank (empty or only contains whitespace).
  static bool? isNullOrBlank(dynamic value) {
    if (isNull(value)) {
      return true;
    }

    // Pretty sure that isNullOrBlank should't be validating
    // iterables... but I'm going to keep this for compatibility.
    return _isEmpty(value);
  }

  /// Checks if data is null or blank (empty or only contains whitespace).
  static bool? isBlank(dynamic value) => _isEmpty(value);

  /// Checks if string is int or double.
  static bool isNum(String value) {
    if (isNull(value)) {
      return false;
    }

    return num.tryParse(value) is num;
  }

  /// Checks if string consist only numeric.
  /// Numeric only doesn't accepting '.' which double data type have
  static bool isNumericOnly(String s) => hasMatch(s, r'^\d+$');

  /// Checks if string consist only Alphabet. (No Whitespace)
  static bool isAlphabetOnly(String s) => hasMatch(s, r'^[a-zA-Z]+$');

  /// Checks if string contains at least one Capital Letter
  static bool hasCapitalletter(String s) => hasMatch(s, r'[A-Z]');

  /// Checks if string is boolean.
  static bool isBool(String value) {
    if (isNull(value)) {
      return false;
    }

    return value == 'true' || value == 'false';
  }

  /// Checks if string is an video file.
  static bool isVideo(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.mp4') ||
        ext.endsWith('.avi') ||
        ext.endsWith('.wmv') ||
        ext.endsWith('.rmvb') ||
        ext.endsWith('.mpg') ||
        ext.endsWith('.mpeg') ||
        ext.endsWith('.3gp');
  }

  /// Checks if string is an image file.
  static bool isImage(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.jpg') ||
        ext.endsWith('.jpeg') ||
        ext.endsWith('.png') ||
        ext.endsWith('.gif') ||
        ext.endsWith('.bmp');
  }

  /// Checks if string is an audio file.
  static bool isAudio(String filePath) {
    final ext = filePath.toLowerCase();

    return ext.endsWith('.mp3') ||
        ext.endsWith('.wav') ||
        ext.endsWith('.wma') ||
        ext.endsWith('.amr') ||
        ext.endsWith('.ogg');
  }

  /// Checks if string is a valid username.
  static bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  // Checks if a string is a valid full name
  static bool isFullName(String name) {
    // Trim whitespace from the input
    final trimmedName = name.trim();
    // Split the name by spaces
    final nameParts = trimmedName.split(' ');
    // Check if there are at least two parts (first name and last name)
    if (nameParts.length < 2) {
      return false; // Not a valid full name
    }
    // Check if both first name and last name are not empty
    final firstName = nameParts.first;
    final lastName = nameParts.last;

    return firstName.isNotEmpty && lastName.isNotEmpty;
  }

  /// Checks if string is URL.
  static bool isURL(String s) => hasMatch(s,
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$");

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

  /// Checks if string is phone number.
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is DateTime (UTC or Iso8601).
  static bool isDateTime(String s) =>
      hasMatch(s, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$');

  /// Checks if length of data is GREATER than maxLength.
  static bool isLengthGreaterThan(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length > maxLength;
  }

  /// Checks if length of data is GREATER OR EQUAL to maxLength.
  static bool isLengthGreaterOrEqual(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length >= maxLength;
  }

  /// Checks if length of data is LOWER than maxLength.
  ///
  @Deprecated('This method is deprecated, use [isLengthLessThan] instead')
  static bool isLengthLowerThan(dynamic value, int maxLength) =>
      isLengthLessThan(value, maxLength);

  /// Checks if length of data is LESS than maxLength.
  static bool isLengthLessThan(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);
    if (length == null) {
      return false;
    }

    return length < maxLength;
  }

  /// Checks if length of data is LOWER OR EQUAL to maxLength.
  ///
  @Deprecated('This method is deprecated, use [isLengthLessOrEqual] instead')
  static bool isLengthLowerOrEqual(dynamic value, int maxLength) =>
      isLengthLessOrEqual(value, maxLength);

  /// Checks if length of data is LESS OR EQUAL to maxLength.
  static bool isLengthLessOrEqual(dynamic value, int maxLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length <= maxLength;
  }

  /// Checks if length of data is EQUAL to maxLength.
  static bool isLengthEqualTo(dynamic value, int otherLength) {
    final length = _obtainDynamicLength(value);

    if (length == null) {
      return false;
    }

    return length == otherLength;
  }

  /// Checks if length of data is BETWEEN minLength to maxLength.
  static bool isLengthBetween(dynamic value, int minLength, int maxLength) {
    if (isNull(value)) {
      return false;
    }

    return isLengthGreaterOrEqual(value, minLength) &&
        isLengthLessOrEqual(value, maxLength);
  }

  /// Checks if a contains b (Treating or interpreting upper- and lowercase
  /// letters as being the same).
  static bool isCaseInsensitiveContains(String a, String b) =>
      a.toLowerCase().contains(b.toLowerCase());

  /// Checks if a contains b or b contains a (Treating or
  /// interpreting upper- and lowercase letters as being the same).
  static bool isContains(String a, String b) {
    final lowA = a.toLowerCase();
    final lowB = b.toLowerCase();

    return lowA.contains(lowB) || lowB.contains(lowA);
  }

  /// Checks if num a LOWER than num b.
  static bool isLowerThan(num a, num b) => a < b;

  /// Checks if num a GREATER than num b.
  static bool isGreaterThan(num a, num b) => a > b;

  /// Checks if num a EQUAL than num b.
  static bool isEqual(num a, num b) => a == b;

  /// Capitalize each word inside string
  /// Example: your name => Your Name, your name => Your name
  static String? capitalize(String value) {
    if (isNull(value)) return null;
    if (isBlank(value)!) return value;
    return value.split('').map(capitalizeFirst).join('');
  }

  /// Uppercase first letter inside string and let the others lowercase
  /// Example: your name => Your name
  static String? capitalizeFirst(String s) {
    if (isNull(s)) return null;
    if (isBlank(s)!) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }

  /// Remove all whitespace inside string
  /// Example: your name => yourname
  static String removeAllWhitespace(String value) => value.replaceAll(' ', '');

  ///Replaces all spaces inside a string with an underscore
  ///Example: your name => your_name
  static String spaceToUnderscore(String value) => value.replaceAll(' ', '_');

  /// Camelcase string
  /// Example: your name => yourName
  static String? camelCase(String value) {
    if (isNullOrBlank(value)!) {
      return null;
    }

    final separatedWords =
        value.split(RegExp(r"[!@#<>?':`~;[\]\\|=+)(*&^%-\s_]+"));
    var newString = '';

    for (final word in separatedWords) {
      newString += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }

    return newString[0].toLowerCase() + newString.substring(1);
  }

  /// credits to 'ReCase' package.
  static final RegExp _upperAlphaRegex = RegExp(r'[A-Z]');
  static final _symbolSet = {' ', '.', '/', '_', '\\', '-'};
  static List<String> _groupIntoWords(String text) {
    final sb = StringBuffer();
    final words = <String>[];
    final isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      final nextChar = i + 1 == text.length ? null : text[i + 1];
      if (_symbolSet.contains(char)) {
        continue;
      }
      sb.write(char);
      final isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          _symbolSet.contains(nextChar);
      if (isEndOfWord) {
        words.add('$sb');
        sb.clear();
      }
    }
    return words;
  }

  /// snake_case
  static String? snakeCase(String? text, {String separator = '_'}) {
    if (isNullOrBlank(text)!) {
      return null;
    }
    return _groupIntoWords(text!)
        .map((word) => word.toLowerCase())
        .join(separator);
  }

  /// param-case
  static String? paramCase(String? text) => snakeCase(text, separator: '-');

  /// Extract numeric value of string
  /// Example: OTP 12312 27/04/2020 => 1231227042020ß
  /// If firstword only is true, then the example return is '12312'
  /// (first found numeric word)
  static String numericOnly(String s, {bool firstWordOnly = false}) {
    var numericOnlyStr = '';

    for (var i = 0; i < s.length; i++) {
      if (isNumericOnly(s[i])) {
        numericOnlyStr += s[i];
      }
      if (firstWordOnly && numericOnlyStr.isNotEmpty && s[i] == ' ') {
        break;
      }
    }

    return numericOnlyStr;
  }

  static bool hasMatch(String? value, String pattern) =>
      (value == null) ? false : RegExp(pattern).hasMatch(value);
}
