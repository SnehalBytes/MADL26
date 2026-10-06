import 'package:flutter/material.dart';

void main() {
  runApp(const SmartFarmApp());
}

class SmartFarmApp extends StatelessWidget {
  const SmartFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farm',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
        ),
      ),
      home: const SmartFarmHome(),
    );
  }
}

class SmartFarmHome extends StatelessWidget {
  const SmartFarmHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FAF2),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isWide = constraints.maxWidth >= 700;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 40 : 8,
                vertical: 8,
              ),

              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1000,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      // =====================================
                      // HEADER
                      // =====================================

                      Row(
                        children: [
                          const Text(
                            'Smart Farm',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF26352A),
                            ),
                          ),

                          const Spacer(),

                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_none,
                              size: 20,
                            ),
                            color: Colors.grey.shade700,
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // =====================================
                      // FARM INFORMATION CARD
                      // =====================================

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),

                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF45B649),
                              Color(0xFF8BC34A),
                            ],
                          ),

                          borderRadius:
                              BorderRadius.circular(14),
                        ),

                        child: Row(
                          children: [

                            // FARM ICON
                            Container(
                              width: 42,
                              height: 42,

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(
                                  0.9,
                                ),
                                shape: BoxShape.circle,
                              ),

                              child: const Icon(
                                Icons.agriculture,
                                color: Color(0xFF55A847),
                                size: 23,
                              ),
                            ),

                            const SizedBox(width: 12),

                            // FARM DETAILS
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Green Valley Farm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 2),

                                  Text(
                                    'Pune, Maharashtra',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),

                                  SizedBox(height: 5),

                                  Row(
                                    children: [
                                      Text(
                                        '☀ 28°C',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),

                                      SizedBox(width: 10),

                                      Text(
                                        '• Clear Sky',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // =====================================
                      // FARM MONITORING
                      // =====================================

                      const SectionTitle(
                        title: 'Farm Monitoring',
                      ),

                      const SizedBox(height: 7),

                      GridView.count(
                        crossAxisCount: isWide ? 4 : 2,

                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,

                        childAspectRatio:
                            isWide ? 1.8 : 1.55,

                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(),

                        children: const [

                          MonitoringCard(
                            icon: Icons.water_drop,
                            iconColor: Color(0xFF2196F3),
                            value: '68%',
                            title: 'Soil Moisture',
                          ),

                          MonitoringCard(
                            icon: Icons.thermostat,
                            iconColor: Color(0xFFFF9800),
                            value: '28°C',
                            title: 'Temperature',
                          ),

                          MonitoringCard(
                            icon: Icons.cloud,
                            iconColor: Color(0xFF536DFE),
                            value: '72%',
                            title: 'Humidity',
                          ),

                          MonitoringCard(
                            icon: Icons.water,
                            iconColor: Color(0xFF26A69A),
                            value: '84%',
                            title: 'Water Level',
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // =====================================
                      // CROP STATUS
                      // =====================================

                      const SectionTitle(
                        title: 'Crop Status',
                      ),

                      const SizedBox(height: 7),

                      const CropCard(
                        cropName: 'Wheat',
                        progress: 0.80,
                        status: 'Healthy',
                        icon: Icons.grass,
                      ),

                      const CropCard(
                        cropName: 'Tomato',
                        progress: 0.60,
                        status: 'Growing',
                        icon: Icons.spa,
                      ),

                      const CropCard(
                        cropName: 'Sugarcane',
                        progress: 0.70,
                        status: 'Good Condition',
                        icon: Icons.eco,
                      ),

                      const SizedBox(height: 15),

                      // =====================================
                      // RECENT ALERTS
                      // =====================================

                      const SectionTitle(
                        title: 'Recent Alerts',
                      ),

                      const SizedBox(height: 7),

                      const AlertCard(
                        icon: Icons.water_drop,
                        iconColor: Color(0xFF4CAF50),
                        title: 'Irrigation Recommended',
                        description:
                            'Soil moisture is below the ideal level.',
                      ),

                      const AlertCard(
                        icon: Icons.thermostat,
                        iconColor: Color(0xFFFF9800),
                        title: 'Temperature Rising',
                        description:
                            'Temperature may increase this afternoon.',
                      ),

                      const AlertCard(
                        icon: Icons.check_circle,
                        iconColor: Color(0xFF4CAF50),
                        title: 'Crop Health Normal',
                        description:
                            'All monitored crops are healthy.',
                      ),

                      const SizedBox(height: 15),

                      // =====================================
                      // QUICK ACTIONS
                      // =====================================

                      const SectionTitle(
                        title: 'Quick Actions',
                      ),

                      const SizedBox(height: 7),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,

                        children: [
                          ActionButton(
                            icon: Icons.water_drop,
                            title: 'Start Irrigation',
                            onTap: () {
                              _showMessage(
                                context,
                                'Irrigation started',
                              );
                            },
                          ),

                          ActionButton(
                            icon: Icons.bar_chart,
                            title: 'View Reports',
                            onTap: () {
                              _showMessage(
                                context,
                                'Opening reports',
                              );
                            },
                          ),

                          ActionButton(
                            icon: Icons.sensors,
                            title: 'Sensors',
                            onTap: () {
                              _showMessage(
                                context,
                                'Sensor information',
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // =====================================
                      // FOOTER
                      // =====================================

                      Center(
                        child: Text(
                          'Smart Agriculture Monitoring System',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

// =========================================================
// SECTION TITLE
// =========================================================

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF26352A),
      ),
    );
  }
}

// =========================================================
// MONITORING CARD
// =========================================================

class MonitoringCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String title;

  const MonitoringCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(
        color: const Color(0xFFF0F4EB),
        borderRadius: BorderRadius.circular(10),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Container(
            width: 27,
            height: 27,

            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              size: 15,
              color: iconColor,
            ),
          ),

          const Spacer(),

          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF303830),
            ),
          ),

          const SizedBox(height: 1),

          Text(
            title,
            style: TextStyle(
              fontSize: 9,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// CROP CARD
// =========================================================

class CropCard extends StatelessWidget {
  final String cropName;
  final double progress;
  final String status;
  final IconData icon;

  const CropCard({
    super.key,
    required this.cropName,
    required this.progress,
    required this.status,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),

      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFF0F4EB),
        borderRadius: BorderRadius.circular(10),

        border: Border.all(
          color: const Color(0xFFE0E8D9),
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 38,
            height: 38,

            decoration: const BoxDecoration(
              color: Color(0xFFD5F3D0),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: const Color(0xFF4CAF50),
              size: 20,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(
                  children: [
                    Text(
                      cropName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),

                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,

                    backgroundColor:
                        const Color(0xFFD9E8D3),

                    valueColor:
                        const AlwaysStoppedAnimation<
                            Color>(
                      Color(0xFF3D7040),
                    ),
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '${(progress * 100).round()}% growth progress',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// ALERT CARD
// =========================================================

class AlertCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const AlertCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),

      decoration: const BoxDecoration(
        color: Color(0xFFF0F4EB),

        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD9E1D3),
          ),
        ),
      ),

      child: Row(
        children: [

          Container(
            width: 25,
            height: 25,

            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: iconColor,
              size: 15,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  description,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// QUICK ACTION BUTTON
// =========================================================

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF0F4EB),
      borderRadius: BorderRadius.circular(20),

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(20),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 6,
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,

            children: [

              Icon(
                icon,
                size: 12,
                color: const Color(0xFF4D8051),
              ),

              const SizedBox(width: 5),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 8,
                  color: Color(0xFF4D8051),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}