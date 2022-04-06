abstract class Question<T> {
  final String id;
  final String text;
  final bool canSkip;
  T? result;

  Question({
    required this.id,
    required this.text,
    this.result,
    bool? canSkip,
  }) : canSkip = canSkip ?? false;
}
