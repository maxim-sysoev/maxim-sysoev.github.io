import 'package:intl/intl.dart';

class StringRes {
  static const String quizHeader = 'Проверь, как ты ориентируешься в мире IT';

  static const String quizDescriptionWhyTakeIt =
      'чтобы узнать, сможешь ли работать в IT-компании. За прохождение квиза даём мерч и участие в розыгрыше';

  static const String startQuiz = 'Начать';
  static const String back = 'Назад';

  static const String singleSelection = 'Выбери один вариант ответа:';
  static const String multiSelection = 'Выбери один или несколько вариантов ответа:';

  static const String nextQuestion = 'Далее';
  static const String skipQuestion = 'или пропустить вопрос';

  static const String successResultHeader1 = 'Поздравляем!\nТы ';
  static const String successResultHeader2 = 'настоящий';
  static const String successResultHeader3 = ' молодец!';
  static const String successResultDescription =
      'Ведь ты ответил правильно на все вопросы и заслужил печать.\nПопроси у HR билет на Live Coding и беги пробовать лимонад.';
  static const String failureResultHeader1 = 'Интересно ';
  static const String failureResultHeader2 = 'узнать';
  static const String failureResultHeader3 = ' больше о работе в IT?';
  static const String failureResultDescription =
      'Приходи на нашу летнюю школу и выбери свое направление.\nА теперь получи печать у HR и беги пробовать вкусный лимонад.';
  static const String resultAction = 'Повторить';

  const StringRes._();

  static String quizDescription(int questionsCount) => Intl.plural(
        questionsCount,
        one: 'Ответь на один вопрос, $quizDescriptionWhyTakeIt',
        few: 'Ответь на $questionsCount вопроса, $quizDescriptionWhyTakeIt',
        other: 'Ответь на $questionsCount вопросов, $quizDescriptionWhyTakeIt',
      );

  static String quizTotalState(int total) => ' из $total вопросов';
}
