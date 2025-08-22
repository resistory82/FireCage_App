import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firecage_dart/project/global/gobal_var.dart';
import 'package:firecage_dart/project/navbars/nav_main.dart';



class STARTSCREEN extends StatefulWidget {
  const STARTSCREEN({Key? key}) : super(key: key);

  @override
  State<STARTSCREEN> createState() => _STARTSCREENState();
}

class _STARTSCREENState extends State<STARTSCREEN> {
  
    AppBar appbar= AppBar(
        title: const Center(child: Text("Startseite")),
    );

	void init(){
		//readLocationData();
		//readUserData();
	}

	_STARTSCREENState(){
		init();
	}
  
  @override
  Widget build(BuildContext context) {

    //SZ.c=context;
    double appbar_height=appbar.preferredSize.height+MediaQuery.of(context).padding.top;
    SZ.setAppbarParameters(appbar_height);
    log(appbar_height);
    
    return Scaffold(
        appBar: appbar,
        drawer: const NavDrawer(),
        body: 
            SafeArea(child:  Column(
                children: [
                    Container(
                        width: SZ.setWidthPerc(100),
                        height: SZ.setHeightPerc(50),
                        color: Colors.red,
                        child:Center(
                            child: Text(
                                "Breite: ${ SZ.getWidth().round()}",
                                style: TextStyle(color: Colors.white,
                                fontSize: SZ.setWidthPerc(5)),
                            ),
                        ),
                    ),
                    Container(
                        width:  SZ.setWidthPerc(100),
                        height: SZ.setHeightPerc(50),
                        color: Colors.blue,
                        child: Center(
                            child: Text(
                                "Höhe: ${SZ.getHeight().round()}\nMenu Height Top: ${SZ.menubarBottomHeight}\nMenu Height Bottom: ${SZ.menubarTopHeight}\nAppbar Height: ${SZ.appbarHeight}",
                                style: TextStyle(color: Colors.white,
                                fontSize: SZ.setWidthPerc(5)),
                            ),
                        ),
                    )
                ],
            ),
        )
    );
  }
}

