class AssistantMethods {
  static String getName(String sentence) {
    if (sentence.isNotEmpty) {
      final words = sentence.split(' ');
      if (words.isNotEmpty) {
        var name = words[0].toLowerCase();
        return name.replaceAll(name[0], name[0].toUpperCase());
      }
    }
    return '';
  }
}
