import 'package:meta/meta.dart';
import 'package:quiz/api/data/question.dart';

enum SelectionType {
  single,
  multi,
}

@immutable
class SelectionItem {
  final String text;
  final bool isCorrect;

  const SelectionItem(this.text, {bool? isCorrect}) : isCorrect = isCorrect ?? false;
}

class SelectionQuestion extends Question<List<SelectionItem>> {
  final Iterable<SelectionItem> questions;
  final SelectionType selectionType;

  SelectionQuestion({
    required String id,
    required String text,
    required this.questions,
    required this.selectionType,
  }) : super(id: id, text: text);
}
