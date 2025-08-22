import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


import 'package:firecage_dart/library/controller/size_contr.dart';
import 'package:firecage_dart/library/controller/color_contr.dart';

import 'package:firecage_dart/project/data/models/persons.dart';


class SqliteController{

    late Database database;
    late String savepath;


    SqliteController(){
        initDatabase('firecage.db');
    }


    Future<void> initDatabase(String filename) async {
        var databasesPath = await getDatabasesPath();
        savepath = '$databasesPath/$filename';
        database = await openDatabase(savepath, version: 1,);

        print("Opend Database at Path $savepath");
    }

}