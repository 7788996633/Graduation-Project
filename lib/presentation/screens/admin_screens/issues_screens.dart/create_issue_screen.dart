// create_issue_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/blocs/user_bloc/user_bloc.dart';
import '../../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../widgets/clients_list.dart';
import '../../../widgets/custom_text_field.dart';

class CreateIssueScreen extends StatefulWidget {
  const CreateIssueScreen({super.key});

  @override
  State<CreateIssueScreen> createState() => _CreateIssueScreenState();
}

class _CreateIssueScreenState extends State<CreateIssueScreen> {
  final GlobalKey<FormState> myKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController issuenumberController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController courtnameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController startdateController = TextEditingController();
  final TextEditingController enddateController = TextEditingController();
  final TextEditingController totalcostController = TextEditingController();
  final TextEditingController numberofpaymentsController =
      TextEditingController();
  final TextEditingController opponentnameController = TextEditingController();

  int? selectedUserId;

  @override
  void dispose() {
    titleController.dispose();
    issuenumberController.dispose();
    categoryController.dispose();
    courtnameController.dispose();
    statusController.dispose();
    priorityController.dispose();
    startdateController.dispose();
    enddateController.dispose();
    totalcostController.dispose();
    numberofpaymentsController.dispose();
    opponentnameController.dispose();

    super.dispose();
  }

  String? validateTextField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  final Color mainColor = const Color(0xFF1E9AD8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("➕ Create Issue"),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: myKey,
          child: ListView(
            children: [
              CustomTextFeild(
                text: "title",
                controller: titleController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.title,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "issuenumber",
                controller: issuenumberController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.numbers,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "category",
                controller: categoryController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.category,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "court name",
                controller: courtnameController,
                validator: validateTextField,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 20),
              CustomTextFeild(
                text: "status",
                controller: statusController,
                validator: validateTextField,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "priority",
                controller: priorityController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.numbers,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "start date",
                controller: startdateController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.category,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "end date",
                controller: enddateController,
                validator: validateTextField,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 20),
              CustomTextFeild(
                text: "total cost",
                controller: totalcostController,
                validator: validateTextField,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "number of payments",
                controller: numberofpaymentsController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.numbers,
              ),
              const SizedBox(height: 12),
              CustomTextFeild(
                text: "opponent name",
                controller: opponentnameController,
                validator: validateTextField,
                color: Colors.grey.shade300,
                icon: Icons.category,
              ),
              const SizedBox(height: 20),

              // إضافة اختيار العميل
              const Text(
                "Select a client:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              BlocProvider(
                create: (context) => UserBloc(),
                child: ClientsList(
                  onUserSelected: (userId) {
                    setState(
                      () {
                        selectedUserId = userId;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              BlocConsumer<IssuesBloc, IssuesState>(
                listener: (context, state) {
                  if (state is IssuesSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.successmsg,
                          style: const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else if (state is IssuesFail) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errmsg,
                          style: const TextStyle(fontSize: 16),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (BuildContext context, IssuesState state) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      if (myKey.currentState!.validate()) {
                        if (selectedUserId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a client."),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        BlocProvider.of<IssuesBloc>(context).add(IssueAdd(
                            amoountPaid:
                                int.parse(numberofpaymentsController.text),
                            description: titleController.text,
                            userId: selectedUserId!,
                            title: titleController.text,
                            issueNumber: issuenumberController.text,
                            category: categoryController.text,
                            courtName: courtnameController.text,
                            status: statusController.text,
                            priority: priorityController.text,
                            startDate: startdateController.text,
                            endDate: enddateController.text,
                            totalCost: totalcostController.text,
                            numberOfPayments:
                                int.parse(numberofpaymentsController.text),
                            opponentName: opponentnameController.text));
                      }
                    },
                    icon: const Icon(Icons.person_add, color: Colors.black87),
                    label: const Text(
                      "Create",
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
