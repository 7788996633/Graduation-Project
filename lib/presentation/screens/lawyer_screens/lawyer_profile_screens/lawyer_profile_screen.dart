import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import '../../../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../../../constant.dart';
import '../../../../data/models/lawyer_model.dart';
import '../../../pdf_viewer_page.dart';
import '../../../widgets/custom_appbar_add.dart';
import 'edit_lawyer_profile_screen.dart';

class LawyerProfileScreen extends StatefulWidget {
  const LawyerProfileScreen({super.key, required this.lawyerModel});
  final LawyerModel lawyerModel;
  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
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

  Widget buildProfileUI(BuildContext context) {
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
                radius: 45,
                backgroundImage: NetworkImage(
                  '${widget.lawyerModel.image}?v=${DateTime.now().millisecondsSinceEpoch}',
                ),
              ),
              const SizedBox(height: 10),
              Text("Lawyer ${widget.lawyerModel.name}",
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 20),
              buildInfoTile(Icons.person, "Name", widget.lawyerModel.name),
              buildInfoTile(Icons.email, "Email", widget.lawyerModel.email),
              buildInfoTile(
                  Icons.location_on, "Address", widget.lawyerModel.address),
              buildInfoTile(Icons.phone, "Phone", widget.lawyerModel.phone),
              buildInfoTile(
                  Icons.cake, "Age", widget.lawyerModel.age.toString()),
              buildInfoTile(Icons.gavel, "Specialization",
                  widget.lawyerModel.specialization),
              buildInfoTile(Icons.badge, "License Number",
                  widget.lawyerModel.licenseNumber),
              buildInfoTile(Icons.work, "Experience Years",
                  widget.lawyerModel.experienceYears.toString()),
              buildInfoTile(
                Icons.work,
                "Certificate",
                widget.lawyerModel.certificate,
                customWidget: ElevatedButton(
                  onPressed: () =>
                      openPDF(context, widget.lawyerModel.certificate),
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
        appBar: CustomActionAppBar(
          title: 'Lawyer Profile',
          secondaryIcon: Icons.edit,
          secondaryTooltip: 'Edit Lawyer Profile',
          onSecondaryPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => LawyerProfileBloc(),
                  child: EditLawyerProfileScreen(lawyer: widget.lawyerModel),
                ),
              ),
            );
          },
        ),
        body: buildProfileUI(context));
  }
}
