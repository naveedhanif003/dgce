import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showLogoutDialog(
  BuildContext context,
  VoidCallback onLogout,
) async {
  return showDialog(
    context:context,
    builder:
        (context) => AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onLogout();
              },
              child: Text("Logout", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
  );
}
