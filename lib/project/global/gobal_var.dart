import 'package:firecage_dart/library/controller/sqlite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


import 'package:firecage_dart/library/controller/size_contr.dart';
import 'package:firecage_dart/library/controller/color_contr.dart';

import 'package:firecage_dart/project/data/models/persons.dart';


//https://coolors.co/0d1b2a-a77e58-415a77-ba3f1d-e0e1dd



late SizeController SZ;
late ColorController COL;





late SqliteController SQLITE;

late PersonController contr_person;

void initGlobal(){
    SQLITE = SqliteController();
}



/*

/** Base colors */
--clr-dark-a0: #000000;
--clr-light-a0: #ffffff;

/** Theme primary colors */
--clr-primary-a0: #4978ad;
--clr-primary-a10: #5f86b6;
--clr-primary-a20: #7494bf;
--clr-primary-a30: #88a3c8;
--clr-primary-a40: #9cb2d1;
--clr-primary-a50: #b0c1da;

/** Theme surface colors */
--clr-surface-a0: #000a14;
--clr-surface-a10: #1d2329;
--clr-surface-a20: #353a40;
--clr-surface-a30: #4e5358;
--clr-surface-a40: #696d72;
--clr-surface-a50: #85888c;

/** Theme tonal surface colors */
--clr-surface-tonal-a0: #0d1721;
--clr-surface-tonal-a10: #242c36;
--clr-surface-tonal-a20: #3b434c;
--clr-surface-tonal-a30: #545b63;
--clr-surface-tonal-a40: #6e747b;
--clr-surface-tonal-a50: #898e94;

/** Examples */
.bg-primary {
 color: var(--clr-primary-a50);
 background-color: var(--clr-surface-a0);
}

*/
