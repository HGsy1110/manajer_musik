import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Music App', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: const Text('Add Artist/Song'),
            onTap: () {
              // Navigate to add screen
            },
          ),
          ListTile(
            title: const Text('Edit Artist/Song'),
            onTap: () {
              // Navigate to edit screen
            },
          ),
        ],
      ),
    );
  }
}
