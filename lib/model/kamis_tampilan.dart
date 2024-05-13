import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jadwal_shalat_mengajar/model/input_jadwal_kamis.dart';

class ItemListPage extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const ItemListPage({Key? key, required this.dataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Items'),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Nama Pelajaran: ${dataList[index]['subject']}'),
            subtitle: Text(
                'Jumlah Siswa: ${dataList[index]['students']}, Nama Guru: ${dataList[index]['teacher']}, Jam Mulai: ${DateFormat('HH:mm').format(dataList[index]['startTime']!.toLocal())}, Jam Selesai: ${DateFormat('HH:mm').format(dataList[index]['endTime']!.toLocal())}'),
          );
        },
      ),
    );
  }
}
