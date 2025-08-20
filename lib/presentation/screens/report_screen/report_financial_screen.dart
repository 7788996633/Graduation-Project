import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart' as kisweb;

import '../../../data/services/report_services.dart';
import '../../../themes.dart';

class ReportFinancialScreen extends StatefulWidget {
  const ReportFinancialScreen({super.key});

  @override
  State<ReportFinancialScreen> createState() => _ReportFinancialScreenState();
}

class _ReportFinancialScreenState extends State<ReportFinancialScreen> {
  bool _loading = false;
  Map<String, dynamic>? _reportData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateAndOpenReport();
  }

  Future<void> _generateAndOpenReport() async {
    setState(() {
      _loading = true;
      _error = null;
      _reportData = null;
    });

    try {
      final data = await ReportService().reportFinancial();
      final pdfLink = data['link']?.toString();

      if (pdfLink != null && pdfLink.endsWith('.pdf')) {
        final url = prepareFullUrl(pdfLink);
        if (kIsWeb) {
          kisweb.launch(url);
        } else {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('لا يمكن فتح الرابط')),
            );
          }
        }
      }

      setState(() {
        _reportData = data;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  String prepareFullUrl(String value) {
    const String baseUrl = 'http://192.168.1.10/LawCompany/public/';
    if (value.startsWith('http')) {
      return value;
    } else {
      return '$baseUrl$value';
    }
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLink = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: 22),
          const SizedBox(width: 10),
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isLink
                ? GestureDetector(
              onTap: () async {
                if (value.isEmpty) return;
                final url = prepareFullUrl(value);
                if (kIsWeb) {
                  kisweb.launch(url);
                } else {
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('لا يمكن فتح الرابط')),
                    );
                  }
                }
              },
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.darkBlue,
                  decoration: TextDecoration.underline,
                  height: 1.3,
                ),
              ),
            )
                : Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard() {
    if (_reportData == null) return const SizedBox.shrink();

    return Card(
      elevation: 8,
      margin: const EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.insert_drive_file,
                size: 72,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'تفاصيل التقرير المالي',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const Divider(height: 30, thickness: 1.2),
            _buildInfoRow(
              icon: Icons.link,
              label: 'رابط التقرير',
              value: _reportData!['link'] ?? '',
              isLink: true,
            ),
            _buildInfoRow(
              icon: Icons.confirmation_num,
              label: 'رقم التقرير',
              value: _reportData!['report_id'].toString(),
            ),
            _buildInfoRow(
              icon: Icons.monetization_on,
              label: 'المبلغ الإجمالي المدفوع',
              value: _reportData!['summary_total_paid'].toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError() {
    if (_error == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        _error!,
        style: const TextStyle(color: Colors.red, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التقرير المالي'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_loading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            _buildReportCard(),
            _buildError(),
          ],
        ),
      ),
    );
  }
}
