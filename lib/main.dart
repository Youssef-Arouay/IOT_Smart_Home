

import 'package:ac_control/mqtt.dart';
import 'package:flutter/material.dart';
import 'mqtt.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AC Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ACControlPage(),
    );
  }
}

class ACControlPage extends StatefulWidget {
  @override
  _ACControlPageState createState() => _ACControlPageState();
}

class _ACControlPageState extends State<ACControlPage> {
  String temperature = "Loading...";
  late MqttService mqttService;

  @override
  void initState() {
    super.initState();
    mqttService = MqttService(onTemperatureReceived: (temp) {
      setState(() {
        temperature = temp;
      });
    });
    mqttService.connect();
  }

  @override
  void dispose() {
    mqttService.disconnect();
    super.dispose();
  }
  void toggleAc(String status) {
    mqttService.publishMessage('ac/control', status); // Publish ON/OFF to the topic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AC Controller')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              onPressed: () => toggleAc('ON'),
              child: const Text('Turn AC ON'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => toggleAc('OFF'),
              child: const Text('Turn AC OFF'),
            ),
            const SizedBox(height: 20),
            Text(
              'Temperature: $temperature°C',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
    
  }
}


