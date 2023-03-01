import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stumble/screens/chat_list_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:stumble/providers/auth.dart';
import 'package:stumble/providers/users.dart';
import 'package:stumble/screens/auth_screen.dart';
import 'package:stumble/screens/chat_screen.dart';
import 'package:stumble/screens/splash_screen.dart';

import 'services/locationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Users>(
          create: (_) => Users(null),
          update: (ctx, auth, pev) => Users(
            auth.token,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Stumble',
          // theme: theme.copyWith(
          //   primaryColor: Colors.lightBlueAccent[100],
          //   backgroundColor: Colors.blue,
          //   colorScheme: theme.colorScheme.copyWith(
          //     primary: Colors.blue,
          //     secondary: Colors.white,
          //   ),
          // ),
          home: auth.isAuth
              ? MyHomePage()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = TextButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stumble Home Page'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              TextButton.icon(
                style: style,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                },
                icon: const Icon(Icons.chat),
                label: const Text('Chat'),
              ),
              const SizedBox(width: 1), // add spacing between the buttons
              TextButton.icon(

                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                },
                icon: const Icon(Icons.exit_to_app, color: Colors.white),
                label: const Text("Logout", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              getCurrentPosition(context).then((position) => setState(() {
                _currentPosition = position;
              }));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChatListScreen()));
            },
            child: Text("Lat: ${_currentPosition?.latitude.toString() ?? ''} "
                "Lon: ${_currentPosition?.longitude.toString() ?? ''}"),
          ),
          const Text(
            'List of people nearby',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
