import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/ui/screen/admin/admin_wm.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';

class AdminScreen extends ElementaryWidget<IAdminWidgetModel> {
  const AdminScreen({Key? key}) : super(createAdminWidgetModel, key: key);

  @override
  Widget build(IAdminWidgetModel wm) {
    return CustomScreen(
      child: EntityStateNotifierBuilder<List<Question>>(
        listenableEntityState: wm.questionsState,
        builder: (_, state) {
          if (state == null) return const SizedBox.shrink();

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.length + 1,
            itemBuilder: (context, index) {
              if (index == state.length) {
                return ElevatedButton(
                  onPressed: wm.createNewQuestion,
                  child: const Text('Создать вопрос'),
                );
              }
              final question = state[index];

              return _QuestionWidget(
                question: question,
                deleteQuestion: () => wm.deleteQuestion(question),
                editQuestion: () => wm.editQuestion(question),
              );
            },
          );
        },
      ),
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
