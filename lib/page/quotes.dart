// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:njawani/constant.dart';

class Quotes extends StatefulWidget {
  const Quotes({Key? key}) : super(key: key);

  @override
  _QuotesState createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: prred,
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
              height: 700,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/img/bgquotes.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: trblue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.format_quote_rounded,
                        color: prblue,
                      ),
                    ),
                  ),
                  Text(
                    '[w=ojwajznTiail=jw[n',
                    style: TextStyle(
                        fontFamily: 'Gerbangpraja',
                        height: 2,
                        fontSize: 24,
                        color: dark),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/img/quote.svg',
                        color: trred,
                      ),
                      SizedBox(width: 20),
                      Flexible(
                          child: Text(
                        'Wong jawa aja nganti ilang jawane',
                        style: TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontSize: 28),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
