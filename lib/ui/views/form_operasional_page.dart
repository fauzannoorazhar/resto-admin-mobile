import 'package:flutter/material.dart';
import 'package:resto_admin/models/operasional.dart';
import 'package:resto_admin/models/operasional_jam.dart';
import 'package:resto_admin/ui/widgets/card_box.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FormOperasionalPage extends StatefulWidget {
    final Operasional operasional;
    final OperasionalJam operasionalJam;
    FormOperasionalPage({
        @required this.operasional,
        @required this.operasionalJam
    });

    @override
    _FormOperasionalPageState createState() => _FormOperasionalPageState();
}

class _FormOperasionalPageState extends State<FormOperasionalPage> {
    

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Form Operasional'),
            ),
            body: getBody(),
        );
    }

    Widget getBody() {
        return SingleChildScrollView(
            child: CardBox(
                headerBorderColor: Theme.of(context).primaryColor,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                            child: Text(
                                'Tambah Jam Operasional ' + this.widget.operasional.getHari(),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54
                                ),
                            ),
                        ),
                        Divider(height: 30, thickness: 1.5),
                        getFormJam(),
                        SizedBox(height: 15,),
                        getButtonSubmit()
                    ],
                ),
            )
        );
    }

    Widget getFormJam() {
        return Row(
            children: [
                Expanded(
                    child: DateTimeField(
                        format: DateFormat("HH:mm"),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Jam Buka',
                        ),
                        onChanged: (DateTime value) {
                            this.widget.operasionalJam.jam_buka = DateFormat('HH:mm').format(value).toString();
                        },
                        //initialValue: (this.createOrUpdate == KegiatanHarian.update) ? this.getJamMulai() : null,
                        onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );

                            return DateTimeField.convert(time);
                        },
                    ),
                ),
                SizedBox(width: 20),
                Expanded(
                    child: DateTimeField(
                        format: DateFormat("HH:mm"),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Jam Buka',
                        ),
                        onChanged: (DateTime value) {
                            this.widget.operasionalJam.jam_tutup = DateFormat('HH:mm').format(value).toString();
                        },
                        //initialValue: (this.createOrUpdate == KegiatanHarian.update) ? this.getJamSelesai() : null,
                        onShowPicker: (context, currentValue) async {
                            final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                            );

                            return DateTimeField.convert(time);
                        },
                    ),
                ),
            ]
        );
    }

    Widget getButtonSubmit() {
        return FlatButton.icon(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            icon: Icon(
                Icons.save,
            ),
            label: Text('Simpan'),
            onPressed: () {
                if (this.widget.operasionalJam.validate()) {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('Data Akan Disimpan'),
                                actions: <Widget>[
                                    FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                ],
                            );
                        }
                    );
                } else {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                            return AlertDialog(
                                title: Text('Jam Operasional Gagal Ditambahkan'),
                                content: Text('Silahkan Lengkapi Form Berikut'),
                                actions: <Widget>[
                                    FlatButton(
                                        child: Text('Ok'),
                                        onPressed: () {
                                            Navigator.pop(context);
                                        },
                                    ),
                                ],
                            );
                        }
                    );
                }
            },
        );
    }
}