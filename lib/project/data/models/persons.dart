import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:firecage_dart/project/global/gobal_var.dart';
import 'package:firecage_dart/project/data/models/data_models.dart';


class Person {
    final int? id;
    final int uuid;
    final String firstname;
    final String lastname;
    final int qualification;
    final bool isActive;
    final DateTime timestampUpdated;
    final DateTime timestampCreated;

    Person({
        this.id,
        required this.uuid,
        required this.firstname,
        required this.lastname,
        required this.qualification,
        required this.isActive,
        required this.timestampUpdated,
        required this.timestampCreated,
    });

    String print(){
        return "\n-----\nID: $id\nUUDI: $uuid\nFIRSTNAME: $firstname\nLASTNAME: $lastname\nDATETIME: $timestampUpdated\n-----\n";
    }

    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'uuid': uuid,
            'firstname': firstname,
            'lastname': lastname,
            'qualification': qualification,
            'isactive': isActive ? 1 : 0,
            'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
            'timestamp_created': timestampCreated.millisecondsSinceEpoch,
        };
    }

    factory Person.fromMap(Map<String, dynamic> map) {
        return Person(
            id: map['id'],
            uuid: map['uuid'],
            firstname: map['firstname'],
            lastname: map['lastname'],
            qualification: map['qualification'],
            isActive: map['isactive'] == 1,
            timestampUpdated:
                DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
            timestampCreated:
                DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
        );
    }

    bool searchfound(String searchtext){
        if (searchtext.isEmpty) {
            return false;
        }
        else if (firstname.toLowerCase().contains(searchtext.toLowerCase()) ||
            lastname.toLowerCase().contains(searchtext.toLowerCase())) {
            return true;
        }
        else if (id.toString().contains(searchtext)) {
            return true;
        }
        else{
            return false;
        }
    }

    Person copyWith({
        int? id,
        int? uuid,
        String? firstname,
        String? lastname,
        int? qualification,
        bool? isActive,
        DateTime? timestampUpdated,
        DateTime? timestampCreated,
    }) {
        return Person(
            id: id ?? this.id,
            uuid: uuid ?? this.uuid,
            firstname: firstname ?? this.firstname,
            lastname: lastname ?? this.lastname,
            qualification: qualification ?? this.qualification,
            isActive: isActive ?? this.isActive,
            timestampUpdated: timestampUpdated ?? this.timestampUpdated,
            timestampCreated: timestampCreated ?? this.timestampCreated,
        );
    }
}

// Person Controller
class PersonController extends BaseController<Person> {

    PersonController(Database database) : super(database, 'person'){
        print("#-#-# Checking Person table #-#-#");
        
        database.execute('''
            CREATE TABLE IF NOT EXISTS person (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                uuid INTEGER NOT NULL,
                firstname TEXT NOT NULL,
                lastname TEXT NOT NULL,
                qualification INTEGER NOT NULL,
                isactive INTEGER NOT NULL,
                timestamp_updated INTEGER NOT NULL,
                timestamp_created INTEGER NOT NULL
            )
        ''');

        print("#-#-# Table person created #-#-#");
    }


    

    @override
    Future<int> insert(Person person) async {
        //print("#-#-# Insert: ${person.id};${person.lastname};${person.firstname};${person.timestampCreated};${person.timestampUpdated} #-#-#");
        print("#-#-# ${person.print()} #-#-#");
        return await database.insert(tableName, person.toMap());
    }

    ///Get All Persons from Database
    @override
    Future<List<Person>> getAll() async {
        final List<Map<String, dynamic>> maps = await database.query(tableName);
        print("#-#-# Table person all read | Act count: ${maps.length} #-#-#");
        return List.generate(maps.length, (i) => Person.fromMap(maps[i]));
    }


    // returns a list of sorted Pesons
    List<Person> textsearch(List<Person> list,String searchtext){

        List<Person> sorted=[];

        if(searchtext==""){return list;}


        for(int i=0; i<list.length;i++){

            if(list[i].searchfound(searchtext)){
                sorted.add(list[i]);
            }
        }

        return sorted;

    }


    ///Get Person By ID
    @override
    Future<Person?> getById(int id) async {

        final List<Map<String, dynamic>> maps = await database.query(
            tableName,
            where: 'id = ?',
            whereArgs: [id],
        );

        if (maps.isNotEmpty) {
            return Person.fromMap(maps.first);
        }
        return null;
    }

    ///Update a Existing Person
    @override
    Future<int> update(Person person) async {
        return await database.update(
            tableName,
            person.toMap(),
            where: 'id = ?',
            whereArgs: [person.id],
        );
    }

    

    @override
    Future<int> delete(int id) async {
        return await database.delete(
            tableName,
            where: 'id = ?',
            whereArgs: [id],
        );
    }

    @override
    Person fromMap(Map<String, dynamic> map) => Person.fromMap(map);

    ///@brief returns all Persons with the bollean is Active == True
    ///@return List<Person>
    Future<List<Person>> getActivePersons() async {

        final List<Map<String, dynamic>> maps = await database.query(
            tableName,
            where: 'isactive = ?',
            whereArgs: [1],
        );

        return List.generate(maps.length, (i) => Person.fromMap(maps[i]));
    }

    /// Returns all Persons with a specialized Qualification
    Future<List<Person>> getByQualification(int qualification) async {
        final List<Map<String, dynamic>> maps = await database.query(
            tableName,
            where: 'qualification = ?',
            whereArgs: [qualification],
        );
        return List.generate(maps.length, (i) => Person.fromMap(maps[i]));
    }

    ///Get a Person form their UUID istead of there ID
    Future<Person?> getByUuid(int uuid) async {

        final List<Map<String, dynamic>> maps = await database.query(
            tableName,
            where: 'uuid = ?',
            whereArgs: [uuid],
        );

        if (maps.isNotEmpty) {
            return Person.fromMap(maps.first);
        }

        return null;
    }
}





