import 'dart:convert';
import 'package:http/http.dart' as http;

import 'config/phantomsxrConfig.dart';

class Utils {
  static final String baseAPIGatewayUrl = "https://phantomsxr.cn/api/v2/";
  static Future<dynamic> queryPhantomCloud(
      String apiAction, Map<String, String>? queryBody) async {
    final response = await http.post(Uri.parse('$baseAPIGatewayUrl$apiAction'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': 'Token ${PhantomsXRConfig.AppToken}',
        });
    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Request Failed');
    }
  }

  static Future<dynamic> getARExperienceProjects(
      String apiAction, int pageNum, int pageSize) async {
    final response = await http.get(
        Uri.parse(
            '$baseAPIGatewayUrl$apiAction?page_num=$pageNum&page_size=$pageSize&packageid=com.phantoms.armod'),
        headers: <String, String>{
          'authorization': 'Token ${PhantomsXRConfig.AppToken}',
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
    body['package_id'] = "com.phantoms.armod";
    body['project_id'] = project_id;

    final response =
        await http.post(Uri.parse('$baseAPIGatewayUrl/getarexperience'),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
              'authorization': 'Token ${PhantomsXRConfig.AppToken}',
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
