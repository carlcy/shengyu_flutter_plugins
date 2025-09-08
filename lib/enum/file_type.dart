enum ResType {
  unknown(-1), file(0), image(1), audio(2), video(3);

  final int value;

  const ResType(this.value);

  static ResType parse(int value) {
    for(var type in values) {
      if (type.value == value) {
        return type;
      }
    }

    return ResType.unknown;
  }
}