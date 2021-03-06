import 'dart:convert';
import 'package:bitcoin_ticker/coin_data.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response =
        await http.get(url, headers: {"X-CoinAPI-Key": apiKey});

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
