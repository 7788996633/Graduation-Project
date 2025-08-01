import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/services/report_services.dart';
import '../../../themes.dart';

class ReportHiringScreen extends StatefulWidget {
  const ReportHiringScreen({super.key});

  @override
  State<ReportHiringScreen> createState() => _ReportHiringScreenState();
}

class _ReportHiringScreenState extends State<ReportHiringScreen> {
  bool _loading = false;
  Map<String, dynamic>? _reportData;
  String? _error;

  Future<void> _generateReport() async {
    setState(() {
      _loading = true;
      _error = null;
      _reportData = null;
    });

    try {
      final data = await ReportService().reportHiring();
      setState(() {
        _reportData = data;
      });
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ أثناء جلب البيانات: $e';
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
              color:AppColors.darkBlue,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: isLink
                ? GestureDetector(
              onTap: () async {
                if (value.isEmpty) return;
                final uri = Uri.parse(prepareFullUrl(value));
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('لا يمكن فتح الرابط')),
                  );
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
                Icons.bar_chart,
                size: 72,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'تفاصيل تقرير الوظائف والمتقدمين',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkBlue,
              ),
            ),
            const Divider(height: 30, thickness: 1.2),
            ..._reportData!.entries.map((entry) {
              final isLink = entry.key.toLowerCase().contains('link');
              return _buildInfoRow(
                icon: isLink ? Icons.link : Icons.info,
                label: entry.key,
                value: entry.value.toString(),
                isLink: isLink,
              );
            }).toList(),
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
      appBar: AppBar(title: const Text('تقرير الوظائف والمتقدمين')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _generateReport,
              icon: const Icon(Icons.insert_chart),
              label: _loading
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text('توليد تقرير الوظائف'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            _buildReportCard(),
            _buildError(),
            if (!_loading && _reportData == null && _error == null)
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(
                  child: Text(
                    'لم يتم توليد التقرير بعد',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
