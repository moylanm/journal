import 'package:flutter/material.dart';
import 'package:journal/app.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  @override
  Widget build(BuildContext context) {
    AppState? appState = context.findAncestorStateOfType<AppState>();

    return Drawer(
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 15),
              const Text('Settings', style: TextStyle(fontSize: 30)),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dark Mode', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Switch(
                    value: appState!.widget.preferences.getBool('isDarkMode')!,
                    onChanged: (value) {
                      appState.swapTheme();
                      setState(() {
                        value = appState.widget.preferences.getBool('isDarkMode')!;
                      });
                    },
                  )
                ],
              )
            ],
          );
        }
      ),
    );
  }
}