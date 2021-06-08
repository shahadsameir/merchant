import 'dart:async';
import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class networkhelper {
  final url;
  final body;
  networkhelper(this.url, this.body);
  StreamSubscription<DataConnectionStatus> listener;
  Response data;
  Future postdata() async {
    DataConnectionStatus statuse = await checkinternet(listener);
    if (statuse == DataConnectionStatus.connected) {
      data = await http.post(url, body: body);
      if (data != null) {

        if (data.statusCode == 200) {

          return jsonDecode(data.body.toString());
        } else {

          return "somethingerror";
        }
      }
    } else {

      return "no intrnet";
    }
    await listener.cancel();
  }

}

checkinternet(StreamSubscription<DataConnectionStatus> listener) async {
  return await DataConnectionChecker().connectionStatus;
}
