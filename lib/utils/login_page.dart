import 'package:flutter/material.dart';
import 'package:jadwal_shalat_mengajar/admin/home_admin.dart';
import 'package:jadwal_shalat_mengajar/package/home_user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  void _login() {
    String id = idController.text.trim();
    String password = passwordController.text.trim();

    if (id == 'guru' && password == 'guru123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => JadwalShalat()),
      );
    } else if (id == 'murid' && password == 'murid123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeUserPage()),
      );
    } else {
      setState(() {
        errorMessage = 'ID atau password yang Anda masukkan salah';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red, // Ubah warna app bar menjadi merah
        title: Text(
          'Selamat datang di indira bimble',
          // Menggunakan font Pacifico
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: _login,
              child: Container(
                width: 50, // Atur lebar tombol lingkaran
                height: 50, // Atur tinggi tombol lingkaran
                decoration: BoxDecoration(
                  color: Colors.red, // Ubah warna tombol menjadi merah
                  shape:
                      BoxShape.circle, // Atur bentuk tombol menjadi lingkaran
                ),
                child: Center(
                  child: Icon(
                    Icons.login, // Ganti ikon menjadi ikon login
                    color: Colors.white, // Ubah warna ikon menjadi putih
                  ),
                ),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
