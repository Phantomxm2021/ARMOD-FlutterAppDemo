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

  static Future<dynamic> getARExperienceProjects(
      String apiAction, int pageNum, int pageSize) async {
    Map<String, String> body = {};
    body['package_id'] = "com.phantomsxr.testapp";
    final response = await http.get(
        Uri.parse(
            '$baseAPIGatewayUrl$apiAction?page_num=$pageNum&page_size=$pageSize'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': 'Token ${PhantomsXRConfig.TestToken}',
        });
    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Request Failed');
    }
  }

  static Future<dynamic> getARExperienceDetail(String project_id) async {
    Map<String, String> body = {};
    body['package_id'] = "com.phantomsxr.testapp";
    body['project_id'] = project_id;

    final response =
        await http.post(Uri.parse('$baseAPIGatewayUrl/getarexperience'),
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
