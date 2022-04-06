import 'package:meta/meta.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/assets/assets.dart';

enum SelectionType {
  single,
  multi,
}

@immutable
class SelectionItem {
  final String text;
  final bool isCorrect;

  @override
  int get hashCode => text.hashCode;

  const SelectionItem(this.text, {bool? isCorrect}) : isCorrect = isCorrect ?? false;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectionItem && runtimeType == other.runtimeType && text == other.text;
}

class SelectionQuestion extends Question<List<SelectionItem>> {
  final Iterable<SelectionItem> questions;
  final SelectionType selectionType;

  SelectionQuestion({
    required String id,
    required String text,
    required this.questions,
    required this.selectionType,
    bool? canSkip,
  }) : super(id: id, text: text, canSkip: canSkip);
}

extension SelectionTypeX on SelectionType {
  String get description {
    switch (this) {
      case SelectionType.multi:
        return StringRes.multiSelection;
      case SelectionType.single:
      default:
        return StringRes.singleSelection;
    }
  }
}
