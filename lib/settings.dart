import 'package:flutter/material.dart';
import 'package:pomodoro/utils/functions.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List items;

  @override
  void initState() {
    super.initState();
    items = [
      {
        'icon': Icons.contact_page_sharp,
        'title': 'Contact Us',
        'function': () => showAbout(),
      },
      {
        'icon': Icons.info,
        'title': 'About',
        'function': () => showAbout(),
      },
      {
        'icon': Icons.local_fire_department_sharp,
        'title': 'Licenses',
        'function': () => _pushPageDialog(LicensePage()),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: items[index]['function'],
              leading: Icon(
                items[index]['icon'],
              ),
              title: Text(
                items[index]['title'],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
    );
  }

  _pushPageDialog(Widget page) {
    Functions.pushPageDialog(
      context,
      page,
    );
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'About',
          ),
          content: Text(
            'Pomodoro Timer App',
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).accentColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}
