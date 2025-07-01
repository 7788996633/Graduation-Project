import 'package:flutter/material.dart';

import '../../../constant.dart';

class AddHiringRequestScreen extends StatefulWidget {
  const AddHiringRequestScreen({super.key});

  @override
  State<AddHiringRequestScreen> createState() => _AddHiringRequestScreenState();
}

class _AddHiringRequestScreenState extends State<AddHiringRequestScreen> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;

  void _submitRequest() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hiring request submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      _jobTitleController.clear();
      _typeController.clear();
      _descriptionController.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: const Text("Create Hiring Request"),
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isSmallScreen ? double.infinity : 600,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _jobTitleController,
                        label: 'Job Title',
                        icon: Icons.work_outline,
                      ),
                      SizedBox(height: isSmallScreen ? 20 : 30),
                      _buildTextField(
                        controller: _typeController,
                        label: 'Type',
                        icon: Icons.category_outlined,
                      ),
                      SizedBox(height: isSmallScreen ? 20 : 30),
                      _buildTextField(
                        controller: _descriptionController,
                        label: 'Description',
                        icon: Icons.description_outlined,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 40),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitRequest,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor:
                            Colors.deepPurple.withOpacity(0.5),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFB8820E),
                                  Color(0xFF523A06)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding:
                              const EdgeInsets.symmetric(vertical: 16),
                              alignment: Alignment.center,
                              child: const Text(
                                'Submit Request',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
