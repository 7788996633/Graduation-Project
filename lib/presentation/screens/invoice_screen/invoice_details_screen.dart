import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/invoices_bloc/invoices_bloc.dart';
import '../../../blocs/issue_bloc/issues_bloc.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import '../../../data/models/invoice_model.dart';
import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../invoice_screen/update_invoice_screen.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  final InvoiceModel invoiceModel;

  const InvoiceDetailsScreen({super.key, required this.invoiceModel});

  Widget _buildInfoRow(
      IconData icon,
      String label,
      String value,
      double iconSize,
      double fontSize,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.darkBlue, size: iconSize),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(text: '$label: ', style: const TextStyle(color: Colors.black87)),
                  TextSpan(text: value, style: const TextStyle(color: AppColors.darkBlue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => IssuesBloc()..add(IssueShowbyId(id: invoiceModel.issueId))),
        BlocProvider(create: (_) => UserBloc()..add(GetUserById(userId: invoiceModel.userId))),
      ],
      child: Scaffold(
        backgroundColor: Colors.deepPurple.shade50,
        appBar: CustomActionAppBar(title: 'Invoice Details'),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              if (userState is UserLoadedSuccessfully) {
                final user = userState.userModel;

                return BlocBuilder<IssuesBloc, IssuesState>(
                  builder: (context, issueState) {
                    if (issueState is IssuesLoadedSuccessFully) {
                      final issue = issueState.issue;

                      return SingleChildScrollView(
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          elevation: 12,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.receipt_long, size: 44, color: AppColors.darkBlue),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Invoice #${invoiceModel.id}',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                _buildInfoRow(Icons.attach_money, 'Amount',
                                    invoiceModel.amount.toString(), 22, 16),
                                const Divider(),
                                _buildInfoRow(Icons.info, 'Status', invoiceModel.status, 22, 16),

                                const SizedBox(height: 30),
                                const Text('User Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                _buildInfoRow(Icons.person, 'Name', user.name, 22, 16),
                                _buildInfoRow(Icons.email, 'Email', user.email, 22, 16),
                                _buildInfoRow(Icons.badge, 'Role', user.roleName ?? 'N/A', 22, 16),

                                const SizedBox(height: 30),
                                const Divider(),
                                Center(
                                  child: Column(
                                    children: [
                                      Icon(Icons.gavel_rounded, size: 44, color: AppColors.darkBlue),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Issue #${issue.id}',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                _buildInfoRow(Icons.title, 'Title', issue.title, 22, 16),
                                _buildInfoRow(Icons.confirmation_number, 'Issue Number', issue.issueNumber, 22, 16),
                             //   _buildInfoRow(Icons.category, 'Category', issue.category, 22, 16),
                                _buildInfoRow(Icons.person, 'Opponent', issue.opponentName, 22, 16),
                                _buildInfoRow(Icons.account_balance, 'Court', issue.courtName, 22, 16),
                                _buildInfoRow(Icons.payment, 'Payments', issue.numberOfPayments.toString(), 22, 16),
                                _buildInfoRow(Icons.attach_money, 'Total Cost', issue.totalCost, 22, 16),
                                _buildInfoRow(Icons.money_off, 'Amount Paid', issue.amountPaid, 22, 16),
                                _buildInfoRow(Icons.info_outline, 'Status', issue.status, 22, 16),
                                _buildInfoRow(Icons.priority_high, 'Priority', issue.priority, 22, 16),
                                _buildInfoRow(Icons.date_range, 'Start Date', issue.startDate, 22, 16),
                                _buildInfoRow(Icons.date_range, 'End Date', issue.endDate, 22, 16),
                                const SizedBox(height: 30),
                                _buildEditButton(context, invoiceModel),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (issueState is IssuesFail) {
                      return Center(child: Text('Failed to load issue: ${issueState.errmsg}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              } else if (userState is UserFail) {
                return Center(child: Text('Failed to load user: ${userState.errmsg}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context, InvoiceModel invoice) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          final result = await Navigator.push<InvoiceModel>(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => InvoiceBloc(),
                child: UpdateInvoiceScreen(invoice: invoice),
              ),
            ),
          );

          if (result != null) {
            // يمكن هنا إضافة إعادة تحميل البيانات إذا لزم.
          }
        },
        icon: const Icon(Icons.edit, size: 22),
        label: const Text('Edit Invoice', style: TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
        ),
      ),
    );
  }
}
