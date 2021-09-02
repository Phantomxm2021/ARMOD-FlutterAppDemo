import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils {
  static final String baseAPIGatewayUrl = "https://weacw.com/api/v1/";
  static Future<dynamic> queryPhantomCloud(
      String apiAction, Map<String, String>? queryBody) async {
    Map<String, String> body = {};
    body['package_id'] = "com.phantoms.armod";
    if (queryBody != null) body.addAll(queryBody);

    final response = await http.post(Uri.parse('$baseAPIGatewayUrl$apiAction'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization':
              'Token eyJhbGciOiJIUzUxMiIsImlhdCI6MTYxODc2OTkzMSwiZXhwIjoxMDI1ODc2OTkzMX0.eyJwYWNrYWdlaWQiOiJjb20ucGhhbnRvbXMuYXJtb2QiLCJ1c2VyX3VpZCI6MTAxMjQ1MTU0M30.TZv-LKoNvQqnvpXKVDGhY7YNu1OFnazLBODbgdZydRsmyHD4z7Nd7kmi7Hbt4bLQndRcgGE_9IRvVjE64foCkQ',
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
