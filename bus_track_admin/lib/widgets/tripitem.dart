import 'package:bus_track_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:libserialport/libserialport.dart';
import 'dart:typed_data';

class TripItem extends StatefulWidget {
  late String tripName;
  late String id;

  TripItem(this.tripName, this.id);

  @override
  State<TripItem> createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {
  String portname = "";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: regDialogue,
      child: Material(
        elevation: 7,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Colors.white,
        shadowColor: Colors.red.shade900,
        child: Container(
          height: 40.h,
          width: 60.w,
          child: Center(
            child: Text(
              widget.tripName,
              style: tripItemFont,
            ),
          ),
        ),
      ),
    );
  }

  regDialogue() async {
    print(SerialPort.availablePorts);
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("PORT : $portname"),
              content: SizedBox(
                height: 200.h,
                width: 100.w,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () {
                        setState(
                            () => portname = SerialPort.availablePorts[index]);
                      },
                      textColor: Colors.black,
                      title: Text(SerialPort.availablePorts[index]),
                    );
                  }),
                  itemCount: SerialPort.availablePorts.length,
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      if (SerialPort.availablePorts.contains(portname)) {
                        regRFID();
                      }
                    },
                    child: const Text("REGISTER  RFID"))
              ],
            );
          });
        });
  }

  regRFID() {
    for (var name in SerialPort.availablePorts) {
      SerialPort(name).dispose();
    }
    print(SerialPort.availablePorts);
    SerialPort _serialPort = SerialPort(portname);

    print(_serialPort.address);

    if (_serialPort == null) {
      // print("exit");
      return;
    }
    if (_serialPort.open(mode: SerialPortMode.write)) {
      SerialPortConfig config = _serialPort.config;
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
    // *${widget.id}
    if (_serialPort.isOpen) {
      if (_serialPort.write(Uint8List.fromList(" *${widget.id}".codeUnits)) ==
          " *${widget.id}".codeUnits.length) {
        print("\ndata send");
        _serialPort.close();
        _serialPort.dispose();
      }
    }
  }
}
