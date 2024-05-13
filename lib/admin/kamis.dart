// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:jadwal_shalat_mengajar/model/kamis_tampilan.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:geolocator/geolocator.dart';
// import 'package:adhan_dart/adhan_dart.dart';
// import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;

// class DataManager {
//   static Future<List<Map<String, dynamic>>> loadData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String>? dataListString = prefs.getStringList('dataList');
//     if (dataListString != null) {
//       return dataListString.map((data) {
//         List<String> parts = data.split(',');
//         Map<String, dynamic> entry = {
//           'subject': parts[0],
//           'students': int.parse(parts[1]),
//           'teacher': parts[2],
//           'startTime': DateTime.parse(parts[3]),
//           'endTime': DateTime.parse(parts[4])
//         };
//         return entry;
//       }).toList();
//     } else {
//       return [];
//     }
//   }

//   static Future<void> saveData(List<Map<String, dynamic>> dataList) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> dataListString = dataList.map((data) {
//       String startTimeString =
//           DateFormat('yyyy-MM-dd HH:mm:ss').format(data['startTime']);
//       String endTimeString =
//           DateFormat('yyyy-MM-dd HH:mm:ss').format(data['endTime']);
//       return '${data['subject']},${data['students']},${data['teacher']},$startTimeString,$endTimeString';
//     }).toList();
//     await prefs.setStringList('dataList', dataListString);
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String subuh = '';
//   String zuhur = '';
//   String ashar = '';
//   String magrib = '';
//   String isya = '';
//   late DateTime selectedDate;
//   final TextEditingController subjectController = TextEditingController();
//   final TextEditingController teacherController = TextEditingController();
//   final TextEditingController studentController = TextEditingController();
//   DateTime? startTime;
//   DateTime? endTime;
//   List<Map<String, dynamic>> dataList = [];

//   @override
//   void initState() {
//     loadData();
//     super.initState();
//     selectedDate = DateTime.now();
//     // Set the selected date to the nearest Thursday
//     selectedDate = _getNearestThursday(selectedDate);
//     getPrayerTimes(selectedDate);
//   }

//   // Function to get the nearest Thursday
//   DateTime _getNearestThursday(DateTime date) {
//     while (date.weekday != DateTime.thursday) {
//       date = date.add(Duration(days: 1));
//     }
//     return date;
//   }

//   void getPrayerTimes(DateTime date) async {
//     LocationPermission permission;
//     permission = await Geolocator.requestPermission();

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     double latitude = position.latitude;
//     double longtitude = position.longitude;

//     tz.initializeTimeZones();
//     String tzs = tzmap.latLngToTimezoneString(latitude, longtitude);
//     final location = tz.getLocation(tzs);

//     // Parameters
//     CalculationParameters params = CalculationMethod.Singapore();
//     PrayerTimes prayerTimes =
//         PrayerTimes(Coordinates(latitude, longtitude), date, params);

//     setState(() {
//       subuh = DateFormat('HH:mm')
//           .format(tz.TZDateTime.from(prayerTimes.fajr!, location))
//           .toString();

//       zuhur = DateFormat('HH:mm')
//           .format(tz.TZDateTime.from(prayerTimes.dhuhr!, location))
//           .toString();

//       ashar = DateFormat('HH:mm')
//           .format(tz.TZDateTime.from(prayerTimes.asr!, location))
//           .toString();

//       magrib = DateFormat('HH:mm')
//           .format(tz.TZDateTime.from(prayerTimes.maghrib!, location))
//           .toString();

//       isya = DateFormat('HH:mm')
//           .format(tz.TZDateTime.from(prayerTimes.isha!, location))
//           .toString();
//     });
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate:
//           DateTime.now().add(Duration(days: 30)), // Batas 30 hari ke depan
//     );
//     if (picked != null && picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//         // Ensure selected date is a Thursday
//         selectedDate = _getNearestThursday(selectedDate);
//       });
//       getPrayerTimes(selectedDate);
//     }
//   }

//   Future<void> loadData() async {
//     dataList = await DataManager.loadData();
//     setState(() {});
//   }

//   Future<void> saveData() async {
//     await DataManager.saveData(dataList);
//   }

//   void addData() async {
//     // Input validation
//     if (subjectController.text.isEmpty ||
//         studentController.text.isEmpty ||
//         teacherController.text.isEmpty ||
//         startTime == null ||
//         endTime == null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Peringatan'),
//             content: Text('Mohon lengkapi semua field.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }

//     // Check if the input time conflicts with existing data
//     bool isTimeConflict = false;

//     // Check if user 2 has the same time input as user 1
//     bool isUser2SameTime = false;
//     if (startTime != null && endTime != null) {
//       for (var data in dataList) {
//         if (startTime == data['startTime'] && endTime == data['endTime']) {
//           isUser2SameTime = true;
//           break;
//         }
//       }
//     }

//     // If user 2 has the same time input as user 1, show dialog and return
//     if (isUser2SameTime) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Peringatan'),
//             content: Text('Gagal menambahkan data, waktu sudah terisi penuh.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }

//     // Continue with conflict check only if user 2 has different time input
//     for (var data in dataList) {
//       if (startTime!.isBefore(data['endTime']) &&
//           endTime!.isAfter(data['startTime'])) {
//         isTimeConflict = true;
//         break;
//       }
//     }

