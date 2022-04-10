import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime dateTime = DateTime(2022, 12, 24, 05, 30);
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Date   And   Time",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final date = await pickDate();
                    if (date == null) return; //pressed cancel
                    final newDateTime = DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      dateTime.hour,
                      dateTime.minute,
                    );
                    setState(() {
                      dateTime = date;
                    });
                  },
                  child: Text(
                      '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final time = await pickTime();
                    if (time == null) return; //pressed cancel
                    final newDateTime = DateTime(
                      dateTime.year,
                      dateTime.month,
                      dateTime.day,
                      time.hour,
                      time.minute,
                    );
                    setState(() {
                      dateTime = newDateTime;
                    });
                  },
                  child: Text('$hours:$minute'),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: pickDateTime,
              child: Text(
                  '${dateTime.day}/${dateTime.month}/${dateTime.year}  $hours:$minute'),
            ),
          ],
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.dateTime = dateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
