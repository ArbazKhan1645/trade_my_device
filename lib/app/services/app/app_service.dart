import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../main.dart';

class AppService extends GetxService {
  late final SupabaseClient _supabaseClient;
  static AppService get instance => Get.find<AppService>();
  late final Stream<List<ConnectivityResult>> _connectivityResultStream;
  late final SharedPreferences _sharedPreferences;
  final _currentConnectivity = Rx<ConnectivityResult>(ConnectivityResult.none);
  late final FlutterSecureStorage _secureStorage;
  Future<AppService> init() async {
    await _init();
    return this;
  }

  Future<void> _init() async {
    await Supabase.initialize(
        realtimeClientOptions:
            const RealtimeClientOptions(logLevel: RealtimeLogLevel.info),
        url: currentEnv.supabaseUrl,
        anonKey: currentEnv.supabaseAnon);
    _supabaseClient = Supabase.instance.client;
    _connectivityResultStream =
        Connectivity().onConnectivityChanged.asBroadcastStream();
    _sharedPreferences = await SharedPreferences.getInstance();
    // _sharedPreferences.remove('currentPhone');
    _secureStorage = const FlutterSecureStorage();
    // await dotenv.load(fileName: ".env");
    _connectivityResultStream.listen((results) {
      if (results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi) ||
          results.contains(ConnectivityResult.ethernet)) {
        _currentConnectivity.value = results.firstWhere(
          (result) =>
              result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi ||
              result == ConnectivityResult.ethernet,
          orElse: () => ConnectivityResult.none,
        );
      } else {
        _currentConnectivity.value = ConnectivityResult.none;
      }
    });
  }

  SupabaseClient get supabaseClient {
    return _supabaseClient;
  }

  Stream<List<ConnectivityResult>> get connectivityResultStream =>
      _connectivityResultStream;

  ConnectivityResult get currentConnectivity => _currentConnectivity.value;

  bool get isInternetConnected =>
      currentConnectivity == ConnectivityResult.mobile ||
      currentConnectivity == ConnectivityResult.wifi ||
      currentConnectivity == ConnectivityResult.ethernet;

  /// shared prefrence instance
  SharedPreferences get sharedPreferences => _sharedPreferences;

  /// Secure Storage
  FlutterSecureStorage get secureStorage => _secureStorage;

  /// env value
  String? getEnv(String key) => dotenv.env[key];
}