//     // Check if the input time falls within adhan times
//     bool isWithinAdhanTime = false;
//     if (startTime != null && endTime != null) {
//       // Ambil waktu azan
//       DateTime subuhTime = tz.TZDateTime(
//         tz.local,
//         startTime!.year,
//         startTime!.month,
//         startTime!.day,
//         int.parse(subuh.split(':')[0]),
//         int.parse(subuh.split(':')[1]),
//       );
//       DateTime asharTime = tz.TZDateTime(
//         tz.local,
//         startTime!.year,
//         startTime!.month,
//         startTime!.day,
//         int.parse(ashar.split(':')[0]),
//         int.parse(ashar.split(':')[1]),
//       );
//       DateTime magribTime = tz.TZDateTime(
//         tz.local,
//         startTime!.year,
//         startTime!.month,
//         startTime!.day,
//         int.parse(magrib.split(':')[0]),
//         int.parse(magrib.split(':')[1]),
//       );
//       DateTime isyaTime = tz.TZDateTime(
//         tz.local,
//         startTime!.year,
//         startTime!.month,
//         startTime!.day,
//         int.parse(isya.split(':')[0]),
//         int.parse(isya.split(':')[1]),
//       );

//       // Periksa apakah waktu mulai dan waktu selesai berada dalam rentang waktu azan
//       if ((startTime!.isBefore(subuhTime) && endTime!.isAfter(subuhTime)) ||
//           (startTime!.isBefore(asharTime) && endTime!.isAfter(asharTime)) ||
//           (startTime!.isBefore(magribTime) && endTime!.isAfter(magribTime)) ||
//           (startTime!.isBefore(isyaTime) && endTime!.isAfter(isyaTime))) {
//         isWithinAdhanTime = true;
//       }
//     }

//     // Handle time conflict or adhan time
//     if (isTimeConflict || isWithinAdhanTime) {
//       // Show dialog for failed data addition
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Peringatan'),
//             content: isWithinAdhanTime
//                 ? Text('Gagal menambahkan data, ini adalah waktu azan.')
//                 : Text('Gagal menambahkan data, jam penuh.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     } else {
//       // Add data if no time conflict
//       setState(() {
//         dataList.add({
//           'subject': subjectController.text,
//           'students': int.parse(studentController.text),
//           'teacher': teacherController.text,
//           'startTime': startTime!,
//           'endTime': endTime!,
//         });
//       });
//       await saveData();
//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 20), // Mengatur ukuran tinggi dan lebar
//             title: Text('Sukses'),
//             content: Column(
//               mainAxisSize:
//                   MainAxisSize.min, // Agar konten tetap berada di tengah
//               children: [
//                 Text('Data berhasil ditambahkan!'),
//                 SizedBox(height: 10),
//                 Image.asset(
//                   'assets/verified.png',
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );

//       // Clear input fields
//       subjectController.clear();
//       studentController.clear();
//       teacherController.clear();
//       setState(() {
//         startTime = null;
//         endTime = null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String selectedDateString =
//         DateFormat('EEEE, d MMMM y').format(selectedDate);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.calendar_today),
//             onPressed: () => _selectDate(context),
//           ),
//         ],
//         title: Text('CRUD Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30),
//               child: Text(
//                 selectedDateString,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(height: 10),
//             Divider(),
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text('Subuh'),
//                 Text(subuh),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text('Zuhur'),
//                 Text(zuhur),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text('Ashar'),
//                 Text(ashar),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text('Magrib'),
//                 Text(magrib),
//               ],
//             ),
//             Divider(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Text('Isyhaa'),
//                 Text(isya),
//               ],
//             ),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: subjectController,
//                 decoration: InputDecoration(
//                   labelText: 'Nama Pelajaran',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: studentController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Jumlah Siswa (max 15)',
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: teacherController,
//                 decoration: InputDecoration(
//                   labelText: 'Nama Guru',
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final DateTime? pickedStartTime = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );

//                       if (pickedStartTime != null) {
//                         final TimeOfDay? pickedStartTimeOfDay =
//                             await showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay.now(),
//                         );

//                         if (pickedStartTimeOfDay != null) {
//                           setState(() {
//                             startTime = tz.TZDateTime(
//                               tz.local,
//                               pickedStartTime.year,
//                               pickedStartTime.month,
//                               pickedStartTime.day,
//                               pickedStartTimeOfDay.hour,
//                               pickedStartTimeOfDay.minute,
//                             );
//                           });
//                         }
//                       }
//                     },
//                     child: Text('Pilih Jam Mulai'),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final DateTime? pickedEndTime = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(2000),
//                         lastDate: DateTime(2101),
//                       );

//                       if (pickedEndTime != null) {
//                         final TimeOfDay? pickedEndTimeOfDay =
//                             await showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay.now(),
//                         );

//                         if (pickedEndTimeOfDay != null) {
//                           setState(() {
//                             endTime = tz.TZDateTime(
//                               tz.local,
//                               pickedEndTime.year,
//                               pickedEndTime.month,
//                               pickedEndTime.day,
//                               pickedEndTimeOfDay.hour,
//                               pickedEndTimeOfDay.minute,
//                             );
//                           });
//                         }
//                       }
//                     },
//                     child: Text('Pilih Jam Selesai'),
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: addData,
//               child: Text('Tambah Data'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigasi ke halaman baru untuk menampilkan daftar item
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ItemListPage(dataList: dataList),
//                   ),
//                 );
//               },
//               child: Text('Lihat Hasil'),
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: dataList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Text('Nama Pelajaran: ${dataList[index]['subject']}'),
//                   subtitle: Text(
//                       'Jumlah Siswa: ${dataList[index]['students']}, Nama Guru: ${dataList[index]['teacher']}, Jam Mulai: ${DateFormat('HH:mm').format(dataList[index]['startTime']!.toLocal())}, Jam Selesai: ${DateFormat('HH:mm').format(dataList[index]['endTime']!.toLocal())}'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       setState(() {
//                         dataList.removeAt(index);
//                       });
//                       saveData();
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
