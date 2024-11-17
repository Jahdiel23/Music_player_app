import 'package:flutter/material.dart';
import 'package:music_player_dreamteam/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

 @override
 Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // logo
          DrawerHeader(
            child: Center(
              child: Icon(
              Icons.music_note,
              size: 48,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          )
          ),

          //home titulo
          Padding(
            padding: const EdgeInsets.only(left:25.0, top: 25),
            child: ListTile(
              title: const Text("H O M E"),
              leading: const Icon(Icons.home),
              onTap: () => Navigator.pop(context)
            ),
          ),

          //configuracion titulo
            Padding(
            padding: const EdgeInsets.only(left:25.0, top: 0),
            child: ListTile(
              title: const Text("S E T T I N G S"),
              leading: const Icon(Icons.settings),
              onTap: () {
                //pop drawer
                Navigator.pop(context);

                    //navigate to settings
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),),);
              }     
            ),
          )
        ],),
    );
 }
}