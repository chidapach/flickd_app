import '../models/app_config.dart';

//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';


class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  // ignore: non_constant_identifier_names
  late String _base_url;
  // ignore: non_constant_identifier_names
  late String _api_key;

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  // ignore: non_constant_identifier_names
  Future<Response> (String _path, {required Map<String, dynamic> query}) async {
    try{
      String _url = '$_base_url$_path';
      Map<String, dynamic> _query = {
        'api_key': _api_key,
        'language': 'en-US',
      };
      // ignore: unnecessary_null_comparison
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(_url, queryParameters: _query);
    } on DioError catch (e) {
        print('Unable to perform get request.');
        print('DioError:$e');
    }
  }
}