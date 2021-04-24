import 'package:devquiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:devquiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:devquiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:devquiz/result/result_page.dart';
import 'package:devquiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';
import 'challenge_controller.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  ChallengePage({Key? key, required this.questions, required this.title})
      : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
          duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
  }

  void onSelected(bool value) {
    if (value == true) {
      controller.matches++;
    }
    nextPage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BackButton(),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                    currentPage: value, length: widget.questions.length),
              )
            ],
          ),
        ),
      ),
      body: PageView(
          controller: pageController,
          //physics: NeverScrollableScrollPhysics(), impossibilita deslizar a tela para o lado, tornando possível somente pelo botão "pular"
          // onPageChanged: (p) {controller.currentPage = p + 1;},
          children: widget.questions
              .map((e) => QuizWidget(question: e, onSelected: onSelected))
              .toList()),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (value < widget.questions.length)
                          Expanded(
                              child: NextButtonWidget.white(
                                  label: "Pular", onTap: nextPage)),
                        if (value == widget.questions.length)
                          Expanded(
                              child: NextButtonWidget.green(
                                  label: "Confirmar",
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResultPage(
                                                  title: widget.title,
                                                  length:
                                                      widget.questions.length,
                                                  result: controller.matches,
                                                )));
                                  })),
                      ],
                    ))),
      ),
    );
  }
}
