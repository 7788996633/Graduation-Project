import 'package:flutter/material.dart';



class SessionStatsScreen extends StatefulWidget {
  const SessionStatsScreen({super.key});

  @override
  State<SessionStatsScreen> createState() => _SessionStatsScreenState();
}

class _SessionStatsScreenState extends State<SessionStatsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String selectedPeriod = 'اليوم';

  // بيانات عدد الجلسات حسب الأيام لكل فترة
  // لشهر 28 يوم مقسمة افتراضياً على 4 أسابيع (7 أيام لكل أسبوع)
  final Map<String, List<int>> sessionData = {
    'اليوم': [3, 0, 0, 0, 0, 0, 0],
    'الأسبوع': [2, 4, 1, 5, 3, 0, 2],
    'الشهر': [
      2, 3, 1, 4, 2, 3, 0, // أسبوع 1
      4, 5, 3, 2, 4, 3, 1, // أسبوع 2
      1, 2, 2, 3, 1, 0, 1, // أسبوع 3
      3, 1, 0, 2, 1, 3, 2 // أسبوع 4
    ],
  };

  // بيانات النقاط حسب الأيام لكل فترة (نفس عدد الأيام)
  final Map<String, List<int>> sessionPoints = {
    'اليوم': [2, 0, 0, 0, 0, 0, 0],
    'الأسبوع': [3, 5, 2, 6, 3, 0, 2],
    'الشهر': [
      1, 2, 0, 3, 1, 2, 0, // أسبوع 1
      2, 4, 1, 1, 3, 2, 1, // أسبوع 2
      1, 1, 1, 2, 1, 0, 1, // أسبوع 3
      3, 1, 0, 1, 1, 2, 2 // أسبوع 4
    ],
  };

  // أيام الأسبوع (ثابتة)
  final List<String> days = [
    'أحد',
    'اثنين',
    'ثلاثاء',
    'أربعاء',
    'خميس',
    'جمعة',
    'سبت'
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  void updateChart(String newPeriod) {
    setState(() {
      selectedPeriod = newPeriod;
      _controller.reset();
      _controller.forward();
    });
  }

  int getTotalPoints() {
    return sessionPoints[selectedPeriod]?.fold(0, (a, b) => a! + b) ?? 0;
  }

  // تقسيم البيانات إلى أسابيع (مصفوفة أسابيع كل أسبوع فيه 7 أيام)
  List<List<int>> splitIntoWeeks(List<int> data) {
    List<List<int>> weeks = [];
    for (int i = 0; i < data.length; i += 7) {
      weeks.add(data.sublist(i, (i + 7).clamp(0, data.length)));
    }
    return weeks;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildPeriodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('الفترة:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        DropdownButton<String>(
          value: selectedPeriod,
          items: ['اليوم', 'الأسبوع', 'الشهر']
              .map((period) => DropdownMenuItem<String>(
                    value: period,
                    child: Text(
                      period,
                      style: TextStyle(fontSize: 16),
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) updateChart(value);
          },
        ),
      ],
    );
  }

  Widget buildPointsCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade100.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Center(
        child: Text(
          'مجموع النقاط المحققة: ${getTotalPoints()} ⭐️',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800),
        ),
      ),
    );
  }

  Widget buildChart() {
    final values = sessionData[selectedPeriod]!;
    final points = sessionPoints[selectedPeriod]!;

    if (selectedPeriod == 'الشهر') {
      final weeksValues = splitIntoWeeks(values);
      final weeksPoints = splitIntoWeeks(points);

      return PageView.builder(
        itemCount: weeksValues.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  )
                ],
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'الأسبوع ${index + 1}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CustomPaint(
                        size: Size(70.0 * weeksValues[index].length, 250),
                        painter: SessionsChartPainter(
                            weeksValues[index],
                            weeksPoints[index],
                            days.sublist(0, weeksValues[index].length),
                            _animation),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      // اليوم أو الأسبوع
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: CustomPaint(
          size: Size(70.0 * values.length, 300),
          painter: SessionsChartPainter(values, points, days, _animation),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: Text('توزيع الجلسات'),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildPeriodSelector(),
            buildPointsCard(),
            Expanded(child: buildChart()),
          ],
        ),
      ),
    );
  }
}

class SessionsChartPainter extends CustomPainter {
  final List<int> sessionCounts;
  final List<int> sessionPoints;
  final List<String> days;
  final Animation<double> animation;

  SessionsChartPainter(
      this.sessionCounts, this.sessionPoints, this.days, this.animation)
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final textPainter = TextPainter(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
    );

    final double maxBarHeight = size.height - 60;
    final double maxValue = sessionCounts.isEmpty
        ? 1
        : sessionCounts.reduce((a, b) => a > b ? a : b).toDouble();
    final double barWidth = 25;
    final double space = 25;

    for (int i = 0; i < sessionCounts.length; i++) {
      final x = (i * (barWidth + space)) + 20;
      final normalizedHeight =
          (sessionCounts[i] / maxValue) * maxBarHeight * animation.value;

      final rect = Rect.fromLTWH(
          x, size.height - normalizedHeight, barWidth, normalizedHeight);
      canvas.drawRect(rect, barPaint);

      // عدد الجلسات فوق العمود
      textPainter.text = TextSpan(
        text: '${sessionCounts[i]} جلسة',
        style: TextStyle(
            fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - 5, size.height - normalizedHeight - 40));

      // عدد النقاط (نجوم)
      textPainter.text = TextSpan(
        text: '${sessionPoints[i]} ⭐',
        style: TextStyle(
            fontSize: 12,
            color: Colors.orange.shade800,
            fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(x - 5, size.height - normalizedHeight - 22));

      // اسم اليوم تحت العمود
      textPainter.text = TextSpan(
        text: days[i],
        style: TextStyle(
            fontSize: 13,
            color: Colors.teal.shade900,
            fontWeight: FontWeight.w600),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 6, size.height - 18));
    }

    // خطوط الشبكة الأفقية الخفيفة لتحسين الرؤية
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.25)
      ..strokeWidth = 1;

    for (int i = 0; i <= 5; i++) {
      double y = size.height - ((maxBarHeight / 5) * i);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SessionsChartPainter oldDelegate) => true;
}
