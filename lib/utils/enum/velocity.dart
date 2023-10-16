/// FastAudio velocity
enum VelocityEnum {
  x1,
  x1_5,
  x2;

  String get name {
    if (this == VelocityEnum.x1_5) return '1,5x';
    if (this == VelocityEnum.x2) return '2x';
    return '1x';
  }

  VelocityEnum next() {
    if (this == VelocityEnum.x1) return VelocityEnum.x1_5;
    if (this == VelocityEnum.x1_5) return VelocityEnum.x2;
    return VelocityEnum.x1;
  }

  double get value {
    if (this == VelocityEnum.x1_5) return 1.5;
    if (this == VelocityEnum.x2) return 2;
    return 1;
  }
}
