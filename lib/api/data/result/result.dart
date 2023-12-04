/// Результат прохождения квиза
class QuizResult {
  /// Данные об игроке
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneOrTelegram;
  final String? workOrStudy;

  /// Ответы игрока
  final List<Response> responses;

  QuizResult({
    required this.responses,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneOrTelegram,
    this.workOrStudy,
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
  /// Введённые пользователем строки
  final String inputFirstName;
  final String inputLastName;
  final String inputEmail;
  final String inputPhoneOrTelegram;
  final String inputWorkOrStudy;

  InputResponse({
    required String question,
    required this.inputFirstName,
    required this.inputLastName,
    required this.inputEmail,
    required this.inputPhoneOrTelegram,
    required this.inputWorkOrStudy,
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
