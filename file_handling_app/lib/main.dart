import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const FileHandlingApp());
}

class FileHandlingApp extends StatelessWidget {
  const FileHandlingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter File Handling',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7652C8),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F6FC),
      ),
      home: const FileHomeScreen(),
    );
  }
}

class FileHomeScreen extends StatefulWidget {
  const FileHomeScreen({super.key});

  @override
  State<FileHomeScreen> createState() => _FileHomeScreenState();
}

class _FileHomeScreenState extends State<FileHomeScreen> {
  final TextEditingController _controller = TextEditingController();

  static const String storageKey = 'my_notes';

  String fileContent = 'Your saved text will appear here.';
  String statusMessage = 'Ready to save your text.';
  bool isLoading = false;

  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/my_notes.txt');
  }

  Future<void> writeFile() async {
    if (_controller.text.trim().isEmpty) {
      setState(() {
        statusMessage = 'Please enter some text first.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      statusMessage = 'Saving your text...';
    });

    try {
      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(storageKey, _controller.text);
      } else {
        final file = await getFile();
        await file.writeAsString(_controller.text);
      }

      setState(() {
        fileContent = _controller.text;
        statusMessage = 'Text saved successfully!';
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error saving text: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> readFile() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Reading saved text...';
    });

    try {
      String? contents;

      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        contents = prefs.getString(storageKey);
      } else {
        final file = await getFile();

        if (await file.exists()) {
          contents = await file.readAsString();
        }
      }

      setState(() {
        if (contents != null) {
          fileContent = contents;
          statusMessage = 'File read successfully!';
        } else {
          fileContent = 'No saved content found.';
          statusMessage = 'Save some text before reading.';
        }
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error reading text: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteFile() async {
    setState(() {
      isLoading = true;
      statusMessage = 'Deleting saved text...';
    });

    try {
      if (kIsWeb) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(storageKey);
      } else {
        final file = await getFile();

        if (await file.exists()) {
          await file.delete();
        }
      }

      setState(() {
        fileContent = 'No saved content.';
        statusMessage = 'Content deleted successfully!';
      });
    } catch (e) {
      setState(() {
        statusMessage = 'Error deleting content: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter File Handling',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF7652C8),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 20, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECE5FA),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.folder_copy_rounded,
                        size: 34,
                        color: Color(0xFF7652C8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Libraries and File Handling',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Create, write, read and delete a text file.',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // SECTION 1: External Libraries
              const SectionHeading(
                number: '1',
                title: 'External Libraries',
                subtitle: 'Packages used in this application',
              ),
              const SizedBox(height: 12),

              const LibraryCard(
                icon: Icons.folder_open_rounded,
                iconColor: Color(0xFF7652C8),
                title: 'path_provider',
                description: 'Access the app documents directory',
                tag: 'Device Storage',
              ),
              const SizedBox(height: 10),
              const LibraryCard(
                icon: Icons.storage_rounded,
                iconColor: Color(0xFF2687C8),
                title: 'shared_preferences',
                description: 'Persistent storage for web preview',
                tag: 'Web Storage',
              ),

              const SizedBox(height: 28),

              // SECTION 2: File Storage
              const SectionHeading(
                number: '2',
                title: 'File Storage',
                subtitle: 'Enter text and perform file operations',
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFEAE4F3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.05),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFF7652C8),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Enter File Content',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _controller,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Type something to save...',
                        filled: true,
                        fillColor: const Color(0xFFFAF9FC),
                        contentPadding: const EdgeInsets.all(14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5DDEE),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5DDEE),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF7652C8),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Write button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : writeFile,
                        icon: const Icon(Icons.save_rounded),
                        label: const Text('Write / Save File'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7652C8),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Read and Delete buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: isLoading ? null : readFile,
                            icon: const Icon(Icons.menu_book_rounded),
                            label: const Text('Read'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF7652C8),
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              side: const BorderSide(
                                color: Color(0xFFD9CDED),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: isLoading ? null : deleteFile,
                            icon: const Icon(Icons.delete_outline_rounded),
                            label: const Text('Delete'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              side: BorderSide(
                                color: Colors.red.shade100,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Status message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE9FA),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: Color(0xFF7652C8),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        statusMessage,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    if (isLoading)
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // SECTION 3: Stored Content
              const SectionHeading(
                number: '3',
                title: 'Stored Content',
                subtitle: 'View the text saved in your file',
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                constraints: const BoxConstraints(minHeight: 125),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFEAE4F3)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.description_outlined,
                      color: Color(0xFF7652C8),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SelectableText(
                        fileContent,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),
              Center(
                child: Text(
                  'Made with Flutter',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
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

class SectionHeading extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const SectionHeading({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF7652C8),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LibraryCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final String tag;

  const LibraryCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEAE4F3)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: iconColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}
