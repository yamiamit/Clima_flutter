import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  late String url;

  Future getData() async {
    final data = await http.get(Uri.parse(url));
    if(data.statusCode == 200){
      String data1 = data.body;
      return jsonDecode(data1);

    } else{
      print(data.statusCode);
    }

  }



}