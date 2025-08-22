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



class PersonsPage extends StatefulWidget {

    const PersonsPage({super.key});

    @override
    _PersonsPageState createState() => _PersonsPageState();
}


enum SortBy { none, firstname, lastname, id }

class _PersonsPageState extends State<PersonsPage> {


   

    List<Person> _persons = [];
    String _searchText = '';
    SortBy _sortBy = SortBy.lastname;
    final TextEditingController _searchController = TextEditingController();

    @override
    void initState() {
        super.initState();
        contr_person = PersonController(SQLITE.database);
        _loadPersons();
    }

    Future<void> _loadPersons() async {
        List<Person> persons = await contr_person.getAll();
        setState(() {
            _persons = persons;
        });
    }

    List<Person> get _filteredPersons {


        return contr_person.textsearch(_persons,_searchText);

        /*
        List<Person> filtered = _persons.where((person) {
            return person.searchfound(_searchText);
        }).toList();

        filtered.sort((a, b) {
            if (_sortBy == SortBy.firstname) {
                return a.firstname.toLowerCase().compareTo(b.firstname.toLowerCase());
            } else {
                return a.lastname.toLowerCase().compareTo(b.lastname.toLowerCase());
            }
        });
        return filtered;*/

        //return _persons;
    }

    void _showEditDialog(Person person) {
        final TextEditingController firstnameController =
                TextEditingController(text: person.firstname);
        final TextEditingController lastnameController =
                TextEditingController(text: person.lastname);

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[900],
                title: Text('Bearbeiten', style: TextStyle(color: Colors.white)),
                content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        TextField(
                            controller: firstnameController,
                            decoration: InputDecoration(
                                labelText: 'Vorname',
                                labelStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white24),
                                ),
                            ),
                            style: TextStyle(color: Colors.white),
                        ),
                        TextField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                                labelText: 'Nachname',
                                labelStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white24),
                                ),
                            ),
                            style: TextStyle(color: Colors.white),
                        ),
                    ],
                ),
                actions: [
                    TextButton(
                        child: Text('Abbrechen', style: TextStyle(color: Colors.white54)),
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[700],
                        ),
                        child: Text('Speichern', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                            Person updated = person.copyWith(
                                firstname: firstnameController.text,
                                lastname: lastnameController.text,
                                timestampUpdated: DateTime.now(),
                            );
                            await contr_person.update(updated);
                            await _loadPersons();
                            Navigator.of(context).pop();
                        },
                    ),
                ],
            ),
        );
    }

    void _showDeleteDialog(Person person) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[900],
                title: Text('Löschen bestätigen', style: TextStyle(color: Colors.white)),
                content: Text(
                    'Möchten Sie ${person.firstname} ${person.lastname} wirklich löschen?',
                    style: TextStyle(color: Colors.white70),
                ),
                actions: [
                    TextButton(
                        child: Text('Abbrechen', style: TextStyle(color: Colors.white54)),
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                        ),
                        child: Text('Löschen', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                            if (person.id != null) {
                                await contr_person.delete(person.id!);
                                await _loadPersons();
                            }
                            Navigator.of(context).pop();
                        },
                    ),
                ],
            ),
        );
    }

    void _showAddPersonDialog() {
        final TextEditingController firstnameController = TextEditingController();
        final TextEditingController lastnameController = TextEditingController();
        final TextEditingController qualificationController = TextEditingController();
        bool PersonisActive=true;


        showDialog(
            context: context,
            builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (context, setState) {
                        
                         return AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: const Text('Person hinzufügen', style: TextStyle(color: Colors.white)),
                            content: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                        TextField(
                                            controller: firstnameController,
                                            decoration: const InputDecoration(
                                                labelText: 'Vorname',
                                                labelStyle: TextStyle(color: Colors.white70),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white24),
                                                ),
                                            ),
                                            style: const TextStyle(color: Colors.white),
                                        ),
                                        TextField(
                                            controller: lastnameController,
                                            decoration: const InputDecoration(
                                                labelText: 'Nachname',
                                                labelStyle: TextStyle(color: Colors.white70),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white24),
                                                ),
                                            ),
                                            style: const TextStyle(color: Colors.white),
                                        ),
                                        TextField(
                                            controller: qualificationController,
                                            decoration: const InputDecoration(
                                                labelText: 'Qualifikation (Zahl)',
                                                labelStyle: TextStyle(color: Colors.white70),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(color: Colors.white24),
                                                ),
                                            ),
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(color: Colors.white),
                                        ),
                                        Row(
                                            children: [
                                                Checkbox(
                                                    value: PersonisActive,
                                                    onChanged: (value) {
                                                        setState(() {
                                                            PersonisActive = value ?? false;
                                                        });
                                                    },
                                                    //activeColor: Colors.blueGrey[700],
                                                    //checkColor: Colors.white,

                                                    activeColor: Colors.green,
                                                    checkColor: Colors.blueGrey[900],
                                                    hoverColor: Colors.blue,
                                                ),
                                                const Text(
                                                    'Person Aktiv',
                                                    style: TextStyle(color: Colors.white70),
                                                ),
                                            ],
                                        ),
                                    ],
                                ),
                            ),
                            actions: [
                                TextButton(
                                    child: Text('Abbrechen', style: TextStyle(color: Colors.white54)),
                                    onPressed: () => Navigator.of(context).pop(),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        //backgroundColor: Colors.blueGrey[700],
                                        backgroundColor: Colors.green,
                                    ),
                                    child: Text('Hinzufügen', style: TextStyle(color: Colors.white)),
                                    onPressed: () async {
                                        if (firstnameController.text.isNotEmpty &&
                                            lastnameController.text.isNotEmpty &&
                                            int.tryParse(qualificationController.text) != null
                                        )
                                        {
                                            Person newPerson = Person(
                                                //uuid: DateTime.now().millisecondsSinceEpoch,
                                                uuid: 0,
                                                firstname: firstnameController.text,
                                                lastname: lastnameController.text,
                                                qualification: int.parse(qualificationController.text),
                                                isActive: true,
                                                timestampUpdated: DateTime.now(),
                                                timestampCreated: DateTime.now(),
                                            );
                                            await contr_person.insert(newPerson);
                                            await _loadPersons();
                                            Navigator.of(context).pop();
                                        }
                                    },
                                ),
                            ],
                        );
                    }
                );
            }
        );
    }

    void _showSortMenu() {
        showModalBottomSheet(
            context: context,
            backgroundColor: Colors.grey[900],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    ListTile(
                        leading: Icon(Icons.sort_by_alpha, color: Colors.white),
                        title: Text('Nach Vorname sortieren', style: TextStyle(color: Colors.white)),
                        onTap: () {
                            setState(() {
                                _sortBy = SortBy.firstname;
                            });
                            Navigator.of(context).pop();
                        },
                        selected: _sortBy == SortBy.firstname,
                        selectedTileColor: Colors.blueGrey[800],
                    ),
                    ListTile(
                        leading: Icon(Icons.sort_by_alpha, color: Colors.white),
                        title: Text('Nach Nachname sortieren', style: TextStyle(color: Colors.white)),
                        onTap: () {
                            setState(() {
                                _sortBy = SortBy.lastname;
                            });
                            Navigator.of(context).pop();
                        },
                        selected: _sortBy == SortBy.lastname,
                        selectedTileColor: Colors.blueGrey[800],
                    ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[950],
            appBar: AppBar(
                backgroundColor: Colors.grey[900],
                elevation: 0,
                title: Row(
                    children: [
                        Expanded(
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextField(
                                    controller: _searchController,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                        hintText: 'Suchen...',
                                        hintStyle: TextStyle(color: Colors.white54),
                                        border: InputBorder.none,
                                        prefixIcon: Icon(Icons.search, color: Colors.white54),
                                    ),
                                    onChanged: (value) {
                                        setState(() {
                                            _searchText = value;
                                        });
                                    },
                                ),
                            ),
                        ),
                        SizedBox(width: 12),
                        IconButton(
                            icon: Icon(Icons.settings, color: Colors.white),
                            onPressed: _showSortMenu,
                            tooltip: 'Sortieren',
                        ),
                    ],
                ),
            ),
            body: LayoutBuilder(
                builder: (context, constraints) {
                    return _filteredPersons.isEmpty
                            ? Center(
                                    child: Text(
                                        'Keine Personen gefunden.',
                                        style: TextStyle(color: Colors.white54, fontSize: 18),
                                    ),
                                )
                            : ListView.separated(
                                    padding: EdgeInsets.all(16),
                                    itemCount: _filteredPersons.length,
                                    separatorBuilder: (_, __) => Divider(color: Colors.white12),
                                    itemBuilder: (context, index) {
                                        final person = _filteredPersons[index];
                                        return Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey[850],
                                                borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: ListTile(
                                                title: Text(
                                                    '${person.firstname} ${person.lastname}',
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                                ),
                                                subtitle: Text(
                                                    'Qualifikation: ${person.qualification}',
                                                    style: TextStyle(color: Colors.white70),
                                                ),
                                                trailing: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                        IconButton(
                                                            icon: Icon(Icons.edit, color: Colors.blue[200]),
                                                            tooltip: 'Bearbeiten',
                                                            onPressed: () => _showEditDialog(person),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(Icons.delete, color: Colors.red[200]),
                                                            tooltip: 'Löschen',
                                                            onPressed: () => _showDeleteDialog(person),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        );
                                    },
                                );
                },
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blueGrey[700],
                child: Icon(Icons.add, color: Colors.white),
                onPressed: _showAddPersonDialog,
                tooltip: 'Person hinzufügen',
            ),
        );
    }
}

