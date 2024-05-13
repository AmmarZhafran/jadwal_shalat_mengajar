import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:geolocator/geolocator.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;

class JumatPage extends StatefulWidget {
  const JumatPage({Key? key}) : super(key: key);

  @override
  State<JumatPage> createState() => _JadwalShalatState();
}

class _JadwalShalatState extends State<JumatPage> {
  String subuh = '';
  String zuhur = '';
  String ashar = '';
  String magrib = '';
  String isya = '';
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    // Set the selected date to the nearest Friday
    selectedDate = _getNearestFriday(selectedDate);
    getPrayerTimes(selectedDate);
  }

  // Function to get the nearest Friday
  DateTime _getNearestFriday(DateTime date) {
    while (date.weekday != DateTime.friday) {
      date = date.add(Duration(days: 1));
    }
    return date;
  }

  void getPrayerTimes(DateTime date) async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double latitude = position.latitude;
    double longtitude = position.longitude;

    tz.initializeTimeZones();
    String tzs = tzmap.latLngToTimezoneString(latitude, longtitude);
    final location = tz.getLocation(tzs);

    // Parameters
    CalculationParameters params = CalculationMethod.Singapore();
    PrayerTimes prayerTimes =
        PrayerTimes(Coordinates(latitude, longtitude), date, params);

    setState(() {
      subuh = DateFormat('HH:mm')
          .format(tz.TZDateTime.from(prayerTimes.fajr!, location))
          .toString();

      zuhur = DateFormat('HH:mm')
          .format(tz.TZDateTime.from(prayerTimes.dhuhr!, location))
          .toString();

      ashar = DateFormat('HH:mm')
          .format(tz.TZDateTime.from(prayerTimes.asr!, location))
          .toString();

      magrib = DateFormat('HH:mm')
          .format(tz.TZDateTime.from(prayerTimes.maghrib!, location))
          .toString();

      isya = DateFormat('HH:mm')
          .format(tz.TZDateTime.from(prayerTimes.isha!, location))
          .toString();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate:
          DateTime.now().add(Duration(days: 30)), // Batas 30 hari ke depan
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Ensure selected date is a Friday
        selectedDate = _getNearestFriday(selectedDate);
      });
      getPrayerTimes(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedDateString =
        DateFormat('EEEE, d MMMM y').format(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Shalat'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                selectedDateString,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Subuh'),
                Text(subuh),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Zuhur'),
                Text(zuhur),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Ashar'),
                Text(ashar),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Maghrib'),
                Text(magrib),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Isya'),
                Text(isya),
              ],
            ),
            Divider(),
          ],
        ),
      ]),
    );
  }
}
