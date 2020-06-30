import 'package:flutter/material.dart';

class CardBox extends StatelessWidget {
    final Widget child;
    final Color headerBorderColor;
    final double height;

    CardBox({
        @required this.child,
        this.headerBorderColor = Colors.blue,
        this.height
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 5,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 5,
                                color: this.headerBorderColor,
                            )
                        )
                    ),
                    height: this.height,
                    padding: EdgeInsets.all(10),
                    child: this.child
                ),
            )
        );
    }
}