import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config/phantomsxrConfig.dart';

class Utils {
  static final String baseAPIGatewayUrl = "https://phantomsxr.cn/api/v2/";
  static Future<dynamic> queryPhantomCloud(
      String apiAction, Map<String, String>? queryBody) async {
    Map<String, String> body = {};
    body['package_id'] = "com.phantomsxr.testapp";
    if (queryBody != null) body.addAll(queryBody);

    final response = await http.post(Uri.parse('$baseAPIGatewayUrl$apiAction'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': 'Token ${PhantomsXRConfig.TestToken}',
        },
        body: body);
    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Request Failed');
    }
  }
}
