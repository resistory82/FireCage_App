import 'package:flutter/material.dart';


import 'package:firecage_dart/project/global/gobal_var.dart';
import 'package:firecage_dart/project/global/global_style.dart';


import 'package:firecage_dart/project/data/models/persons.dart';


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
                title: const Text('Bearbeiten', style: TextStyle(color: Colors.white)),
                content: Column(
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
                    ],
                ),
                actions: [
                    TextButton(
                        child: const Text('Abbrechen', style: TextStyle(color: Colors.white54)),
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey[700],
                        ),
                        child: const Text('Speichern', style: TextStyle(color: Colors.white)),
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
                title: const Text('Löschen bestätigen', style: TextStyle(color: Colors.white)),
                content: Text(
                    'Möchten Sie ${person.firstname} ${person.lastname} wirklich löschen?',
                    style: const TextStyle(color: Colors.white70),
                ),
                actions: [
                    TextButton(
                        child: const Text('Abbrechen', style: TextStyle(color: Colors.white54)),
                        onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                        ),
                        child: const Text('Löschen', style: TextStyle(color: Colors.white)),
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    ListTile(
                        leading: const Icon(Icons.sort_by_alpha, color: Colors.white),
                        title: const Text('Nach Vorname sortieren', style: TextStyle(color: Colors.white)),
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
                                    separatorBuilder: (_, __) => const Divider(color: Colors.white12),
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