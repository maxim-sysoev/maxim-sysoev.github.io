import 'package:collection/collection.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/result/result.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/api/service/data_export_service/data_export_service.dart';

class _ColumnData {
  final String info;
  final String value;

  _ColumnData(String info, String value)
      : info = '"$info"',
        value = '"$value"';
}

class CsvResponseVisitor implements IResponseVisitor<_ColumnData> {
  final List<Question> questions;

  CsvResponseVisitor(this.questions);

  @override
  _ColumnData inputResponse(InputResponse response) {
    return _ColumnData(response.question, response.inputResult);
  }

  @override
  _ColumnData selectionVisit(SelectionResponse response) {
    final question = questions
        .whereType<SelectionQuestion>()
        .firstWhereOrNull((element) => element.text == response.question);
    if (question != null && question.selectionType == SelectionType.multi) {
      final correctCount = question.questions.where((element) => element.isCorrect).length;
      final correctSelectedCount =
          response.selectedItems.where((element) => element.isCorrect).length;
      final incorrectSelectedCount =
          response.selectedItems.where((element) => !element.isCorrect).length;

      return _ColumnData(
        response.question,
        'верно: $correctSelectedCount/$correctCount\n'
        'неверно: $incorrectSelectedCount',
      );
    } else {
      final result = response.selectedItems.every((element) => element.isCorrect);
      return _ColumnData(response.question, result ? 'Верно' : 'Неверно');
    }
  }
}

class CsvDataExportService extends DataExportService {
  @override
  void exportResults(List<QuizResult> results, List<Question> questions) {
    final visitor = CsvResponseVisitor(questions);
    final responses = results.map((e) {
      final array = [
        _ColumnData(e.person ?? 'unknown', ''),
        ...e.responses.map((e) => e.visit(visitor)),
      ];
      return '${array.map((e) => e.info).join(';')}\n'
          '${array.map((e) => e.value).join(';')}';
    }).join('\n\n');

    saveFile('csv', responses);
  }
}
