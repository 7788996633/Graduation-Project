import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http; // استيراد مكتبة http لتحميل الملفات
import '../../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/models/lawyer_model.dart';
import '../../../pdf_viewer_page.dart';
import 'edit_lawyer_profile_screen.dart';

class LawyerProfileScreen extends StatefulWidget {
  const LawyerProfileScreen({super.key});

  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  late LawyerModel lawyerProfile;
  final Color customColor = const Color(0xFF472A0C);
  final Color valueColor = const Color(0xFF0F6829);

  @override
  void initState() {
    super.initState();

    context.read<LawyerProfileBloc>().add(ShowLawyerProfileEvent());
  }

  Widget buildInfoTile(IconData icon, String label, String value,
      {Widget? customWidget}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: customColor),
          const SizedBox(width: 10),
          Expanded(
            child: customWidget ??
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                          text: "$label: ",
                          style: TextStyle(color: customColor)),
                      TextSpan(
                          text: value, style: TextStyle(color: valueColor)),
                    ],
                  ),
                ),
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context, String certificateUrl) async {
    final baseUrl = myUrl;
    final fullUrl = Uri.encodeFull(baseUrl + certificateUrl);

    final response = await http.get(Uri.parse(fullUrl));

    if (response.statusCode == 200) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PDFViewerPage(pdfContent: response.body),
        ),
      );
    } else {
      print("Failed to load PDF: ${response.statusCode}");
    }
  }

  Widget buildProfileUI(LawyerModel lawyer, BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                  radius: 45, backgroundImage: NetworkImage(lawyer.image)),
              const SizedBox(height: 10),
              Text("Lawyer ${lawyer.name}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 20),
              buildInfoTile(Icons.person, "Name", lawyer.name),
              buildInfoTile(Icons.email, "Email", lawyer.email),
              buildInfoTile(Icons.location_on, "Address", lawyer.address),
              buildInfoTile(Icons.phone, "Phone", lawyer.phone),
              buildInfoTile(Icons.cake, "Age", lawyer.age.toString()),
              buildInfoTile(
                  Icons.gavel, "Specialization", lawyer.specialization),
              buildInfoTile(
                  Icons.badge, "License Number", lawyer.licenseNumber),
              buildInfoTile(Icons.work, "Experience Years",
                  lawyer.experienceYears.toString()),
              buildInfoTile(
                Icons.work,
                "Certificate",
                lawyer.certificate,
                customWidget: ElevatedButton(
                  onPressed: () => openPDF(context, lawyer.certificate),
                  child: const Text("View Certificate",
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => LawyerProfileBloc(),
                    child: EditLawyerProfileScreen(lawyer: lawyerProfile),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
        backgroundColor: customColor,
        title: const Text("Lawyer Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white)),
        centerTitle: true,
        elevation: 4,
      ),
      body: BlocBuilder<LawyerProfileBloc, LawyerProfileState>(
        builder: (context, state) {
          if (state is LawyerProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LawyerProfileLoadedSuccessfully) {
            lawyerProfile = state.lawyerModel;
            return buildProfileUI(state.lawyerModel, context);
          } else if (state is LawyerProfileFail) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("There is an error:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(state.errmsg,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.center),
                ],
              ),
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}
