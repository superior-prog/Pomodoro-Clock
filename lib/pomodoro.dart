import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/pages/break.dart';
import 'package:pomodoro/pages/session.dart';
import 'package:pomodoro/settings.dart';

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  int currentTabIndex = 0;

  //pages
  List<Widget> pages;
  Widget currentPage;

  Session sessionPage;
  Break breakPage;

  @override
  void initState() {
    sessionPage = Session();
    breakPage = Break();

    pages = [sessionPage, breakPage];

    currentPage = sessionPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          "Pomodoro Clock",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Settings()));
            },
          ),
        ],
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.grey[500],
        elevation: 3.0,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.timer),
            label: 'Session',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.timer_off),
            label: 'Break',
          ),
        ],
      ),
    );
  }
}
