import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Firebase App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
        ),
      ),
      home: const StudentScreen(),
    );
  }
}

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref('students');

  bool isSaving = false;

  // WRITE DATA TO FIREBASE
  Future<void> saveStudent() async {
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill in all fields'),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      await databaseRef.push().set({
        'name': name,
        'email': email,
      });

      nameController.clear();
      emailController.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Student added successfully! 🎉'),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong: $e'),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),

          child: Column(
            children: [

              // ─────────────────────────────
              // HEADER
              // ─────────────────────────────

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  25,
                  35,
                  25,
                  35,
                ),

                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF5B5FEF),
                      Color(0xFF7B61FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.cloud_done_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 15),

                        const Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Firebase Database',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              'Student Management',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Add Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Enter student details and save them securely.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // ─────────────────────────────
              // INPUT CARD
              // ─────────────────────────────

              Padding(
                padding: const EdgeInsets.all(20),

                child: Container(
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      const Row(
                        children: [
                          Icon(
                            Icons.person_add_alt_1_rounded,
                            color: Color(0xFF5B5FEF),
                          ),

                          SizedBox(width: 10),

                          Text(
                            'Student Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // NAME
                      TextField(
                        controller: nameController,

                        decoration: InputDecoration(
                          labelText: 'Student Name',
                          hintText: 'Enter full name',
                          prefixIcon: const Icon(
                            Icons.person_outline,
                          ),

                          filled: true,
                          fillColor: const Color(0xFFF7F7FB),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF5B5FEF),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // EMAIL
                      TextField(
                        controller: emailController,

                        keyboardType:
                            TextInputType.emailAddress,

                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'example@gmail.com',
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),

                          filled: true,
                          fillColor: const Color(0xFFF7F7FB),

                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF5B5FEF),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // SAVE BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          onPressed:
                              isSaving ? null : saveStudent,

                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF5B5FEF),

                            foregroundColor: Colors.white,

                            elevation: 0,

                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                          ),

                          child: isSaving
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child:
                                      CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_rounded,
                                    ),

                                    SizedBox(width: 10),

                                    Text(
                                      'SAVE TO FIREBASE',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─────────────────────────────
              // SAVED STUDENTS
              // ─────────────────────────────

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                child: Row(
                  children: [
                    const Icon(
                      Icons.groups_rounded,
                      color: Color(0xFF5B5FEF),
                    ),

                    const SizedBox(width: 10),

                    const Text(
                      'Saved Students',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFE8E8FF),
                        borderRadius:
                            BorderRadius.circular(20),
                      ),

                      child: const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Color(0xFF5B5FEF),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // ─────────────────────────────
              // FIREBASE DATA
              // ─────────────────────────────

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20),

                child: StreamBuilder<DatabaseEvent>(
                  stream: databaseRef.onValue,

                  builder: (context, snapshot) {

                    if (snapshot.hasError) {
                      return _messageCard(
                        Icons.error_outline,
                        'Unable to load data',
                      );
                    }

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.all(30),
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data =
                        snapshot.data?.snapshot.value;

                    if (data == null) {
                      return _messageCard(
                        Icons.cloud_off_rounded,
                        'No students added yet',
                      );
                    }

                    final Map<dynamic, dynamic> students =
                        Map<dynamic, dynamic>.from(
                      data as Map,
                    );

                    return Column(
                      children:
                          students.entries.map((entry) {

                        final student =
                            Map<dynamic, dynamic>.from(
                          entry.value,
                        );

                        return Container(
                          margin:
                              const EdgeInsets.only(bottom: 12),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(18),

                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.black.withOpacity(
                                  0.04,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),

                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),

                            leading: CircleAvatar(
                              radius: 25,

                              backgroundColor:
                                  const Color(0xFFE8E8FF),

                              child: Text(
                                (student['name'] ?? 'S')
                                    .toString()
                                    .substring(0, 1)
                                    .toUpperCase(),

                                style: const TextStyle(
                                  color: Color(0xFF5B5FEF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),

                            title: Text(
                              student['name'] ?? 'No Name',

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5),

                              child: Text(
                                student['email'] ?? 'No Email',

                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),

                            trailing: const Icon(
                              Icons.check_circle_rounded,
                              color: Colors.green,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageCard(IconData icon, String message) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Icon(
            icon,
            size: 45,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 10),

          Text(
            message,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}