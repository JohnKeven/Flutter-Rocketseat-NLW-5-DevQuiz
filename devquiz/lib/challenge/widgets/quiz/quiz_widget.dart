import 'package:devquiz/challenge/widgets/answer/answer_widget.dart';
import 'package:devquiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';

class QuizWidget extends StatelessWidget {
  const QuizWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Text(title, style: AppTextStyles.heading),
        SizedBox(height: 24),
        AnswerWidget(title: "Kit de desenvolvimento de interface de usuário"),
        AnswerWidget(
            isRight: true,
            isSelected: true,
            title:
                "Possibilita a criação de aplicativos compilados nativamente"),
        AnswerWidget(title: "Acho que é uma marca de café do Himalaia"),
        AnswerWidget(
            title: "Possibilita a criação destops que são muito incríveis"),
      ],
    ));
  }
}
