import '../utils.dart';

class PhantomsXRConfig {
  static String AppToken =
      "eyJhbGciOiJIUzUxMiIsImlhdCI6MTY0NjQwNzkxNSwiZXhwIjoxMDI4NjQwNzkxNX0.eyJwYWNrYWdlaWQiOiJjb20ucGhhbnRvbXMuYXJtb2QiLCJ1c2VyX3VpZCI6MTAxMjQ1MTU0M30.JS0QsLI6ebMVN_HA9v9U1CT4YMP3BU-IheBojNrBxi282HUWS0LK8w9mG7XPSSsOy-hBopHlw7sP-fa-6wroAA";
  static String AppConfig =
      '{"EngineType":"Native","dashboardConfig":{"dashboardGateway":"${Utils.baseAPIGatewayUrl}/getarresources","token":"${AppToken}","timeout":30,"maximumDownloadSize":30},"imageCloudRecognizerConfig":{"gateway":"","maximumOfRetries":5,"frequencyOfScan":5}}';
}
