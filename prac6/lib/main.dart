import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Icons, Images & Charts',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFF8FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF8FF),
        elevation: 0,
        title: const Text(
          'Icons, Images & Charts',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================================================
            // TITLE
            // =========================================================

            const Text(
              'Flutter Visual Elements',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            // =========================================================
            // ICONS
            // =========================================================

            const Text(
              'Icons',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Rounded icon navigation container
            Container(
              height: 65,
              width: double.infinity,

              decoration: BoxDecoration(
                color: const Color(0xFFFFF7FF),
                borderRadius: BorderRadius.circular(12),

                border: Border.all(
                  color: const Color(0xFFE8DDE8),
                  width: 1,
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  // Home
                  Icon(
                    Icons.home,
                    size: 28,
                    color: Colors.blue,
                  ),

                  // Heart
                  Icon(
                    Icons.favorite,
                    size: 28,
                    color: Colors.red,
                  ),

                  // Star
                  Icon(
                    Icons.star,
                    size: 30,
                    color: Colors.orange,
                  ),

                  // Settings
                  Icon(
                    Icons.settings,
                    size: 28,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            // =========================================================
            // IMAGE
            // =========================================================

            const Text(
              'Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: Image.asset(
                  'assets/images/image.png',
                  width: 220,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 35),

            // =========================================================
            // CHART
            // =========================================================

            const Text(
              'Chart',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              height: 330,

              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(12),

                border: Border.all(
                  color: const Color(0xFFE8DDE8),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),

              child: BarChart(
                BarChartData(
                  maxY: 10,
                  minY: 0,

                  gridData: const FlGridData(
                    show: true,
                  ),

                  borderData: FlBorderData(
                    show: false,
                  ),

                  barGroups: [

                    // Happy
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 7,
                          width: 35,
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),

                    // Sad
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 5,
                          width: 35,
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),

                    // Calm
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 8,
                          width: 35,
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),

                    // Angry
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 6,
                          width: 35,
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ],
                    ),
                  ],

                  titlesData: FlTitlesData(

                    // Bottom titles
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,

                        getTitlesWidget: (value, meta) {
                          const titles = [
                            'Happy',
                            'Sad',
                            'Calm',
                            'Angry',
                          ];

                          final index = value.toInt();

                          if (index >= 0 &&
                              index < titles.length) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8),

                              child: Text(
                                titles[index],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),

                    // Left titles
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                      ),
                    ),

                    // Hide top
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),

                    // Hide right
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // =========================================================
            // COMBINED DASHBOARD
            // =========================================================

            const Text(
              '4. Combined Dashboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              height: 82,

              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFFFF7FF),

                borderRadius: BorderRadius.circular(10),

                border: Border.all(
                  color: const Color(0xFFE8DDE8),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),

              child: Row(
                children: [

                  // Purple analytics icon
                  Container(
                    width: 42,
                    height: 42,

                    decoration: BoxDecoration(
                      color: const Color(0xFF673AB7),
                      borderRadius: BorderRadius.circular(7),
                    ),

                    child: const Icon(
                      Icons.analytics,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Dashboard text
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Student Analytics',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          'Performance dashboard using icons, images and charts.',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Small image on right
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),

                    child: Image.asset(
                      'assets/images/image.png',
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Footer
            const Center(
              child: Text(
                'Created using Flutter',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}