import 'package:uuid/uuid.dart';

/// use this class to generate uuid
///
/// example:
///
/// ```dart
/// final uuid = FastUUID.v4();
/// ```
class FastUUID {
  FastUUID._();

  static const _uuid = Uuid();

  static String v1() => _uuid.v1();
  static String v4() => _uuid.v4();
  static String v5(String name) => _uuid.v5(Uuid.NAMESPACE_URL, name);
}
