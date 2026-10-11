import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void nextPage() {
    if (nameController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty ||
        yearController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Fill in all field'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Schedule(
          name: nameController.text.trim(),
          section: sectionController.text.trim(),
          year: yearController.text.trim(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: sectionController,
              decoration: const InputDecoration(
                labelText: 'Section:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year Level:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: nextPage,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class Schedule extends StatefulWidget {
  final String name;
  final String section;
  final String year;

  const Schedule({
    super.key,
    required this.name,
    required this.section,
    required this.year,
  });

  @override
  State<Schedule> createState() => _FormPageState();
}

class _FormPageState extends State<Schedule> {
  final TextEditingController subController = TextEditingController();
  final TextEditingController schedController = TextEditingController();
  final TextEditingController sub1Controller = TextEditingController();
  final TextEditingController sched1Controller = TextEditingController();
  final TextEditingController sub2Controller = TextEditingController();
  final TextEditingController sched2Controller = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveData() async {
    if (subController.text.trim().isEmpty ||
        schedController.text.trim().isEmpty ||
        sub1Controller.text.trim().isEmpty ||
        sched1Controller.text.trim().isEmpty ||
        sub2Controller.text.trim().isEmpty ||
        sched2Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Fill in all field'),
        ),
      );
      return;
    }

    await firestore.collection('students').add({
      'Name': widget.name,
      'Section': widget.section,
      'YearLevel': widget.year,

      'Subject1': subController.text.trim(),
      'Schedule1': schedController.text.trim(),

      'Subject2': sub1Controller.text.trim(),
      'Schedule2': sched1Controller.text.trim(),

      'Subject3': sub2Controller.text.trim(),
      'Schedule3': sched2Controller.text.trim(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data Saved succesfully'),
      ),
    );

    subController.clear();
    schedController.clear();
    sub1Controller.clear();
    sched1Controller.clear();
    sub2Controller.clear();
    sched2Controller.clear();
  }

  @override
  void dispose() {
    subController.dispose();
    schedController.dispose();
    sub1Controller.dispose();
    sched1Controller.dispose();
    sub2Controller.dispose();
    sched2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Schedule'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: subController,
              decoration: const InputDecoration(
                labelText: 'Subject:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: schedController,
              decoration: const InputDecoration(
                labelText: 'Schedule:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: sub1Controller,
              decoration: const InputDecoration(
                labelText: 'Subject:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: sched1Controller,
              decoration: const InputDecoration(
                labelText: 'Schedule:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: sub2Controller,
              decoration: const InputDecoration(
                labelText: 'Subject:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: sched2Controller,
              decoration: const InputDecoration(
                labelText: 'Schedule:',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: saveData,
              child: const Text('Save to Firebase'),
            ),
          ],
        ),
      ),
    );
  }
}