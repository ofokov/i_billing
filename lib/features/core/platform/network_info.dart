import 'package:connectivity_plus/connectivity_plus.dart';

import '../../ibilling/presentation/bloc/connection_bloc/connection_bloc.dart';
import '../../ibilling/presentation/bloc/connection_bloc/connection_event.dart';

class NetworkHelper {
  static void observeNetwork() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
