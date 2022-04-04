import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  const Book({ Key? key }) : super(key: key);

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Book', style: Theme.of(context).textTheme.headline2,),
      ),
    );
  }
}