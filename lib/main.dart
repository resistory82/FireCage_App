//Main Imports
import 'package:flutter/material.dart';
//Package Imports
//Library Imports
import 'package:firecage_dart/project/global/gobal_var.dart';
import 'package:firecage_dart/library/controller/size_contr.dart';
import 'package:firecage_dart/library/controller/color_contr.dart';
import 'package:firecage_dart/project/navbars/nav_main.dart';
//Page Imports
import 'package:firecage_dart/project/views/00_startpage/PageStart.dart';




void main() {
    runApp(MyApp());
}


class MyApp extends StatelessWidget
{
  
  @override
  
  Widget build(BuildContext context)
  {
    //Set size Controller with Context
    SZ = SizeController(context);
    initGlobal();
    
    return MaterialApp(
      title:"Fire Cage Debug",
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF181818),
      ),
      home:const STARTSCREEN(),
    );
  }
}


/*
class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Fire Cage Demo',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: ThemeMode.system,
            home: const MyHomePage(),
            debugShowCheckedModeBanner: false,
    );
    
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

    
    ThemeMode _themeMode = ThemeMode.system;
    
    bool _switchValue = false;
    double _sliderValue = 50.0;
    int _selectedIndex = 0;
    final TextEditingController _textController = TextEditingController();
    DateTime? _selectedDate;
    TimeOfDay? _selectedTime;
    bool _isLoading = false;

    void _toggleLoading() {
        setState(() {
            _isLoading = !_isLoading;
        });
    }

    Future<void> _selectDate(BuildContext context) async {

        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025),
        );
        if (picked != null && picked != _selectedDate) {
            setState(() {
                _selectedDate = picked;
            });
        }
    }

    Future<void> _selectTime(BuildContext context) async {

        final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
        );
        if (picked != null && picked != _selectedTime) {
            setState(() {
                _selectedTime = picked;
            });
        }
  }


    @override
    Widget build(BuildContext context) {

        SZ = SizeController(context);
        
        return Scaffold(
            appBar: AppBar(
                title: const Text("Hello Test"),
                actions: [
                    IconButton(
                        icon: const Icon(Icons.brightness_4),
                        onPressed: () {
                            setState(() {
                                if (_themeMode == ThemeMode.dark){
                                    _themeMode= ThemeMode.light;
                                    
                                }
                                else if(_themeMode == ThemeMode.light){
                                    _themeMode == ThemeMode.dark;
                                }

                            });
                        },
                    ),
                ],
            ),
            NavDrawer: NavDrawer(),
            body:Theme(
                data: Theme.of(context).copyWith(
                    platform: TargetPlatform.android,
                ),
                child:  const SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child:Placeholder(),
                ),
            ),
            
        );
    }
}
*/