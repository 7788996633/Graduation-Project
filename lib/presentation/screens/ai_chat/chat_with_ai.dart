import 'package:flutter/material.dart';
import 'package:graduation/presentation/widgets/custom_appbar_add.dart';
import 'package:graduation/presentation/widgets/custom_text_field.dart';
import 'package:graduation/themes.dart';

class ChatWithAi extends StatefulWidget {
  const ChatWithAi({super.key});

  @override
  State<ChatWithAi> createState() => _ChatWithAiState();
}

class _ChatWithAiState extends State<ChatWithAi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: CustomActionAppBar(
        title: "Chat With AI",
      ),
      body: Container(
        padding: EdgeInsets.all(
          20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     gradient: RadialGradient(
            //       center: Alignment.center,
            //       radius: 9,
            //       colors: [
            //         AppColors.darkBlue,
            //         AppColors.softGray,
            //         AppColors.white,
            //       ],
            //     ),
            //     border: Border.all(
            //       strokeAlign: 2,
            //       width: 3,
            //       color: AppColors.white,
            //     ),
            //     borderRadius: BorderRadius.circular(
            //       8,
            //     ),
            //   ),
            //   child: Text(
            //     textAlign: TextAlign.center,
            //     "Ask whatever you want to AI",
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 2,
                  colors: isLight
                      ? [
                          AppColors.darkBlue,
                          AppColors.softGray,
                          AppColors.white,
                        ]
                      : [
                          Colors.black,
                          AppColors.softGray,
                          AppColors.white,
                        ],
                ),
                border: Border.all(
                  strokeAlign: 2,
                  width: 3,
                  color: AppColors.white,
                ),
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Ask whatever you want to AI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "Enter your question here",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFeild(
                    text: "Question...",
                    controller: TextEditingController(),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Generate",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
