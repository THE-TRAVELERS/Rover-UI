import 'package:control_panel/constants/constants.dart';
import 'package:control_panel/pages/auth/view/auth.dart';
import 'package:control_panel/pages/health/view/health.dart';
import 'package:control_panel/pages/home/view/home.dart';
import 'package:flutter/material.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  bool isConnectedToController = false;

  void toggleConnectionToController({bool quit = false}) {
    setState(() {
      if (quit) {
        isConnectedToController = false;
      } else {
        isConnectedToController = !isConnectedToController;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.pathToHighCenteredLogo,
          width: 200,
          height: 100,
        ),
        backgroundColor: const Color(0xFF1331F5),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('admin'),
              accountEmail: const Text('travelersesilv@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    Constants.pathToProfilePicture,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: const BoxDecoration(color: Color(0xFF1331F5)),
            ),
            ListTile(
              leading: const Icon(Icons.emergency_recording),
              title: const Text('Acceuil'),
              onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  ),
            ),
            ListTile(
              leading: const Icon(Icons.emergency_recording),
              title: const Text('Données capteurs'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.control_camera),
              title: const Text('Santé ordinateur de bord'),
              onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HealthPage(),
                    ),
                  ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () {
                toggleConnectionToController(quit: true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 25),
              Text(
                'Bienvenue dans la section des capteurs.',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
