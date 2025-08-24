import 'package:firecage_dart/library/controller/sqlite_controller.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:sqflite/sqflite.dart';
//import 'package:path_provider/path_provider.dart';


import 'package:firecage_dart/library/controller/size_contr.dart';
import 'package:firecage_dart/library/controller/color_contr.dart';

import 'package:firecage_dart/project/data/models/persons.dart';




late SizeController SZ;
late ColorController COL;


late SqliteController SQLITE;
late PersonController contr_person;



void initGlobal(){
    SQLITE = SqliteController();
}

