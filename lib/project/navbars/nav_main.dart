import 'package:flutter/material.dart';
import 'package:firecage_dart/project/data/models/persons.dart';
import 'package:firecage_dart/project/global/gobal_var.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Material(
        color: const Color.fromARGB(255, 33, 36, 40),
        //textStyle: TextStyle(color: Colors.blue),
        child: Column(
          //padding: const EdgeInsets.all(10.0),
          children: [
            const SizedBox(height: 15),
            const ListTile(
                title:Center(
                    child:Text(
                        "FireCage",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(200, 255, 255, 255),
                        ),
                    )
                )
            ),
            Center(child: Text(
                "Hilfestellung im Feuerwehrdienst",
                style: TextStyle(
                    fontSize: SZ.setWidthPerc(3),
                    color: const Color.fromARGB(200, 255, 255, 255)
                ),
            ),),
            const SizedBox(height: 5),
            const Divider(thickness: 2,color: Color.fromARGB(200, 255, 255, 255,)),

			Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

				Row(
                    children: [
              	        const SizedBox(width: 20),
              	        const Icon(Icons.person,color: Color.fromARGB(200, 255, 255, 255,)),
              	        const SizedBox(width: 15),
              	        RawMaterialButton(
                	        onPressed: (){
                  	            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PersonsPage()));
                	        },
                	        child: Center(
                                child: Text(
                                    "Benutzerverwaltung",
                                    style: TextStyle(
                                        fontSize: SZ.setWidthPerc(4),
                                        color: const Color.fromARGB(200, 255, 255, 255,)
                                    )
                                )
                            ),
              	        ),
            	    ],
                ),
                Row(
                    children: [
              	        const SizedBox(width: 20),
              	        const Icon(Icons.person,color: Color.fromARGB(200, 255, 255, 255,)),
              	        const SizedBox(width: 15),
              	        RawMaterialButton(
                	        onPressed: (){
                  	            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PersonsPage()));
                	        },
                	        child: Center(
                                child: Text(
                                    "Atemschutz Einsatz",
                                    style: TextStyle(
                                        fontSize: SZ.setWidthPerc(4),
                                        color: const Color.fromARGB(200, 255, 255, 255,)
                                    )
                                )
                            ),
              	        ),
            	    ],
                ),
							
			],),
            
            
            //const Divider(height: 2.0,),
            const Expanded(child: SizedBox()),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text("   Stefan L.  FireCage v0.0.1",style: TextStyle(fontSize: 17,color: Color.fromARGB(200, 255, 255, 255))),
            ),
            
          ],
        ),
      ),
    );
  }
}


Widget buildMenuItem({
  required String text,
  required IconData icon,
  required BuildContext context,
  VoidCallback? onClicked,
}){
  Color col=const Color.fromARGB(255, 255, 255, 255);
  
  return ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: SZ.setWidthPerc(10)),
    leading: Icon(icon,color: col,),
    title: Text(text,style: TextStyle(color: col,fontSize: SZ.setHeightPerc(2)),),
    onTap: onClicked,
  );
}