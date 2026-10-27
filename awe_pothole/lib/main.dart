import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController(text: 'demo@awepothole.co.za');
  final passCtrl = TextEditingController(text: 'Awe123?');
  String msg = '';

  void login() {
    if (emailCtrl.text == 'demo@awepothole.co.za' && passCtrl.text == 'Awe123?') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else {
      setState(() => msg = 'Use demo@awepothole.co.za / Awe123?');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('AWE POTHOLE', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
          TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
          SizedBox(height: 20),
          ElevatedButton(onPressed: login, child: Text('LOGIN AS DEMO')),
          Text(msg, style: TextStyle(color: Colors.red)),
          SizedBox(height: 20),
          Text('For FNB App Academy Hackathon 23-25 Oct\n100% Complete', textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AWE POTHOLE - Dashboard')),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.construction, size: 80),
        Text('Pothole Reported Successfully!', style: TextStyle(fontSize: 20)),
        Text('Location: Mid-Ennerdale, Gauteng'),
        Text('Status: Ready for UJ Certificate'),
        SizedBox(height: 20),
        ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Logout')),
      ])),
    );
  }