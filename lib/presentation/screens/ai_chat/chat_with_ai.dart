import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_text_field.dart';
import '../../../blocs/ai_chat_bloc/ai_chat_bloc.dart';

class ChatWithAi extends StatefulWidget {
  const ChatWithAi({super.key});

  @override
  State<ChatWithAi> createState() => _ChatWithAiState();
}

class _ChatWithAiState extends State<ChatWithAi> {
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getCurrentTheme()['BackGorund'],
      appBar: const CustomActionAppBar(
        title: "Chat With AI",
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocProvider(
          create: (_) => AiChatBloc(),
          child: BlocBuilder<AiChatBloc, AiChatState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 2,
                        colors: isLight.value
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
                        width: 2,
                        color: AppColors.white,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Ask whatever you want to AI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextFeild(
                          text: "Question...",
                          controller: _questionController,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              final question = _questionController.text.trim();
                              if (question.isNotEmpty) {
                                context
                                    .read<AiChatBloc>()
                                    .add(AskAi(question: question));
                              }
                            },
                            child: const Text(
                              "Generate",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔹 عرض النتائج حسب الحالة
                  Expanded(
                    child: Center(
                      child: () {
                        if (state is AiChatLoading) {
                          return const CircularProgressIndicator();
                        } else if (state is AiChatSuccess) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Q: ${state.question}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "A: ${state.answer}",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          );
                        } else if (state is AiChatFail) {
                          return Text(
                            "Error: ${state.errmsg}",
                            style: const TextStyle(color: Colors.red),
                          );
                        }
                        return const Text(
                          "Ask a question to start",
                          style: TextStyle(color: Colors.grey),
                        );
                      }(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
