import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config/phantomsxrConfig.dart';

class Utils {
  static final String baseAPIGatewayUrl = "https://phantomsxr.cn/api/v2/";
  static Future<dynamic> queryPhantomCloud(String apiAction,String method ,Map<String, String>? queryBody) async {
    Map<String, String> body = {};
    final packageid="com.phantoms.armod";
    body['packageid'] = packageid;
    if (queryBody != null) body.addAll(queryBody);
    dynamic response = null;
    if(method=="POST"){
        response = await http.post(Uri.parse('$baseAPIGatewayUrl$apiAction'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization':'Token ${PhantomsXRConfig.AppToken}',
        },
        body: body);
    }else{
      response = await http.get(Uri.parse('$baseAPIGatewayUrl$apiAction?packageid=$packageid'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization':'Token ${PhantomsXRConfig.AppToken}',
        });
    }
    
    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Request Failed');
    }
  }
  
}
