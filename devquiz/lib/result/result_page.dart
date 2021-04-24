import 'package:devquiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:devquiz/core/app_images.dart';
import 'package:devquiz/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int length;
  final int result;
  const ResultPage(
      {Key? key,
      required this.title,
      required this.length,
      required this.result})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.trophy),
            Column(
              children: [
                Text("Parabéns!", style: AppTextStyles.heading40),
                SizedBox(height: 16),
                Text.rich(
                    TextSpan(
                        text: "Você concluiu",
                        style: AppTextStyles.body,
                        children: [
                          TextSpan(
                              text: "\n $title", style: AppTextStyles.bodyBold),
                          TextSpan(
                              text: "\n com $result de $length acertos",
                              style: AppTextStyles.body)
                        ]),
                    textAlign: TextAlign.center),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 68),
                      child: NextButtonWidget.purple(
                          label: "Compartilhar",
                          onTap: () {
                            Share.share(
                                "DevQuiza NLW 5 - Flutter 100% de aproveitamento! Baixe o projeto inteiro em: https://github.com/JohnKeven/Rocketseat-NLW-5-Flutter-DevQuiz");
                          }),
                    )),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 68),
                      child: NextButtonWidget.white(
                          label: "Voltar ao Inicio",
                          onTap: () {
                            Navigator.pop(context);
                          }),
                    )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
