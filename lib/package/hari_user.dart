import 'package:flutter/material.dart';
import 'package:jadwal_shalat_mengajar/model/input_jadwal_kamis.dart';
import 'package:jadwal_shalat_mengajar/admin/kamis_admin.dart';
import 'package:jadwal_shalat_mengajar/package/sabtu.dart';
import 'package:jadwal_shalat_mengajar/admin/senin_admin.dart';

class HarianPage extends StatelessWidget {
  const HarianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://static6.depositphotos.com/1023102/650/i/600/depositphotos_6505158-stock-photo-3d-monday-block-text.jpg"),
                    fit: BoxFit.fill)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeninPage()),
                );
              },
              highlightColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              splashColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://static6.depositphotos.com/1023102/650/i/950/depositphotos_6505151-stock-photo-3d-tuesday-block-text.jpg"),
                    fit: BoxFit.fill)),
            child: InkWell(
              onTap: () {},
              highlightColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              splashColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://static6.depositphotos.com/1023102/650/i/450/depositphotos_6505138-stock-photo-3d-wednesday-block-text.jpg"),
                    fit: BoxFit.fill)),
            child: InkWell(
              onTap: () {},
              highlightColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              splashColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: AssetImage('assets/thursday.jpeg'),
                    fit: BoxFit.fill)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              highlightColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              splashColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://static6.depositphotos.com/1023102/650/i/950/depositphotos_6505166-stock-photo-3d-friday-block-text.jpg"),
                    fit: BoxFit.fill)),
            child: InkWell(
              onTap: () {},
              highlightColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              splashColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: Ink(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 15,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://static6.depositphotos.com/1023102/650/i/950/depositphotos_6505146-stock-photo-3d-saturday-block-text.jpg"),
                    fit: BoxFit.fill)),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sabtupage()),
                );
              },
              highlightColor:
                  const Color.fromARGB(255, 255, 255, 255).withOpacity(0.4),
              splashColor: Color.fromARGB(255, 255, 0, 0).withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
