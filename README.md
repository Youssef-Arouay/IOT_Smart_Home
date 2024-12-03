# IoT Remote Control for A/C Using ESP32

![ESP32 card](Interfaces/Screenshot%202024-12-02%20234148.png)

## Overview
This project demonstrates the use of IoT technologies to control a home air conditioner (A/C) remotely using an **ESP32 microcontroller**, **MQTT protocol**, **IR communication**, and a **DHT22 sensor**. The system allows the user to control the A/C via a **Flutter mobile application**. The ESP32 collects temperature and humidity data, sends commands to the A/C via infrared (IR), and provides real-time feedback.

## Technologies Used
- **ESP32**: A powerful microcontroller with built-in Wi-Fi and Bluetooth capabilities, used for managing sensors, controlling devices, and enabling network communication via MQTT.
- **Flutter**: A framework for building natively compiled applications for mobile, web, and desktop from a single codebase. Used here to create the mobile app for remote control.
- **MQTT**: A lightweight, publish-subscribe messaging protocol for small sensors and mobile devices, optimized for high-latency or unreliable networks.
- **DHT22**: A sensor for measuring ambient temperature and humidity.
- **IR LED and IR Receiver**: Used to simulate and receive infrared commands for A/C control, replicating a remote control functionality.

## Project Components

### 1. **Hardware**
- **ESP32**: Microcontroller to interface with sensors, handle MQTT communication, and control the A/C.
- **DHT22 Sensor**: Measures the ambient temperature and humidity.
- **IR LED**: Sends infrared signals to the A/C unit to control its operation (on/off).
- **IR Receiver**: Captures responses from the A/C unit to confirm if the command has been executed successfully.

### 2. **Software**
- **Flutter Mobile Application**: A simple app allowing the user to control the A/C by sending "Turn On" or "Turn Off" commands via MQTT. It also displays real-time temperature and humidity data received from the ESP32.
- **MQTT Broker**: The messaging protocol used for communication between the ESP32 and the Flutter app. It facilitates sending commands and receiving sensor data.
- **ESP32 Firmware**: Code running on the ESP32 to interact with sensors, communicate with the MQTT broker, and send IR signals to control the A/C.

## Functionality

### 1. **Manual Control**
- The user can manually turn the A/C on or off using the mobile app, which sends commands via MQTT to the ESP32. The ESP32 then sends the corresponding IR signal to the A/C.

### 2. **Automatic Control**
- In automatic mode, the system monitors the ambient temperature using the DHT22 sensor. If the temperature exceeds a predefined threshold (e.g., 26°C), the ESP32 automatically sends a command to turn on the A/C. Conversely, if the temperature drops below a threshold, the A/C is turned off.

### 3. **Communication Protocol**
- **MQTT**: The ESP32 subscribes to topics to receive commands (e.g., "turn_on_ac") and publishes sensor data (e.g., temperature and humidity) to the mobile app.
- **IR Communication**: The ESP32 sends infrared signals to simulate remote control commands for the A/C unit.

![MQTT Protocol](Interfaces/Screenshot%202024-12-02%20235730.png)


## Setup Instructions

### Hardware Setup:
1. **Connect the DHT22 sensor** to the ESP32 for temperature and humidity readings.
2. **Connect the IR LED** to the ESP32 to transmit IR commands to the A/C.
3. **Connect the IR Receiver** to the ESP32 to receive responses from the A/C unit.
4. **Power the ESP32** and ensure it's connected to a Wi-Fi network.

### Software Setup:
1. **Install Flutter**:
   Follow the official Flutter installation guide: https://flutter.dev/docs/get-started/install

2. **ESP32 Firmware**:
   - Install the [Arduino IDE](https://www.arduino.cc/en/software) and the ESP32 board support package.
   - Upload the ESP32 firmware to the board, which handles reading the DHT22 sensor, communicating via MQTT, and sending IR commands.

3. **Flutter App**:
   - Clone the repository and open it in your preferred IDE (e.g., Visual Studio Code).
   - Ensure that you have the necessary dependencies installed (e.g., `mqtt_client` for MQTT communication).
   - Run the app on a connected mobile device or emulator.

4. **MQTT Broker**:
   - Set up an MQTT broker, such as [Mosquitto](https://mosquitto.org/), or use a cloud MQTT service (e.g., HiveMQ or AWS IoT).
   - Configure both the ESP32 and the Flutter app to connect to the broker.

### Running the Project:
1. After the app is set up and the ESP32 is connected to the Wi-Fi, you can start controlling the A/C from the mobile app.
2. You can monitor the temperature and humidity data in real-time and adjust the A/C settings accordingly.

## Circuit Diagram

The following diagram shows the circuit connections for the IoT Remote Control system for A/C:

![Circuit Diagram](Interfaces/Screenshot%202024-12-03%20163917.png)
