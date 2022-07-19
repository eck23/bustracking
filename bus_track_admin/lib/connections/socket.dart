import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../main.dart';

import '../values/url.dart';

late IO.Socket socket;
void connect() {
  socket = IO.io(localurl, <String, dynamic>{
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
