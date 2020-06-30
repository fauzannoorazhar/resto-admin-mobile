import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:resto_admin/ui/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final _formKey = GlobalKey<FormState>();
    var usernameController = TextEditingController();
    var passwordController = TextEditingController();
    ProgressDialog progressDialog;

    Widget _backButton() {
        return InkWell(
            onTap: () {
                Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
                        ),
                        Text('Back',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
                    ],
                ),
            ),
        );
    }

    Widget _entryField(String title, TextEditingController controller, {bool isPassword = false}) {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 15
                    ),
                ),
                SizedBox(
                    height: 10,
                ),
                TextFormField(
                    controller: controller,
                    validator: (value) {
                        if (value.isEmpty) {
                            return '$title tidak boleh kosong';
                        }
                        return null;
                    },
                    obscureText: isPassword,
                    decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.teal[50],
                            filled: true
                        )
                    ),
                ],
            ),
        );
    }

    Widget _submitButton() {
        return InkWell(
            onTap: () {
                DateTime now = DateTime.now();
                String valideUsername = DateFormat('mmhhddMMyy').format(now);
                String validePassword = DateFormat('yyMMddhhmm').format(now);

                print(valideUsername.toString());
                print(validePassword.toString());

                if (_formKey.currentState.validate()) {
                    doLogin();
                }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                color: Theme.of(context).primaryColor,
                child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                ),
            ),
        );
    }

    Widget _divider() {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Row(
                children: <Widget>[
                    SizedBox(
                        width: 20,
                    ),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                                thickness: 1,
                            ),
                        ),
                    ),
                    Text('or'),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(
                                thickness: 1,
                            ),
                        ),
                    ),
                    SizedBox(
                        width: 20,
                    ),
                ],
            ),
        );
    }

    Widget _forgotPasswordLabel() {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text(
                        'Lupa Password?',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                        width: 10,
                    ),
                    InkWell(
                        onTap: null,
                        child: Text(
                        'Klik Disini',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                        ),
                    )
                ],
            ),
        );
    }

    Widget _title() {
        return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'RESTO',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                ),
                children: [
                    TextSpan(
                        text: ' ADMIN',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                ]),
        );
    }

    Widget _emailPasswordWidget() {
        return Column(
            children: <Widget>[
                _entryField("Username", usernameController),
                _entryField("Password", passwordController, isPassword: true),
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        progressDialog = new ProgressDialog(context);
        progressDialog.style(
            message: 'Tunggu Sebentar...',
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            progressWidget: CircularProgressIndicator(),
            elevation: 10.0,
            insetAnimCurve: Curves.easeInOut,
            progress: 0.0,
            maxProgress: 100.0,
            progressTextStyle: TextStyle(
                color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
            messageTextStyle: TextStyle(
                color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
        );

        return Scaffold(
            body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                        children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Expanded(
                                            flex: 2,
                                            child: SizedBox(),
                                        ),
                                        // ClipRRect(
                                        //     child: Image.asset(
                                        //         'lib/assets/images/logo-icon.png', 
                                        //         fit: BoxFit.fill,
                                        //         height: 100,
                                        //     )
                                        // ),
                                        SizedBox(height: 20),
                                        _title(),
                                        SizedBox(
                                            height: 50,
                                        ),
                                        Form(
                                            key: _formKey,
                                            child: _emailPasswordWidget()
                                        ),
                                        SizedBox(
                                            height: 20,
                                        ),
                                        _submitButton(),
                                        Expanded(
                                            flex: 2,
                                            child: SizedBox(),
                                        ),
                                    ],
                                ),
                            ),
                            Align(
                                alignment: Alignment.bottomCenter,
                                child: _forgotPasswordLabel(),
                            ),
                            // Positioned(
                            //     top: 40, 
                            //     left: 0, 
                            //     child: _backButton()
                            // ),
                        ],
                    ),
                )
            )
        );
    }

    doLogin() async {
        await progressDialog.show();
        String username = usernameController.text;
        String password = passwordController.text;

        DateTime now = DateTime.now();
        String valideUsername = DateFormat('mmhhddMMyy').format(now);
        String validePassword = DateFormat('yyMMddhhmm').format(now);

        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        // Do LOGIN
        if (username == valideUsername.toString() && validePassword.toString() == password) {
            sharedPreferences.setString('login', 'true');
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
        } else {
            sharedPreferences.setString('login', 'false');
            await progressDialog.hide();
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text("Login Gagal"),
                        content: Text('Username dan Password Salah'),
                        actions: <Widget>[
                            FlatButton(
                                child: Text('OK'),
                                onPressed: () {
                                    Navigator.of(context).pop();
                                },
                            )
                        ]
                    );
                }
            );
        }
    }
}