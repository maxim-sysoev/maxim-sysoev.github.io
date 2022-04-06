class StringRes {
  static const String quizHeader1 = 'Хочешь ';
  static const String quizHeader2 = 'стать ';
  static const String quizHeader3 = 'Flutter-разработчиком?';
  static const String quizDescription = 'Пройди квиз и стань частью команды Surf!';

  static const String startQuiz = 'Начать';
  static const String back = 'Назад';

  static const String singleSelection = 'Выбери один вариант ответа:';
  static const String multiSelection = 'Выбери один или несколько вариантов ответа:';

  static const String nextQuestion = 'Далее';
  static const String skipQuestion = 'или пропустить вопрос';

  static const String resultHeader1 = 'Ты ';
  static const String resultHeader2 = 'потрясающий!';
  static const String resultDescription =
      'Обязательно посети наши станции, посвящённые QA, Аналитике, Android и iOS разработке.';
  static const String resultAction = 'На главную';

  const StringRes._();

  static String quizTotalState(int total) => ' из $total вопросов';
}
