import '../utils.dart';

class PhantomsXRConfig {
  static String AppToken =
      "eyJhbGciOiJIUzUxMiIsImlhdCI6MTY0NTAxMTEyNSwiZXhwIjoxMDI4NTAxMTEyNX0.eyJwYWNrYWdlaWQiOiJjb20ucGhhbnRvbXN4ci50ZXN0YXBwIiwidXNlcl91aWQiOjEwMTI0NTE1NDN9.hWDyMwhzhdjMvoOdZc6mfqHQDq-9-45OttCsZAGv-k51YV96wcTB48aM-JWZ47KgjQImBNJuC59BCxCSyUmfyw";
  static String AppConfig =
      '{"EngineType":"Native","dashboardConfig":{"dashboardGateway":"${Utils.baseAPIGatewayUrl}/getarresources","token":"${AppToken}","timeout":30,"maximumDownloadSize":30},"imageCloudRecognizerConfig":{"gateway":"","maximumOfRetries":5,"frequencyOfScan":5}}';
}
