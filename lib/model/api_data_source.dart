import 'package:responsi/model/base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadJobs() {
    return BaseNetwork.get("remote-jobs");
  }
}
