abstract class Question<T> {
  final String? id;
  final String text;
  final bool canSkip;
  final bool hide;
  T? result;

  Question({
    required this.id,
    required this.text,
    this.result,
    bool? canSkip,
    bool? hide,
  })  : canSkip = canSkip ?? false,
        hide = hide ?? false;
}
