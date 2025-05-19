// import 'package:coinswitch/service/cross_platform_websocket_core.dart';

import 'cross_platform_websocket_core.dart';

Future<WebSocketCore> connectSoc(String url, {List<String>? protocols}) =>
    throw UnsupportedError(
        'Cannot create a instance without dart:html or dart:io.');
