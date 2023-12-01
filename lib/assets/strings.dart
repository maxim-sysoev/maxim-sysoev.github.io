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

  static const String subscribeToTelegram1 = 'Подписывайся на наш Telegram-канал';
  static const String subscribeToTelegram2 =
      ', чтобы не пропускать новости об IT и поучаствовать в розыгрыше.';

  static const String successResultHeader = 'Ты круто разбираешься в IT!';
  static const String successResultDescription =
      'Будем ждать тебя на мероприятиях и рады видеть среди Сёрферов. ';
  static const String middleResultHeader = 'Ты неплохо разбираешься в IT-командах!';
  static const String middleResultDescription =
      'На мероприятиях рассказываем о стажировках и вакансиях подробнее, ждём тебя ещё. ';
  static const String failureResultHeader = 'Ты только начинаешь познавать мир IT, но всё впереди!';
  static const String failureResultDescription =
      'Приходи пообщаться с Surf — мы всё расскажем и покажем. ';
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
