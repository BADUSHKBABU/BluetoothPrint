
import 'dart:typed_data';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter/cupertino.dart';
class PrintPage extends StatefulWidget {
  @override
  _PrintPageState createState() => _PrintPageState();
}
class _PrintPageState extends State<PrintPage> {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedDevice;
  bool _connected = false;
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;
  String ms = "";
  Uint8List imagetoprint=Uint8List(10000);
  GlobalKey _repaintKey = GlobalKey();
  String bodyresponse = "";
  String plaintext="";
  String data="";
  Uint8List imageBytes=Uint8List(0);
  Uint8List  ?screenshot;
  void initState() {
    super.initState();
    _initializeBluetooth();
  }
  void _initializeBluetooth() async {
    bool isAvailable = await bluetooth.isAvailable ?? false;
    if (isAvailable) {
      // Get connected device
      bluetooth.onStateChanged().listen((state) {
        if (state == BlueThermalPrinter.CONNECTED) {
          setState(() {
            _connected = true;
          });
        } else {
          setState(() {
            _connected = false;
          });
        }
      });

      // Get list of paired devices
      _getDevices();
    }
  }
  // Get the list of paired devices
  void _getDevices() async {
    List<BluetoothDevice> devices = await bluetooth.getBondedDevices();
    setState(() {
      _devices = devices;
    });
  }

  // Connect to a Bluetooth device
  void _connectToDevice() {
    if (_selectedDevice != null) {
      print("connected device :  $_selectedDevice");
      bluetooth.connect(_selectedDevice!);
    }
  }

  // Disconnect from the Bluetooth device
  void _disconnect() {
    bluetooth.disconnect();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: ListView(
            children: [
              DropdownButton<BluetoothDevice>(
                hint: Text('Select Device'),
                value: _selectedDevice,
                onChanged: (BluetoothDevice? device) {
                  setState(() {
                    _selectedDevice = device;
                  });
                },
                items: _devices.map((device) {
                  return DropdownMenuItem(
                    child: Text(device.name!),
                    value: device,
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _connected ? _disconnect : _connectToDevice,
                child: Text(_connected ? 'Disconnect' : 'Connect'),
              ),



              ElevatedButton(onPressed: ()
              {
                setState((){


                  //bluetooth.printCustom(_screenshotController.toString(), 2, 0);
                });
              }, child: Text("print")),
              if(screenshot!=null)...[  Container(height: 300,
                child: Image.memory(screenshot!,),)]else...[CircularProgressIndicator()]
            ]
        )
    );
  }
}
