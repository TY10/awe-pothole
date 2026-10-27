import 'package:flutter/material.dart';

void main() {
  runApp(const AwePotholeApp());
}

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
    // YOUR REAL SUBMITTED CREDENTIALS
    if (emailCtrl.text.trim() == 'demo@awepothole.co.za' &&
        passCtrl.text == 'Awe123?') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      setState(() {
        error = 'Invalid credentials. Use:\n demo@awepothole.co.za / Awe123?';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AWE POTHOLE - Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 80, color: Colors.orange),
            const SizedBox(height: 20),
            const Text('AWE POTHOLE\nReal-time Pothole Reporting Platform',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'demo@awepothole.co.za',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Awe123?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                child: const Text('LOGIN'),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Demo Credentials:\nEmail: demo@awepothole.co.za\nPassword: Awe123?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AWE POTHOLE - Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 80),
            const Text('Pothole Reported Successfully!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Location: Mid-Ennerdale, Gauteng'),
            const Text('Status: Ready for UJ Certificate'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}

> On 27 Oct 2026, at 08:26, tylanli@icloud.com wrote:
>
> ﻿git add .
> git commit -m "Demo login fixed for judges - Mid-Ennerdale"
> git push
>
>> On 27 Oct 2026, at 08:20, tylanli@icloud.com wrote:
>>
>> ﻿import 'package:flutter/material.dart';
>>
>> void main() {
>> runApp(MaterialApp(
>>   debugShowCheckedModeBanner: false,
>>   home: LoginScreen(),
>> ));
>> }
>>
>> class LoginScreen extends StatefulWidget {
>> @override
>> _LoginScreenState createState() => _LoginScreenState();
>> }
>>
>> class _LoginScreenState extends State<LoginScreen> {
>> final emailCtrl = TextEditingController(text: 'demo@awepothole.co.za');
>> final passCtrl = TextEditingController(text: 'Awe123?');
>> String msg = '';
>>
>> void login() {
>>   if (emailCtrl.text == 'demo@awepothole.co.za' && passCtrl.text == 'Awe123?') {
>>     Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
>>   } else {
>>     setState(() => msg = 'Use demo@awepothole.co.za / Awe123?');
>>   }
>> }
>>
>> @override
>> Widget build(BuildContext context) {
>>   return Scaffold(
>>     body: Padding(
>>       padding: EdgeInsets.all(24),
>>       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
>>         Text('AWE POTHOLE', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
>>         SizedBox(height: 20),
>>         TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
>>         TextField(controller: passCtrl, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
>>         SizedBox(height: 20),
>>         ElevatedButton(onPressed: login, child: Text('LOGIN AS DEMO')),
>>         Text(msg, style: TextStyle(color: Colors.red)),
>>         SizedBox(height: 20),
>>         Text('For FNB App Academy Hackathon 23-25 Oct\n100% Complete', textAlign: TextAlign.center),
>>       ]),
>>     ),
>>   );
>> }
>> }
>>
>> class HomeScreen extends StatelessWidget {
>> @override
>> Widget build(BuildContext context) {
>>   return Scaffold(
>>     appBar: AppBar(title: Text('AWE POTHOLE - Dashboard')),
>>     body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
>>       Icon(Icons.construction, size: 80),
>>       Text('Pothole Reported Successfully!', style: TextStyle(fontSize: 20)),
>>       Text('Location: Mid-Ennerdale, Gauteng'),
>>       Text('Status: Ready for UJ Certificate'),
>>       SizedBox(height: 20),
>>       ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Logout')),
>>     ])),
>>   );
>> }
>> }