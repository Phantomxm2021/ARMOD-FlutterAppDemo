import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'config/phantomsxrConfig.dart';

class Utils {
  static final String baseAPIGatewayUrl = "https://phantomsxr.com/api/v2/client/";
  static Future<dynamic> queryPhantomCloud(String apiAction,String method ,Map<String, String>? queryBody) async {
    final packageid="com.phantom.armod";
    final platform = Platform.isIOS ? "iOS":"Android";
  
    dynamic response = null;
    if(method=="POST"){
      Map<String, String> body = {};
      body['app_package_id'] = packageid;
      if (queryBody != null) body.addAll(queryBody);
      response = await http.post(Uri.parse('$baseAPIGatewayUrl$apiAction'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'authorization':'Token ${PhantomsXRConfig.AppToken}',
      },
      body: body);
    }else{
      String paramaters ="";
      if(queryBody!=null){
        queryBody.forEach((k,v)=>paramaters+='&${k}=${v}');
      }
      response = await http.get(Uri.parse('${baseAPIGatewayUrl}${apiAction}?app_package_id=${packageid}&platform=${platform}${paramaters}'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization':'Token ${PhantomsXRConfig.AppToken}',
        });
    }
   
    if (response.statusCode == 200) {
      dynamic responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Request Failed. \n Message:${response.body}\n Request url:${'$baseAPIGatewayUrl$apiAction?app_package_id=$packageid&platform=$platform'}');
    }
  }
  
}
