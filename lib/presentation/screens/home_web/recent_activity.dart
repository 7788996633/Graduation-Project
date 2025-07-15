import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  const RecentActivity({super.key});

  final List<Activity> activities = const [
    Activity(
      time: '30 mins ago',
      title: 'Case Filed',
      description: 'Attorney Ahmad filed a new civil case',
      color: Colors.blue,
    ),
    Activity(
      time: '2 hours ago',
      title: 'Client Meeting',
      description: 'Lawyer Laila met with a new client',
      color: Colors.red,
    ),
    Activity(
      time: '3 hours ago',
      title: 'Contract Reviewed',
      description: 'Mr. Samir reviewed a business contract',
      color: Colors.orange,
    ),
    Activity(
      time: 'Yesterday',
      title: 'Hearing Scheduled',
      description: 'Court hearing added for Case #1452',
      color: Colors.purple,
    ),
    Activity(
      time: '2 days ago',
      title: 'Legal Advice Sent',
      description: 'Legal assistant Rana responded to a client inquiry',
      color: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recent Activities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          ...activities.map((activity) => activityWidget(activity)).toList(),
        ],
      ),
    );
  }

  Widget activityWidget(Activity activity) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: activity.color),
      title: Text(activity.title),
      subtitle: Text(activity.description),
      trailing: Text(activity.time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}

class Activity {
  final String time;
  final String title;
  final String description;
  final Color color;

  const Activity({
    required this.time,
    required this.title,
    required this.description,
    required this.color,
  });
}
