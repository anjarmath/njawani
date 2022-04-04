import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/library/text.dart';
import 'package:njawani/login/auth_method.dart';

import '../login/login.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  void back() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          back();
          return Future.value(false);
        },
        child: Scaffold(
            body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: trblue, width: 7, style: BorderStyle.solid)),
                    child: Image.asset('assets/img/user.png'),
                  ),
                ],
              ),
              Container(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Tom Cruise',
                    style: TextStyle(
                        fontSize: 32, color: dark, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/sekolah.png',
                    ),
                    Container(
                      width: 5,
                    ),
                    const Text(
                      'anjarmath@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: dark,
                      ),
                    ),
                    Container(
                      width: 5,
                    ),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    content: Text('Yakin ingin keluar?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'Cancel');
                                          },
                                          child: Text('Tidak')),
                                      TextButton(
                                          onPressed: () {
                                            AuthMethods().signOut();
                                            Navigator.pop(context, 'Ok');
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        LoginScreen()),
                                                (route) => false);
                                          },
                                          child: Text('Ya')),
                                    ],
                                  ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: trred,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Keluar',
                            style: TextStyle(color: Colors.red),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 140,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: trblue, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/img/goal.png',
                          width: 30,
                        ),
                        Column(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '80%',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: dark),
                                ),
                                Text(
                                  'Tujuan',
                                  style: TextStyle(color: dark),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 140,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: trred, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/img/kelas.png',
                          width: 40,
                        ),
                        Column(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '4',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: dark),
                                ),
                                Text(
                                  'Kelas',
                                  style: TextStyle(color: dark),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: 140,
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: tryellow,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/img/buku.png',
                          width: 37,
                        ),
                        Column(
                          children: [
                            Column(
                              children: const [
                                Text(
                                  '+10',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: dark),
                                ),
                                Text(
                                  'Buku',
                                  style: TextStyle(color: dark),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 25,
              ),
              Row(
                children: [
                  Text(
                    'Riwayat Kelas',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: dark, fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Librariku().judul.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: trgreen,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.timer_rounded,
                          color: prgreen,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Librariku().judul[index],
                            style: TextStyle(
                                fontWeight: FontWeight.w500, color: dark),
                          ),
                          Text(
                            '12/1/2022',
                            style: TextStyle(color: prgreen, fontSize: 14),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )));
  }
}
