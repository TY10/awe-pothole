import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

void main() { runApp(const AwePotholeApp()); }

class AwePotholeApp extends StatelessWidget {
  const AwePotholeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AWE POTHOLE',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String error = '';

  void login() {
    if (emailCtrl.text.trim() == 'demo@awepothole.co.za' && passCtrl.text.trim() == 'Awe123?') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
    } else {
      setState(() { error = 'Invalid credentials.\nEmail: demo@awepothole.co.za\nPassword: Awe123?'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.construction, size: 80, color: Colors.orange),
          const Text('AWE POTHOLE', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email - demo@awepothole.co.za', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: passCtrl, obscureText: true, decoration: const InputDecoration(labelText: 'Password - Awe123?', border: OutlineInputBorder())),
          if (error.isNotEmpty) Padding(padding: const EdgeInsets.all(8), child: Text(error, style: const TextStyle(color: Colors.red))),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, minimumSize: const Size(double.infinity, 50)), child: const Text('LOGIN')),
        ]),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FlutterTts tts = FlutterTts();
  String status = 'Scanning 300m... ACTIVE';
  double? lastDist;
  Set<String> warned = {};
  StreamSubscription<Position>? stream;
  List<Map<String, dynamic>> potholes = [
    {'id': 'r554', 'lat': -26.3492, 'lng': 27.8565, 'name': 'Golden Highway R554'},
  ];

  @override
  void initState() { super.initState(); initTts(); startGps(); }
  Future<void> initTts() async { await tts.setLanguage("en-ZA"); await tts.setSpeechRate(0.45); }
  Future<void> startGps() async {
    await Geolocator.requestPermission();
    stream = Geolocator.getPositionStream(locationSettings: const LocationSettings(distanceFilter: 10)).listen((pos) {
      for (var p in potholes) {
        double d = Geolocator.distanceBetween(pos.latitude, pos.longitude, p['lat'], p['lng']);
        if (d <= 300 && !warned.contains(p['id'])) {
          warned.add(p['id']);
          setState(() { status = 'VOICE: ${p['name']} in ${d.toInt()}m'; lastDist = d; });
          tts.speak("Warning! Pothole ahead in ${d.toInt()} meters near ${p['name']}. Slow down.");
        }
        if (d > 500) warned.remove(p['id']);
      }
    });
  }
  @override
  void dispose() { stream?.cancel(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AWE - 300m Voice Warning'), backgroundColor: Colors.orange),
      body: Column(children: [
        Container(color: Colors.black, width: double.infinity, padding: const EdgeInsets.all(16), child: Column(children: [Text(status, style: const TextStyle(color: Colors.greenAccent)), if (lastDist != null) Text('${lastDist!.toInt()}m', style: const TextStyle(color: Colors.white, fontSize: 28))])),
        Expanded(child: ListView(children: potholes.map((p) => ListTile(leading: const Icon(Icons.warning, color: Colors.red), title: Text(p['name']), subtitle: Text('Ennerdale - Demo Ready'), trailing: ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reported Successfully - Offline Saved'))); }, child: const Text('REPORT')))).toList())),
      ]),
    );
  }
}
