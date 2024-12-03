import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:flutter/material.dart';

class MqttService {
  late MqttServerClient client;
  late Function(String) onTemperatureReceived; // Callback to update UI with temperature

  MqttService({required this.onTemperatureReceived}) {
    client = MqttServerClient('broker.hivemq.com', 'flutter_mqtt_client');
    client.port = 1883;
    client.logging(on: true);
    client.keepAlivePeriod = 20;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  Future<void> connect() async {
    try {
      final connMessage = MqttConnectMessage()
          .withClientIdentifier('flutter_mqtt_client')
          .startClean()
          .withWillTopic('will/topic')
          .withWillMessage('Disconnected')
          .withWillQos(MqttQos.atLeastOnce);
      client.connectionMessage = connMessage;

      print('Connecting to MQTT broker...');
      await client.connect();
    } catch (e) {
      print('Connection failed: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connected to MQTT broker!');
      subscribeToTopic('home/temperature');
    } else {
      print('Connection failed with status: ${client.connectionStatus!.state}');
      client.disconnect();
    }
  }

  void subscribeToTopic(String topic) {
    print('Subscribing to topic: $topic');
    client.subscribe(topic, MqttQos.atLeastOnce);
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>> events) {
      final MqttPublishMessage recMessage = events[0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);

      print('Received message: $payload from topic: ${events[0].topic}');
      onTemperatureReceived(payload); // Update the temperature in the app
    });
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    print('Published message: "$message" to topic: "$topic"');
  }

  void disconnect() {
    client.disconnect();
    print('Disconnected from MQTT broker');
  }

  void _onDisconnected() {
    print('MQTT client disconnected');
  }

  void _onConnected() {
    print('MQTT client connected');
  }

  void _onSubscribed(String topic) {
    print('Subscribed to topic: $topic');
  }
}
