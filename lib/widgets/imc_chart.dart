import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_wb/constants/colors.dart';

class IMCChart extends StatelessWidget {
  final List<double> imcData;

  const IMCChart({super.key, required this.imcData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            verticalInterval: 1,
            horizontalInterval: 5,
            getDrawingVerticalLine: (value) => const FlLine(
              color: Colors.white,
              strokeWidth: 1,
            ),
            getDrawingHorizontalLine: (value) => const FlLine(
              color: Colors.white,
              strokeWidth: 1
            ),
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                   switch (value.toInt()) {
                    case 0:
                      return const Text(
                        'Jan',
                        style: TextStyle(color: tdFontColor, fontSize: 8),
                      );
                    case 1:
                      return const Text(
                        'Fev',
                        style: TextStyle(color: tdFontColor, fontSize: 8),
                      );
                    case 2:
                      return const Text(
                        'Mar',
                        style: TextStyle(color: tdFontColor, fontSize: 8),
                      );
                    case 3:
                      return const Text(
                        'Abr',
                        style: TextStyle(color: tdFontColor, fontSize: 8),
                      );
                    case 4:
                      return const Text(
                        'Mai',
                        style: TextStyle(color: tdFontColor, fontSize: 8),
                      );
                    default:
                      return const Text('');
                  }
                }
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toString(),
                    style: const TextStyle(color: tdWhite, fontSize: 8),
                  );
                }
              )
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: tdWhite,
              width: 1
            )
          ),
          minX: 0,
          minY: 4,
          maxX: 10,
          maxY: 40,
          lineBarsData: [
            LineChartBarData(
              spots: imcData.asMap().entries.map((e) {
                return FlSpot(e.key.toDouble(), e.value);
              }).toList(),
              isCurved: true,
              barWidth: 3,
              color: Colors.blue,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.3)
              ),
            ),
          ],
        )
      ),
    );
  }
}