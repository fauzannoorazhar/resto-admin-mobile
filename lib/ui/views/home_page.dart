import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resto_admin/models/operasional.dart';
import 'package:resto_admin/models/operasional_jam.dart';
import 'package:resto_admin/ui/views/form_operasional_page.dart';
import 'package:resto_admin/ui/views/splashscreen_page.dart';
import 'package:resto_admin/ui/widgets/card_box.dart';
import 'package:resto_admin/ui/widgets/splashscreen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:resto_admin/utilities/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    List<Operasional> listOperasional = new List<Operasional>();
    DatabaseHelper databaseHelper = DatabaseHelper();

    @override
    void initState() {
        // TODO: implement initState
        super.initState();
        initListOperasional();
        databaseHelper.initializeDatabase();
    }

    void initListOperasional() async {
        for (var i = 1; i <= 7; i++) {
            listOperasional.add(new Operasional(id_hari: i, id: i));
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Resto Admin'),
                actions: [
                    Padding(
                        padding: EdgeInsets.all(15),
                        child: InkWell(
                            onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {

                                        return AlertDialog(
                                            title: Text('Logout'),
                                            content: Text('Apakah Anda yakin untuk logout?'),
                                            actions: <Widget>[
                                                FlatButton(
                                                    child: Text('Logout'),
                                                    onPressed: () async {
                                                        SharedPreferences sp = await SharedPreferences.getInstance();
                                                        sp.clear();
                                                        return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SplashscreenPage()), (route) => false);
                                                    },
                                                ),
                                                FlatButton(
                                                    child: Text('Kembali'),
                                                    onPressed: () {
                                                        Navigator.pop(context);
                                                    },
                                                )
                                            ],
                                        );
                                    }
                                );
                            },
                            child: Icon(Icons.input),
                        )
                    )
                ],
            ),
            body: getBody(),
        );
    }

    Widget getBody() {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: listOperasional.length,
            itemBuilder: (BuildContext context, int index) {
                Operasional operasional = listOperasional[index];

                return InkWell(
                    onTap: () {
                        return Navigator.push(context, MaterialPageRoute(builder: (_) => FormOperasionalPage(
                            operasional: operasional,
                            operasionalJam: new OperasionalJam(id_operasional: operasional.id)
                        )));
                    },
                    child: CardBox(
                        headerBorderColor: Theme.of(context).primaryColor.withOpacity(0.3),
                        child: ListTile(
                            title: Text(
                                'Hari Operasional : ',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                ),
                            ),
                            subtitle: Text(operasional.getHari()),
                            leading: Icon(
                                Icons.calendar_today,
                                color: Theme.of(context).primaryColor,
                            ),
                        ),
                    )
                );
            },
        );
    }
}