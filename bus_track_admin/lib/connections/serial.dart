import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:libserialport/libserialport.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // SerialPort? _serialPort;

  var send = 'h';

  clickme() {
    for (var name in SerialPort.availablePorts) {
      SerialPort(name).dispose();
    }
    print(SerialPort.availablePorts);
    SerialPort _serialPort = SerialPort('COM5');

    print(_serialPort.address);

    if (_serialPort == null) {
      print("exit");
      return;
    }
    // if (_serialPort.isOpen) {
    //   print("closing");
    //   _serialPort.close();
    //   print('${_serialPort.name} closed!');
    // } else {
    if (_serialPort.open(mode: SerialPortMode.write)) {
      SerialPortConfig config = _serialPort.config;
      // https://www.sigrok.org/api/libserialport/0.1.1/a00007.html#gab14927cf0efee73b59d04a572b688fa0
      // https://www.sigrok.org/api/libserialport/0.1.1/a00004_source.html
      config.baudRate = 9600;
      config.parity = 0;
      config.bits = 8;
      config.cts = 0;
      config.rts = 0;
      config.stopBits = 1;
      config.xonXoff = 0;
      _serialPort.config = config;
      if (_serialPort.isOpen) {
        debugPrint('${_serialPort.name} opened!');
      }
    }
    //   }

    if (_serialPort.isOpen) {
      if (_serialPort.write(Uint8List.fromList(send.codeUnits)) ==
          send.codeUnits.length) {
        print("\ndata send");
        _serialPort.close();
        _serialPort.dispose();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: clickme,
        child: Text("click me"),
      )),
    );
  }
}
