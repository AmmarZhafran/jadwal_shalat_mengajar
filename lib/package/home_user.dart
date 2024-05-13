import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_shalat_mengajar/admin/hari_admin.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:geolocator/geolocator.dart';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;

class HomeUserPage extends StatefulWidget {
  const HomeUserPage({Key? key}) : super(key: key);

  @override
  State<HomeUserPage> createState() => _JadwalShalatState();
}

class _JadwalShalatState extends State<HomeUserPage> {
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
    getPrayerTimes(selectedDate);
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
        backgroundColor: Colors.red, // Ubah warna app bar menjadi merah
        toolbarHeight: 70, // Atur tinggi app bar menjadi lebih besar
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
            HarianPage()
          ],
        ),
      ]),
    );
  }
}
