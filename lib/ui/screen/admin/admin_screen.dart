import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/result/result.dart';
import 'package:quiz/assets/strings.dart';
import 'package:quiz/ui/screen/admin/admin_wm.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/secondary_button.dart';

class AdminScreen extends ElementaryWidget<IAdminWidgetModel> {
  const AdminScreen({Key? key}) : super(createAdminWidgetModel, key: key);

  @override
  Widget build(IAdminWidgetModel wm) {
    return CustomScreen(
      child: Column(
        children: [
          SecondaryButton(withArrow: true, text: StringRes.back, onPressed: wm.onBack),
          TabBar(
            controller: wm.tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(text: 'Questions'),
              Tab(text: 'Results'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: wm.tabController,
              children: [
                _Questions(
                  questionsState: wm.questionsState,
                  createNewQuestion: wm.createNewQuestion,
                  deleteQuestion: wm.deleteQuestion,
                  editQuestion: wm.editQuestion,
                ),
                _Responses(
                  resultsState: wm.resultsState,
                  exportResults: wm.exportResponses,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Questions extends StatelessWidget {
  final ListenableState<EntityState<List<Question>>> questionsState;
  final VoidCallback createNewQuestion;
  final ValueChanged<Question> deleteQuestion;
  final ValueChanged<Question> editQuestion;

  const _Questions({
    required this.questionsState,
    required this.createNewQuestion,
    required this.deleteQuestion,
    required this.editQuestion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<List<Question>>(
      listenableEntityState: questionsState,
      builder: (_, state) {
        if (state == null) return const SizedBox.shrink();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.length + 1,
          itemBuilder: (context, index) {
            if (index == state.length) {
              return ElevatedButton(
                onPressed: createNewQuestion,
                child: const Text('Создать вопрос'),
              );
            }
            final question = state[index];

            return _QuestionWidget(
              question: question,
              deleteQuestion: () => deleteQuestion(question),
              editQuestion: () => editQuestion(question),
            );
          },
        );
      },
    );
  }
}

class _QuestionWidget extends StatelessWidget {
  final Question question;
  final VoidCallback deleteQuestion;
  final VoidCallback editQuestion;

  const _QuestionWidget({
    required this.question,
    required this.deleteQuestion,
    required this.editQuestion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question.text),
                if (question.hide) ...[
                  const SizedBox(height: 8),
                  const Text('Hidden'),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: editQuestion,
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: deleteQuestion,
          ),
        ],
      ),
    );
  }
}

class _Responses extends StatelessWidget {
  final ListenableState<EntityState<List<QuizResult>>> resultsState;
  final ValueChanged<List<QuizResult>> exportResults;

  const _Responses({
    required this.resultsState,
    required this.exportResults,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EntityStateNotifierBuilder<List<QuizResult>>(
      listenableEntityState: resultsState,
      builder: (context, state) {
        if (state == null || state.isEmpty) return const SizedBox.shrink();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => (index == 0)
              ? ElevatedButton(
                  child: const Text('save'),
                  onPressed: () => exportResults(state),
                )
              : _QuizResultWidget(
                  result: state[index - 1],
                ),
          itemCount: state.length + 1,
        );
      },
    );
  }
}

class _QuizResultWidget extends StatelessWidget {
  final QuizResult result;

  const _QuizResultWidget({
    required this.result,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(),
      ),
      child: Row(
        children: [
          const Text('Персональные данные: '),
          const SizedBox(width: 8),
          Expanded(child: Text(result.lastName ?? 'unknown user')),
        ],
      ),
    );
  }
}
