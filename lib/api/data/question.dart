abstract class Question<T> {
  final String id;
  final String text;
  T? result;

  Question({
    required this.id,
    required this.text,
    this.result,
  });
}
