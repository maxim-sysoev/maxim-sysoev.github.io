import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:quiz/api/data/question.dart';
import 'package:quiz/assets/assets.dart';
import 'package:quiz/ui/screen/question/question_page.dart';
import 'package:quiz/ui/screen/question/question_wm.dart';
import 'package:quiz/ui/widgets/animated_fade_out_in.dart';
import 'package:quiz/ui/widgets/custom_screen.dart';
import 'package:quiz/ui/widgets/secondary_button.dart';

class QuestionScreen extends ElementaryWidget<IQuestionWidgetModel> {
  QuestionScreen(Iterable<Question> questions, {Key? key})
      : super(
          (ctx) => createQuestionWidgetModel(questions: questions, context: ctx),
          key: key,
        );

  @override
  Widget build(IQuestionWidgetModel wm) {
    return WillPopScope(
      onWillPop: () {
        wm.onBack();
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: wm.onScreen,
        child: CustomScreen(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return false;
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SecondaryButton(withArrow: true, text: StringRes.back, onPressed: wm.onBack),
                      const SizedBox(height: 32),
                      StateNotifierBuilder<int>(
                        listenableState: wm.pageState,
                        builder: (_, currPage) => _PageState(
                          currentPage: currPage!,
                          totalPages: wm.totalPages,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StateNotifierBuilder<List<Question>>(
                    listenableState: wm.questionsState,
                    builder: (_, questions) => PageView.builder(
                      controller: wm.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) {
                        final question = questions![i];
                        return ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            QuestionPage(
                              question: question,
                              onNextPressed: wm.nextQuestion,
                              onSkipPressed: wm.skipQuestion,
                              onResultUpdated: wm.onResultUpdated,
                              onFirstnameUpdated: wm.onFirstnameUpdated,
                              onLastNameUpdated: wm.onLastNameUpdated,
                              onEmailUpdated: wm.onEmailUpdated,
                              onPhoneOrTelegramUpdated: wm.onPhoneOrTelegramUpdated,
                              onWorkOrStudyUpdated: wm.onWorkOrStudyUpdated,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PageState extends StatefulWidget {
  final int totalPages;
  final int currentPage;

  const _PageState({
    required this.totalPages,
    required this.currentPage,
    Key? key,
  }) : super(key: key);

  @override
  _PageStateState createState() => _PageStateState();
}

class _PageStateState extends State<_PageState> {
  late String _currPage;

  @override
  void initState() {
    super.initState();
    _currPage = '${widget.currentPage}';
  }

  @override
  void didUpdateWidget(covariant _PageState oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      _currPage = '${widget.currentPage}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.currentPage <= widget.totalPages,
      child: Row(
        children: [
          AnimatedFadeOutIn<String>(
            builder: (str) => Text(str, style: FontsRes.text1Black40),
            data: _currPage,
            duration: kThemeChangeDuration,
          ),
          Text(
            StringRes.quizTotalState(widget.totalPages),
            style: FontsRes.text1Black40,
          ),
        ],
      ),
    );
  }
}
