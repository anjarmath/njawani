// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Sugeng Rawuh,',
              style: TextStyle(
                  color: dark, fontWeight: FontWeight.w500, fontSize: 30),
            ),
            Text(
              'Anjar Dwi Hariadi',
              style: TextStyle(
                  color: dark, fontWeight: FontWeight.w700, fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: prgreen,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 4.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Flexible(
                child: Column(
                  children: [
                    Text(
                      '[w=ojwajznTiail=jw[n',
                      style: TextStyle(
                        fontFamily: 'Gerbangpraja',
                        height: 2,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('"Wong Jawa aja nganti ilang jawane"')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
