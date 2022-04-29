import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/edit_question_dialog/edit_question_wm.dart';
import 'package:quiz/ui/util/iterable_extension.dart';

class EditQuestionDialog extends ElementaryWidget<IEditQuestionWidgetModel> {
  final Question? question;

  const EditQuestionDialog({
    this.question,
    Key? key,
  }) : super(createEditQuestionWidgetModel, key: key);

  @override
  Widget build(IEditQuestionWidgetModel wm) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: wm.questionController,
              decoration: const InputDecoration(
                label: Text('Вопрос'),
                hintText: 'Введите вопрос',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              validator: wm.validateQuestion,
            ),
            _CheckBoxField(
              state: wm.isHidden,
              onPressed: wm.toggleHiding,
              text: 'Скрыть вопрос',
            ),
            _CheckBoxField(
              state: wm.canSkip,
              onPressed: wm.toggleRequired,
              text: 'Есть возможность пропустить вопрос',
            ),
            StateNotifierBuilder<QuestionType>(
              listenableState: wm.questionType,
              builder: (context, type) {
                return Column(
                  children: [
                    _QuestionTypeField(
                      type: type,
                      onChanged: wm.changeQuestionType,
                    ),
                    const SizedBox(height: 8),
                    if (type == QuestionType.input) _InputQuestionFields(wm: wm),
                    if (type == QuestionType.selection) _SelectionQuestionFields(wm: wm),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: wm.saveQuestion,
                    child: const Text('Сохранить'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: wm.cancelEditing,
                    child: const Text('Отмена'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionTypeField extends StatelessWidget {
  final QuestionType? type;
  final ValueChanged<QuestionType?> onChanged;

  const _QuestionTypeField({
    required this.onChanged,
    this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<QuestionType>(
      decoration: const InputDecoration(
        label: Text('Тип вопроса'),
      ),
      items: [
        DropdownMenuItem(
          value: QuestionType.input,
          child: Text(QuestionType.input.name),
        ),
        DropdownMenuItem(
          value: QuestionType.selection,
          child: Text(QuestionType.selection.name),
        ),
      ],
      value: type,
      onChanged: onChanged,
    );
  }
}

class _CheckBoxField extends StatelessWidget {
  final ListenableState<bool> state;
  final VoidCallback onPressed;
  final String text;

  const _CheckBoxField({
    required this.state,
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<bool>(
      listenableState: state,
      builder: (context, value) => CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        value: value ?? false,
        onChanged: (_) => onPressed(),
        title: Text(text),
      ),
    );
  }
}

class _InputQuestionFields extends StatelessWidget {
  final IEditQuestionWidgetModel wm;

  const _InputQuestionFields({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: wm.hintController,
          decoration: const InputDecoration(
            label: Text('Хинт'),
          ),
          validator: wm.validateHint,
        ),
        _CheckBoxField(
          state: wm.isPersonalData,
          text: 'Персональные данные',
          onPressed: wm.togglePersonalData,
        ),
      ],
    );
  }
}

class _SelectionQuestionFields extends StatelessWidget {
  final IEditQuestionWidgetModel wm;

  const _SelectionQuestionFields({
    required this.wm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StateNotifierBuilder<List<Answer>>(
          listenableState: wm.answersList,
          builder: (context, state) {
            return Column(
              children: [
                ...?state
                    ?.map((e) => _Answer(
                          answer: e,
                          removeAnswer: () => wm.removeAnswer(e),
                        ))
                    .toList(),
                ElevatedButton(
                  onPressed: wm.addNewAnswer,
                  child: const Text('Добавить ответ'),
                ),
              ].separated(const SizedBox(height: 8)).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _Answer extends StatelessWidget {
  final Answer answer;
  final VoidCallback removeAnswer;

  const _Answer({
    required this.answer,
    required this.removeAnswer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: answer.textController,
                    decoration: const InputDecoration(
                      label: Text('Ответ'),
                    ),
                  ),
                  _CheckBoxField(
                    state: answer.isCorrect,
                    onPressed: answer.toggleCorrect,
                    text: 'Ответ верный',
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: removeAnswer,
            ),
          ],
        ),
      ),
    );
  }
}
