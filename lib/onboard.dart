import 'package:flutter/material.dart';
import 'package:njawani/home.dart';
import 'package:njawani/login/login.dart';
import 'package:njawani/onboard_data.dart';
import 'constant.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    int totalpages = OnboardingItems.loadOnboardingItem().length;
    return Scaffold(
        body: PageView.builder(
            itemCount: totalpages,
            itemBuilder: (BuildContext context, int index) {
              OnboardingItem oi = OnboardingItems.loadOnboardingItem()[index];
              return Container(
                padding: EdgeInsets.all(15.0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: oi.color,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    index == totalpages - 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [],
                                  )),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => LoginScreen()));
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Skip",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: Colors.white,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                    Image.asset(
                      oi.image,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Column(
                      children: [
                        Text(
                          oi.title,
                          style: Theme.of(context).textTheme.headline1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Text(oi.subtitle,
                            style: Theme.of(context).textTheme.bodyText2,
                            textAlign: TextAlign.center)
                      ],
                    ),
                    index == totalpages - 1
                        ? TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              width: 170,
                              height: 60,
                              child: Text("Mulai Belajar",
                                  style: Theme.of(context).textTheme.headline3,
                                  textAlign: TextAlign.center),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        : Container(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 10,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: totalpages,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Container(
                                width: index == i ? 30 : 10,
                                decoration: BoxDecoration(
                                    color: index == i
                                        ? Colors.white
                                        : Colors.white70,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            }));
  }
}
