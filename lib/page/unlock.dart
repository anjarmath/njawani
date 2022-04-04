import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/elemen/_textContainer.dart';

class Unlock extends StatefulWidget {
  const Unlock({Key? key}) : super(key: key);

  @override
  _UnlockState createState() => _UnlockState();
}

class _UnlockState extends State<Unlock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              padding:
                  EdgeInsets.only(top: 10, left: 30, right: 30, bottom: 30),
              decoration: BoxDecoration(
                  color: prblue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: Text(
                          'Paket Belum Premium',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Icon(
                            Icons.warning_rounded,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                  TextFieldContainer(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Masukkan kupon',
                        border: InputBorder.none,
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
