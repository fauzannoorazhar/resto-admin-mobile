import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resto_admin/models/operasional.dart';

class FormOperasioanAlert extends StatefulWidget {
    final Operasional operasional;
    FormOperasioanAlert({
        this.operasional
    });

    @override
    _FormOperasioanAlertState createState() => _FormOperasioanAlertState();
}

class _FormOperasioanAlertState extends State<FormOperasioanAlert> {
    final _formKey = GlobalKey<FormState>();

    TextEditingController rpController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(15)
                ),
            ),
            content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Container(
                        width: 400,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        
                                    ],
                                )
                            ],
                        ),
                    ),
                )
            ),
            actions: <Widget>[
                flatButton(
                    Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20.0),
                    ),
                    false
                ),
                flatButton(
                    Text(
                        "Save",
                        style: TextStyle(fontSize: 20.0),
                    ),
                    true
                ),
            ],
        );
    }

    Widget _entyField(String label, TextInputType textInputType, int maxLines, TextEditingController textEditingController) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text('$label'),
                SizedBox(height: 5),
                TextFormField(
                    controller: textEditingController,
                    validator: (value) {
                        if (value.isEmpty) {
                            return '$label tidak boleh kosong';
                        }
                        return null;
                    },
                    maxLines: maxLines,
                    keyboardType: textInputType,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                style: BorderStyle.none,
                                width: 0
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            )
                        ),
                        fillColor: Colors.black38,
                        filled: true,
                    ),
                ),
                SizedBox(height: 15),
            ],
        );
    }

    flatButton(Widget child, bool isSave) {
        return FlatButton(
            textColor: Colors.white,
            padding: EdgeInsets.all(10),
            onPressed: () {
                if (isSave) {
                    if (_formKey.currentState.validate()) {
                        //_save();
                    }
                } else {
                    return Navigator.pop(context);
                }
            },
            child: child,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(12)
                ),
            ),
        );
    }

    // void moveToLastScreen() {
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    //     //Navigator.pop(context);
    // }

    // void _save() async {
    //     moveToLastScreen();

    //     String tanggal = DateFormat.yMMMd().format(DateTime.now());
    //     finance = new Finance(rpController.text, deskripsiController.text, tanggal, _pilihan.index);
    //     await databaseHelper.insertTodo(finance);
    // }
}