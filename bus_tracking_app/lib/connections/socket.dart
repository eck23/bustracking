<<<<<<< HEAD
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../main.dart';
import '../values/values.dart';

late IO.Socket socket;
void connect() {
  socket = IO.io(url, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  socket.connect();

  socket.onConnect((data) {
    print("flutter connected to socket");

    socket.on('/message', (data) => print(data));

    socket.on('/filterstop', (data) {
      if (data != null) {
        stopProvider.stopsSearchList = data;
      }
    });
  });
}
=======
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../authentication/authfunctions.dart';
import '../main.dart';

late IO.Socket socket;
void connect() {
  socket = IO.io(url, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": false
  });

  socket.connect();

  socket.onConnect((data) {
    print("flutter connected to socket");

    socket.on('/message', (data) => print(data));
    socket.on('/datachange', (data) => print(data));
    socket.on('/filterstop', (data) {
      if (data != null) {
        stopProvider.stopsSearchList = data;
      }
    });
  });

  socket.emit('/listenDB', "hello im here");
}
>>>>>>> b2251873e23e2bbf9a14d70dabb52e12183ca44b
