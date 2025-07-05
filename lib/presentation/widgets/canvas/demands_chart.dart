import 'package:flutter/material.dart';

import '../../../data/models/demand_model.dart';

/// نموذج البيانات المجمعة
class DemandGroupedModel {
  final String date;
  final int count;

  DemandGroupedModel({required this.date, required this.count});
}

class GoalChartWidget extends StatefulWidget {
  final List<DemandModel> data;
  final double height;

  const GoalChartWidget({
    super.key,
    required this.data,
    this.height = 250,
  });

  @override
  State<GoalChartWidget> createState() => _GoalChartWidgetState();
}

class _GoalChartWidgetState extends State<GoalChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  late List<DemandGroupedModel> groupedData;

  @override
  void initState() {
    super.initState();

    groupedData = _groupByDate(widget.data);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<DemandGroupedModel> _groupByDate(List<DemandModel> data) {
    final Map<String, int> map = {};

    for (var item in data) {
      map[item.date.toString()] = (map[item.date.toString()] ?? 0) + 1;
    }

    return map.entries
        .map((e) => DemandGroupedModel(date: e.key, count: e.value))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final chartHeight = widget.height;

    final double itemWidth = 60; // عرض كل عمود
    final double totalWidth = groupedData.length * itemWidth;

    return Container(
      padding: const EdgeInsets.all(20),
      height: chartHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: totalWidth > width ? totalWidth : width,
            height: chartHeight,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return CustomPaint(
                  size: Size(
                      totalWidth > width ? totalWidth : width, chartHeight),
                  painter: GoalBasedTimeBreakdownBarChart(
                    baseHeight: chartHeight - 30,
                    baseWidth: totalWidth > width ? totalWidth : width,
                    xItems: groupedData,
                    progress: animation.value,
                    itemWidth: itemWidth,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class GoalBasedTimeBreakdownBarChart extends CustomPainter {
  final List<DemandGroupedModel> xItems;
  final double baseWidth;
  final double baseHeight;
  final double progress;
  final double itemWidth;

  late Offset baseOffset;
  late double baseX;
  late double baseY;
  late int xItemCount;
  late double xItemWidth;

  int maxCount = 10;

  GoalBasedTimeBreakdownBarChart({
    required this.baseHeight,
    required this.baseWidth,
    required this.xItems,
    required this.progress,
    required this.itemWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    initBaseOffset();

    if (xItems.isEmpty) return;

    maxCount = xItems.map((e) => e.count).reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < xItems.length; i++) {
      drawXItem(canvas, item: xItems[i], index: i);
    }
  }

  void initBaseOffset() {
    baseX = 0;
    baseY = baseHeight;
    baseOffset = Offset(baseX, baseY);
    xItemCount = xItems.length;
    xItemWidth = itemWidth;
  }

  void drawXItem(Canvas canvas,
      {required DemandGroupedModel item, required int index}) {
    double xItemDividerWidth = (xItemWidth * 0.1); // فاصل بسيط بين الأعمدة
    double widthBar = xItemWidth - xItemDividerWidth;

    var startXOfItem = index * xItemWidth;
    double fullHeight = baseHeight / maxCount;
    double currentHeight = fullHeight * item.count * progress;

    // التاريخ تحت العمود
    TextPainter labelTextPainter = TextPainter(
      text: TextSpan(
        text: item.date.toString(),
        style: const TextStyle(color: Colors.black, fontSize: 10),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    labelTextPainter.layout(maxWidth: widthBar);
    labelTextPainter.paint(
      canvas,
      Offset(
          baseOffset.dx +
              startXOfItem +
              (widthBar - labelTextPainter.width) / 2,
          baseOffset.dy + 10),
    );

    // رسم العمود
    Paint paintBar = Paint()
      ..color = Colors.indigo.withOpacity(0.8)
      ..strokeWidth = widthBar
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(
      baseOffset.dx + startXOfItem,
      baseY - currentHeight,
      widthBar,
      currentHeight,
    );

    final rRect = RRect.fromRectAndCorners(
      rect,
      topLeft: const Radius.circular(5),
      topRight: const Radius.circular(5),
    );

    canvas.drawRRect(rRect, paintBar);

    // عدد الطلبات فوق العمود
    TextPainter countPainter = TextPainter(
      text: TextSpan(
        text: '${item.count}',
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    countPainter.layout();
    countPainter.paint(
      canvas,
      Offset(
        baseOffset.dx + startXOfItem + widthBar / 2 - countPainter.width / 2,
        baseY - currentHeight - 18,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant GoalBasedTimeBreakdownBarChart oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.xItems != xItems;
  }
}
