/// Результат прохождения квиза
class QuizResult {
  /// Данные об игроке
  final String? person;

  /// Ответы игрока
  final List<Response> responses;

  QuizResult({
    required this.responses,
    this.person,
  });
}

/// Ответ на вопрос из квиза
abstract class Response {
  /// Вопрос, на который давался ответ
  final String question;

  const Response({
    required this.question,
  });

  TResult visit<TResult>(IResponseVisitor<TResult> visitor);
}

/// Ответ на вопрос с типом поля ввода
class InputResponse extends Response {
  /// Введённая пользователем строка
  final String inputResult;

  InputResponse({
    required String question,
    required this.inputResult,
  }) : super(question: question);

  @override
  TResult visit<TResult>(IResponseVisitor<TResult> visitor) => visitor.inputResponse(this);
}

/// Ответ на вопрос с выбором ответа из списка
class SelectionResponse extends Response {
  /// Выбранные ответы
  final List<SelectedItem> selectedItems;

  SelectionResponse({
    required String question,
    required this.selectedItems,
  }) : super(question: question);

  @override
  TResult visit<TResult>(IResponseVisitor<TResult> visitor) => visitor.selectionVisit(this);
}

/// Выбранный ответ из списка
class SelectedItem {
  /// Вставляется ответ из списка
  final String response;

  /// Правильный ответ
  final bool isCorrect;

  SelectedItem({
    required this.response,
    required this.isCorrect,
  });
}

abstract class IResponseVisitor<T> {
  T selectionVisit(SelectionResponse response);

  T inputResponse(InputResponse response);
}
