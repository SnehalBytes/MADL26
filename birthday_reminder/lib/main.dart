import 'package:flutter/material.dart';

void main() {
  runApp(const BirthdayReminderApp());
}

class BirthdayReminderApp extends StatefulWidget {
  const BirthdayReminderApp({super.key});

  @override
  State<BirthdayReminderApp> createState() => _BirthdayReminderAppState();
}

class _BirthdayReminderAppState extends State<BirthdayReminderApp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final List<Map<String, String>> birthdays = [
    {"name": "Merin", "date": "28 Sep"},
    {"name": "Riya", "date": "26 Sep"},
    {"name": "Justin", "date": "2 Jan"},
  ];

  void addBirthday() {
    String name = nameController.text.trim();
    String date = dateController.text.trim();

    if (name.isEmpty || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter name and birthday"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      birthdays.add({
        "name": name,
        "date": date,
      });
    });

    nameController.clear();
    dateController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Birthday added successfully! 🎉"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Birthday Reminder",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),

        appBar: AppBar(
          title: const Text(
            "🎂 Birthday Reminder",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),

        body: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              // Name field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Birthday field
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Birthday (DD/MM/YYYY)",
                  prefixIcon: const Icon(Icons.cake),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Add Birthday button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: addBirthday,
                  icon: const Icon(Icons.add),
                  label: const Text(
                    "Add Birthday",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Heading
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Upcoming Birthdays",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Birthday list
              Expanded(
                child: ListView.builder(
                  itemCount: birthdays.length,
                  itemBuilder: (context, index) {
                    return BirthdayCard(
                      name: birthdays[index]["name"]!,
                      date: birthdays[index]["date"]!,
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
}

// Birthday Card
class BirthdayCard extends StatelessWidget {
  final String name;
  final String date;

  const BirthdayCard({
    super.key,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.cake,
            color: Colors.white,
          ),
        ),

        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          "Birthday: $date",
        ),

        trailing: const Icon(
          Icons.notifications_active,
          color: Colors.orange,
        ),
      ),
    );
  }
}