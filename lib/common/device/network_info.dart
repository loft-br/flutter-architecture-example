import 'package:connectivity/connectivity.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfo implements INetworkInfo {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> get isConnected async {
    var result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
