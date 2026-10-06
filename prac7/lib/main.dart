import 'package:flutter/material.dart';

void main() {
  runApp(const NavigationGestureApp());
}

class NavigationGestureApp extends StatelessWidget {
  const NavigationGestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation, Routing & Gestures',

      // Starting screen
      initialRoute: '/',

      // Named routes
      routes: {
        '/': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/details': (context) => const DetailsScreen(),
      },

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String gestureMessage = 'Try a gesture!';

  // Single tap
  void handleTap() {
    setState(() {
      gestureMessage = 'Single Tap detected!';
    });
  }

  // Double tap
  void handleDoubleTap() {
    setState(() {
      gestureMessage = 'Double Tap detected!';
    });
  }

  // Long press
  void handleLongPress() {
    setState(() {
      gestureMessage = 'Long Press detected!';
    });
  }

  // Swipe
  void handleHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity == null) {
      return;
    }

    if (details.primaryVelocity! > 0) {
      setState(() {
        gestureMessage = 'Swiped Right!';
      });
    } else {
      setState(() {
        gestureMessage = 'Swiped Left!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Navigation & Gestures',
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --------------------------------------------------
            // TITLE
            // --------------------------------------------------

            const Text(
              'Flutter Navigation Demo',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Navigation, routing and gesture detection',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            // --------------------------------------------------
            // NAVIGATION
            // --------------------------------------------------

            const Text(
              'Navigation',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Profile button
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/profile',
                  );
                },

                icon: const Icon(
                  Icons.person,
                ),

                label: const Text(
                  'Go to Profile',
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Details button
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                  );
                },

                icon: const Icon(
                  Icons.info,
                ),

                label: const Text(
                  'Go to Details',
                ),
              ),
            ),

            const SizedBox(height: 35),

            // --------------------------------------------------
            // GESTURES
            // --------------------------------------------------

            const Text(
              'Gestures',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Try the different gestures on the box below:',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            // GestureDetector
            GestureDetector(

              // Single tap
              onTap: handleTap,

              // Double tap
              onDoubleTap: handleDoubleTap,

              // Long press
              onLongPress: handleLongPress,

              // Swipe
              onHorizontalDragEnd:
                  handleHorizontalDragEnd,

              child: Container(
                width: double.infinity,
                height: 180,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF673AB7),
                      Color(0xFF9C27B0),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.deepPurple.withOpacity(
                        0.25,
                      ),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: const Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 50,
                    ),

                    SizedBox(height: 12),

                    Text(
                      'Touch / Swipe Me',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      'Tap • Double Tap • Long Press • Swipe',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Gesture result
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Row(
                children: [

                  Icon(
                    Icons.gesture,
                    color:
                        Colors.deepPurple.shade700,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      gestureMessage,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // --------------------------------------------------
            // EXPLANATION
            // --------------------------------------------------

            const Text(
              'Gestures Demonstrated',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GestureInfoCard(
              icon: Icons.touch_app,
              title: 'Single Tap',
              description:
                  'Tap once on the purple box.',
            ),

            GestureInfoCard(
              icon: Icons.ads_click,
              title: 'Double Tap',
              description:
                  'Tap twice quickly on the purple box.',
            ),

            GestureInfoCard(
              icon: Icons.pan_tool,
              title: 'Long Press',
              description:
                  'Press and hold the purple box.',
            ),

            GestureInfoCard(
              icon: Icons.swipe,
              title: 'Swipe',
              description:
                  'Swipe the purple box left or right.',
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// GESTURE INFORMATION CARD
// ============================================================

class GestureInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const GestureInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Colors.deepPurple.shade50,

          child: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          description,
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const CircleAvatar(
                radius: 55,

                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Student Profile',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'This is the Profile Screen.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),

              // Navigate using named route
              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                    );
                  },

                  icon: const Icon(
                    Icons.arrow_forward,
                  ),

                  label: const Text(
                    'View Details',
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Back
              SizedBox(
                width: double.infinity,

                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  icon: const Icon(
                    Icons.arrow_back,
                  ),

                  label: const Text(
                    'Go Back',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DETAILS SCREEN
// ============================================================

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.info_outline,
                size: 80,
                color: Colors.deepPurple,
              ),

              const SizedBox(height: 20),

              const Text(
                'Details Screen',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'This screen demonstrates named routing in Flutter.',
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },

                icon: const Icon(
                  Icons.arrow_back,
                ),

                label: const Text(
                  'Go Back',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}