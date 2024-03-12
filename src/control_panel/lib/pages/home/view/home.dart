import 'package:control_panel/pages/home/logic/controller.dart';
import 'package:flutter/material.dart';

import 'package:control_panel/pages/auth/view/auth.dart';
import 'package:control_panel/components/custom_stateicon.dart';
import 'package:control_panel/components/websocket.dart';
import 'package:control_panel/constants/constants.dart';

/// Defines the home page of the application with the video flux and the controls
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WebSocket _videoSocket = WebSocket(Constants.videoWebsocketURL);
  final WebSocket _chartWebsocketURL = WebSocket(Constants.chartWebsocketURL);

  bool isVideoToggled = false;
  bool isChartToggled = false;
  bool isRecording = false;
  bool isConnectedToController = false;
  String? wifiName;

  List<double> data = [1, 2, 3, 4, 5, 6, 4];

  void toggleStreaming({bool quit = false}) {
    setState(() {
      if (quit) {
        isVideoToggled = false;
      } else {
        isVideoToggled = !isVideoToggled;
      }
    });
    // ! DEBUG ONLY, reactivate right away
    //isVideoToggled ? _videoSocket.connect() : _videoSocket.disconnect();
    // ! DEBUG ONLY, reactivate right away
  }

  void toggleRecording({bool quit = false}) {
    setState(() {
      if (quit) {
        isRecording = false;
      } else {
        isRecording = !isRecording;
      }
    });
  }

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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1331F5),
        title: Image.asset(
          Constants.pathToHighCenteredLogo,
          width: 220,
          height: 100,
        ),
        actions: [
          Center(
            child: Row(children: [
              const Text(
                'WiFi: ',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Text(
                NetworkStatus.online ? "connecté " : "aucun ",
                style: TextStyle(
                  color: NetworkStatus.online
                      ? const Color.fromARGB(255, 105, 203, 109)
                      : const Color.fromARGB(255, 255, 101, 90),
                  fontSize: 20,
                ),
              ),
            ]),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('session admin'),
              accountEmail: const Text('the-travelers@outlook.com'),
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
              onTap: () {},
              trailing: StateIcon(isOn: isVideoToggled),
            ),
            ListTile(
              leading: const Icon(Icons.sensors),
              title: const Text('Données capteurs'),
              onTap: () => toggleRecording(),
              trailing: StateIcon(isOn: isRecording),
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety_outlined),
              title: const Text('Santé ordinateur de bord'),
              onTap: () => toggleConnectionToController(),
              trailing: StateIcon(isOn: isConnectedToController),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () {
                toggleStreaming(quit: true);
                toggleRecording(quit: true);
                toggleConnectionToController(quit: true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  SizedBox(height: height * 0.03),
                  Container(
                    width: width * 0.2,
                    height: height * 0.25,
                    color: Colors.blue,
                  ),
                  SizedBox(height: height * 0.008),
                  Container(
                    width: width * 0.2,
                    height: height * 0.25,
                    color: Colors.orange,
                  ),
                  SizedBox(height: height * 0.008),
                  Container(
                    width: width * 0.2,
                    height: height * 0.25,
                    color: Colors.green,
                  ),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: SizedBox(
                            width: 640,
                            height: 480,
                            child: Image.asset(Constants.pathToNoImages),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: height * 0.03),
                    IntrinsicWidth(
                      child: ElevatedButton(
                        onPressed: () => toggleStreaming(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              isVideoToggled
                                  ? 'Arrêter le flux vidéo'
                                  : 'Démarrer le flux vidéo',
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 5),
                            StateIcon(isOn: isVideoToggled),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: height * 0.03),
                  Container(
                    width: width * 0.2,
                    height: height * 0.25,
                    color: Colors.blue,
                  ),
                  SizedBox(height: height * 0.008),
                  Container(
                    width: width * 0.2,
                    height: height * 0.25,
                    color: Colors.orange,
                  ),
                  SizedBox(height: height * 0.008),
                  Container(
                    width: width * 0.2,
                    height: height * 0.25,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
