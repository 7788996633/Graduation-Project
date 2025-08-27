import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/legal_news_bloc/legal_news_bloc.dart';
import '../../blocs/legal_news_bloc/legal_news_event.dart';
import '../../blocs/legal_news_bloc/legal_news_state.dart';
import '../../constant.dart';
import '../../data/models/legal_news_model.dart';
import '../../themes.dart';
import '../screens/legal_news_screen/legal_news_details_screen.dart';

class LegalNewsItem extends StatefulWidget {
  const LegalNewsItem({super.key, required this.legalNews});
  final LegalNewsModel legalNews;

  @override
  State<LegalNewsItem> createState() => _LegalNewsItemState();
}

class _LegalNewsItemState extends State<LegalNewsItem> {
  late bool isSaved;

  @override
  void initState() {
    super.initState();
    isSaved = widget.legalNews.isSaved ?? false;
  }

  String _formatDate(DateTime date) {
    // صيغة التاريخ والوقت: يوم/شهر/سنة - ساعة:دقيقة
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();

    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');

    return "$day/$month/$year - $hour:$minute";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => LegalNewsBloc(),
                child: LegalNewsDetailsScreen(legalNews: widget.legalNews),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // الصورة + العنوان + التاريخ
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/grad.jpg',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Legal News',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBlue,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(DateTime.parse(widget.legalNews.createdAt)),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (myRole != null && myRole.toLowerCase() == 'admin')
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<LegalNewsBloc>(context).add(
                            DeleteLegalNewsEvent(legalNewsId: widget.legalNews.id),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: AppColors.darkBlue,
                          size: 20,
                        ),
                        tooltip: 'Delete News',
                      ),
                  ],
                ),

                const SizedBox(height: 10),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  height: 1,
                ),
                const SizedBox(height: 12),

                // العنوان قبل الوصف
                Text(
                  widget.legalNews.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBlue,
                  ),
                ),
                const SizedBox(height: 8),

                // الوصف + أيقونة الحفظ بجانبه
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.legalNews.description.length > 100
                            ? '${widget.legalNews.description.substring(0, 100)}...'
                            : widget.legalNews.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    BlocConsumer<LegalNewsBloc, LegalNewsState>(
                      listener: (context, state) {
                        if (state is LegalNewsSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(state.successMsg),
                            ),
                          );
                        } else if (state is LegalNewsFail) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(state.errMsg),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            if (isSaved) {
                              BlocProvider.of<LegalNewsBloc>(context).add(
                                UnSaveLegalNewsEvent(
                                    legalNewsId: widget.legalNews.id),
                              );
                            } else {
                              BlocProvider.of<LegalNewsBloc>(context).add(
                                SaveLegalNewsEvent(
                                    legalNewsId: widget.legalNews.id),
                              );
                            }
                            setState(() {
                              isSaved = !isSaved;
                            });
                          },
                          icon: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? Colors.orange : AppColors.darkBlue,
                          ),
                          tooltip: isSaved ? 'UnSave' : 'Save',
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
