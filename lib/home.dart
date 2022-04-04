import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';
import 'package:njawani/page/book.dart';
import 'package:njawani/page/dashboard.dart';
import 'package:njawani/page/quotes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:njawani/page/unlock.dart';
import 'package:njawani/page/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Book(),
    Quotes(),
    User(),
    Unlock()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentPage = Dashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTab == 2 ? prred : Colors.grey[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: currentTab == 4 ? prblue : Color(0x00000000),
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.all(0),
          child: Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: SvgPicture.asset(
                    "assets/img/menu.svg",
                    width: 20,
                    color: currentTab == 4 || currentTab == 2
                        ? Colors.white
                        : prblue,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              Expanded(child: Container()),
              Text(
                'Njawani',
                style: TextStyle(
                    color: currentTab == 2 ? Colors.white : prblue,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(child: Container()),
              Container(
                width: 20,
              )
            ],
          ),
        ),
      ),
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentPage = const Unlock();
            currentTab = 4;
          });
        },
        child: Icon(Icons.lock_open_rounded),
        backgroundColor: prblue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentPage = const Dashboard();
                        currentTab = 0;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/home.svg',
                          width: 27,
                          color: currentTab == 0 ? prblue : Colors.grey,
                        ),
                        Text(
                          'Beranda',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentPage = const Book();
                        currentTab = 1;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/chat.svg',
                          width: 27,
                          color: currentTab == 1 ? pryellow : Colors.grey,
                        ),
                        Text(
                          'Forum',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentPage = Quotes();
                        currentTab = 2;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/quotes.svg',
                          width: 27,
                          color: currentTab == 2 ? prred : Colors.grey,
                        ),
                        Text(
                          'Quotes',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentPage = User();
                        currentTab = 3;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg/profile.svg',
                          width: 27,
                          color: currentTab == 3 ? prgreen : Colors.grey,
                        ),
                        Text(
                          'Profil',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Text(
          'Bilang Halo',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
