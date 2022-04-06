import 'package:flutter/material.dart';
import 'package:quiz/api/data/input_question.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/selection_question.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/util/iterable_extension.dart';
import 'package:quiz/ui/widgets/primary_button.dart';
import 'package:quiz/ui/widgets/secondary_button.dart';
import 'package:quiz/ui/widgets/selection_card.dart';

class QuestionPage extends StatefulWidget {
  final Question question;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  final ValueChanged<Object?> onResultUpdated;

  const QuestionPage({
    required this.question,
    required this.onNextPressed,
    required this.onSkipPressed,
    required this.onResultUpdated,
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  late bool containsResult;

  @override
  void initState() {
    super.initState();
    containsResult = widget.question.result != null;
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.text,
          style: FontsRes.h2Black,
        ),
        _QuestionHeader(question: question),
        const SizedBox(height: 32),
        if (question is SelectionQuestion)
          _SelectionQuestionSection(
            selectionQuestion: question,
            onItemPressed: (items) {
              widget.onResultUpdated(items);
              handleUpdate(items);
            },
          ),
        if (question is InputQuestion)
          _InputQuestionSection(
            inputQuestion: question,
            onInputUpdated: (str) {
              widget.onResultUpdated(str);
              handleUpdate(str);
            },
          ),
        const SizedBox(height: 32),
        AnimatedCrossFade(
          firstChild: PrimaryButton(text: StringRes.nextQuestion, onPressed: widget.onNextPressed),
          secondChild: IgnorePointer(
            child: Opacity(
              opacity: .4,
              child: PrimaryButton(text: StringRes.nextQuestion, onPressed: () {}),
            ),
          ),
          crossFadeState: containsResult ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: kThemeChangeDuration,
        ),
        AnimatedCrossFade(
          firstChild: Opacity(
            opacity: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: SecondaryButton(text: StringRes.skipQuestion, onPressed: () {}),
            ),
          ),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SecondaryButton(text: StringRes.skipQuestion, onPressed: widget.onSkipPressed),
          ),
          crossFadeState: containsResult || !question.canSkip
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: kThemeChangeDuration,
        ),
      ],
    );
  }

  void handleUpdate(Object? data) {
    containsResult = widget.question.result != null || data != null;
    setState(() {});
  }
}

class _InputQuestionSection extends StatelessWidget {
  final InputQuestion inputQuestion;
  final ValueChanged<String?> onInputUpdated;

  const _InputQuestionSection({
    required this.inputQuestion,
    required this.onInputUpdated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (str) => onInputUpdated(str.isEmpty ? null : str),
      style: FontsRes.text1Black,
      initialValue: inputQuestion.result,
      cursorColor: ColorRes.black,
      cursorWidth: 1,
      maxLines: 3,
      decoration: InputDecoration(
        hintText: inputQuestion.hint,
        hintStyle: FontsRes.text1Black32,
        hintMaxLines: 3,
        border: const UnderlineInputBorder(borderSide: BorderSide(color: ColorRes.black32)),
        focusedBorder: const UnderlineInputBorder(),
      ),
    );
  }
}

class _SelectionQuestionSection extends StatefulWidget {
  final SelectionQuestion selectionQuestion;
  final ValueChanged<List<SelectionItem>?> onItemPressed;

  const _SelectionQuestionSection({
    required this.selectionQuestion,
    required this.onItemPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<_SelectionQuestionSection> createState() => _SelectionQuestionSectionState();
}

class _SelectionQuestionSectionState extends State<_SelectionQuestionSection> {
  late final bool isMultiple;

  final _selectedValues = <SelectionItem>[];

  @override
  void initState() {
    super.initState();
    final question = widget.selectionQuestion;
    isMultiple = question.selectionType == SelectionType.multi;
    final res = question.result;
    if (res != null) _selectedValues.addAll(res);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.selectionQuestion.questions
          .map<Widget>(
            (e) => SelectionCard(
              text: e.text,
              onPressed: () => _onSelect(e),
              isMultiple: isMultiple,
              isSelected: _selectedValues.contains(e),
            ),
          )
          .separated(const SizedBox(height: 8))
          .toList(),
    );
  }

  void _onSelect(SelectionItem item) {
    final contains = _selectedValues.contains(item);
    if (!isMultiple) _selectedValues.clear();
    contains ? _selectedValues.remove(item) : _selectedValues.add(item);
    setState(() {});
    widget.onItemPressed(_selectedValues.isEmpty ? null : _selectedValues);
  }
}

class _QuestionHeader extends StatelessWidget {
  final Question question;

  const _QuestionHeader({required this.question, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final question = this.question;
    if (question is SelectionQuestion) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            question.selectionType.description,
            style: FontsRes.text1Black,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
