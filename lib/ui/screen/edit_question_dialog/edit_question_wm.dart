import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/ui/screen/edit_question_dialog/edit_question_dialog.dart';
import 'package:quiz/ui/screen/edit_question_dialog/edit_question_model.dart';

enum QuestionType {
  input,
  selection,
}

class Answer {
  final TextEditingController textController;
  final StateNotifier<bool> isCorrect;

  Answer({
    String? text,
    bool? isCorrect,
  })  : textController = TextEditingController(text: text ?? ''),
        isCorrect = StateNotifier<bool>(initValue: isCorrect ?? false);

  void toggleCorrect() {
    isCorrect.accept(!(isCorrect.value ?? false));
  }
}

EditQuestionWidgetModel createEditQuestionWidgetModel(BuildContext context) {
  return EditQuestionWidgetModel(Navigator.of(context));
}

class EditQuestionWidgetModel extends WidgetModel<EditQuestionDialog, EditQuestionModel>
    implements IEditQuestionWidgetModel {
  @override
  final questionController = TextEditingController();
  @override
  final hintController = TextEditingController();

  final NavigatorState _navigator;

  final _questionType = StateNotifier<QuestionType>();
  final _answersList = StateNotifier<List<Answer>>(initValue: []);
  final _isHidden = StateNotifier<bool>(initValue: false);
  final _isPersonalData = StateNotifier<bool>(initValue: false);
  final _canSkip = StateNotifier<bool>(initValue: true);

  @override
  ListenableState<List<Answer>> get answersList => _answersList;

  @override
  ListenableState<bool> get isHidden => _isHidden;

  @override
  ListenableState<bool> get isPersonalData => _isPersonalData;

  @override
  ListenableState<bool> get canSkip => _canSkip;

  @override
  ListenableState<QuestionType> get questionType => _questionType;

  EditQuestionWidgetModel(this._navigator) : super(EditQuestionModel());

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    final question = widget.question;
    if (question != null) {
      questionController.text = question.text;
      _isHidden.accept(question.hide);
      _canSkip.accept(!question.canSkip);

      if (question is SelectionQuestion) {
        _questionType.accept(QuestionType.selection);
        final answers = question.questions
            .map((e) => Answer(
                  text: e.text,
                  isCorrect: e.isCorrect,
                ))
            .toList();
        _answersList.accept(answers);
      }

      if (question is InputQuestion) {
        _questionType.accept(QuestionType.input);
        _isPersonalData.accept(question.isPersonalInfo);
        hintController.text = question.hint;
      }
    }
  }

  @override
  void togglePersonalData() {
    _isPersonalData.accept(!(_isPersonalData.value ?? false));
  }

  @override
  void changeQuestionType(QuestionType? type) {
    if (type == null) return;
    _questionType.accept(type);
  }

  @override
  void addNewAnswer() {
    _answersList.accept((_answersList.value ?? []).toList()..add(Answer()));
  }

  @override
  void removeAnswer(Answer answer) {
    _answersList.accept(_answersList.value!.toList()..remove(answer));
  }

  @override
  void toggleHiding() {
    _isHidden.accept(!(_isHidden.value ?? false));
  }

  @override
  void toggleRequired() {
    _canSkip.accept(!(_canSkip.value ?? false));
  }

  @override
  void saveQuestion() {
    final type = questionType.value;
    if (type == null) return;

    final question = QuestionInfo(
      question: questionController.text,
      hint: hintController.text,
      questionType: type,
      canSkip: canSkip.value ?? true,
      isHidden: isHidden.value ?? false,
      isPersonalData: isPersonalData.value ?? false,
      answersList: answersList.value
              ?.map((e) => AnswerInfo(answer: e.textController.text, isCorrect: e.isCorrect.value!))
              .toList() ??
          [],
    );

    final questionId = widget.question?.id;
    Future<bool> result;
    if (questionId != null) {
      result = model.updateQuestion(questionId, question);
    } else {
      result = model.createQuestion(question);
    }

    result.then((value) {
      if (value) _navigator.pop();
    });
  }

  @override
  void cancelEditing() {
    _navigator.pop();
  }

  @override
  String? validateHint(String? value) {
    if (value?.isEmpty ?? true) return 'Обязательное поле';
    return null;
  }

  @override
  String? validateQuestion(String? value) {
    if (value?.isEmpty ?? true) return 'Обязательное поле';
    return null;
  }
}

abstract class IEditQuestionWidgetModel extends IWidgetModel {
  TextEditingController get questionController;

  ListenableState<QuestionType> get questionType;

  ListenableState<bool> get canSkip;

  ListenableState<bool> get isHidden;

  // ------ Input question fields -----------
  ListenableState<bool> get isPersonalData;

  TextEditingController get hintController;
  // ----------------------------------------

  // ------ Selectable question fields ------
  ListenableState<List<Answer>> get answersList;
  // ----------------------------------------

  String? validateQuestion(String? value);

  String? validateHint(String? value);

  void changeQuestionType(QuestionType? type);

  void toggleRequired();

  void toggleHiding();

  void togglePersonalData();

  void addNewAnswer();

  void removeAnswer(Answer answer);

  void saveQuestion();

  void cancelEditing();
}
