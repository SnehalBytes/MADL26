import 'package:flutter/material.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Form',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6B3FA0),
        ),
      ),
      home: const RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? selectedGender;

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool acceptedTerms = false;

  // SUBMIT FORM
  void submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the Terms & Conditions',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2F5E8),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text('Success'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Form submitted successfully!',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                'Name: ${nameController.text}',
              ),

              Text(
                'Email: ${emailController.text}',
              ),

              Text(
                'Phone: ${phoneController.text}',
              ),

              Text(
                'Gender: ${selectedGender ?? ''}',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF6B3FA0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // RESET FORM
  void resetForm() {
    _formKey.currentState?.reset();

    nameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

    setState(() {
      selectedGender = null;
      acceptedTerms = false;
      obscurePassword = true;
      obscureConfirmPassword = true;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  // COMMON INPUT DECORATION
  InputDecoration fieldDecoration({
    required String label,
    required IconData icon,
    String? counterText,
  }) {
    return InputDecoration(
      labelText: label,
      counterText: counterText,

      prefixIcon: Icon(
        icon,
        size: 19,
        color: Colors.grey.shade700,
      ),

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade500,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade500,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF6B3FA0),
          width: 1.5,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5FC),

      appBar: AppBar(
        title: const Text(
          'Form',
          style: TextStyle(
            fontSize: 18,
          ),
        ),

        centerTitle: true,

        backgroundColor: const Color(0xFFFAF5FC),

        elevation: 0,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),

            child: Column(
              children: [

                // ============================
                // FULL NAME
                // ============================

                TextFormField(
                  controller: nameController,

                  textCapitalization:
                      TextCapitalization.words,

                  decoration: fieldDecoration(
                    label: 'Full Name',
                    icon: Icons.person,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your full name';
                    }

                    if (value.trim().length < 3) {
                      return 'Name must be at least 3 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 5),

                // ============================
                // EMAIL
                // ============================

                TextFormField(
                  controller: emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  decoration: fieldDecoration(
                    label: 'Email Address',
                    icon: Icons.email,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );

                    if (!emailRegex.hasMatch(
                      value.trim(),
                    )) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 5),

                // ============================
                // PHONE
                // ============================

                TextFormField(
                  controller: phoneController,

                  keyboardType: TextInputType.phone,

                  maxLength: 10,

                  decoration: fieldDecoration(
                    label: 'Phone Number',
                    icon: Icons.phone,
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter your phone number';
                    }

                    if (value.length != 10) {
                      return 'Phone number must contain 10 digits';
                    }

                    if (!RegExp(r'^[0-9]+$')
                        .hasMatch(value)) {
                      return 'Only numbers are allowed';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 5),

                // ============================
                // GENDER
                // ============================

                DropdownButtonFormField<String>(
                  value: selectedGender,

                  decoration: fieldDecoration(
                    label: 'Gender',
                    icon: Icons.people,
                  ),

                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],

                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please select your gender';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 5),

                // ============================
                // PASSWORD
                // ============================

                TextFormField(
                  controller: passwordController,

                  obscureText: obscurePassword,

                  decoration: fieldDecoration(
                    label: 'Password',
                    icon: Icons.lock,
                  ).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),

                      onPressed: () {
                        setState(() {
                          obscurePassword =
                              !obscurePassword;
                        });
                      },
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 5),

                // ============================
                // CONFIRM PASSWORD
                // ============================

                TextFormField(
                  controller:
                      confirmPasswordController,

                  obscureText:
                      obscureConfirmPassword,

                  decoration: fieldDecoration(
                    label: 'Confirm Password',
                    icon: Icons.lock_outline,
                  ).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),

                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword =
                              !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 3),

                // ============================
                // TERMS & CONDITIONS
                // ============================

                Row(
                  children: [
                    Checkbox(
                      value: acceptedTerms,

                      activeColor:
                          const Color(0xFF6B3FA0),

                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,

                      onChanged: (value) {
                        setState(() {
                          acceptedTerms =
                              value ?? false;
                        });
                      },
                    ),

                    const Expanded(
                      child: Text(
                        'I accept the Terms & Conditions',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // ============================
                // SUBMIT BUTTON
                // ============================

                SizedBox(
                  width: double.infinity,
                  height: 42,

                  child: ElevatedButton.icon(
                    onPressed: submitForm,

                    icon: const Icon(
                      Icons.send,
                      size: 16,
                    ),

                    label: const Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFF8F0FB),

                      foregroundColor:
                          const Color(0xFF6B3FA0),

                      elevation: 0,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // ============================
                // RESET BUTTON
                // ============================

                SizedBox(
                  width: double.infinity,
                  height: 34,

                  child: OutlinedButton.icon(
                    onPressed: resetForm,

                    icon: const Icon(
                      Icons.refresh,
                      size: 14,
                    ),

                    label: const Text(
                      'RESET FORM',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),

                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          const Color(0xFF6B3FA0),

                      side: BorderSide(
                        color: Colors.grey.shade400,
                      ),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}