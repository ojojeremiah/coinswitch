import 'package:coinswitch/controller/assets.dart';
import 'package:coinswitch/service/all_crypto.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../repository/repository.dart';
import 'dio.dart';

final getIt = GetIt.instance;
Future<void> setupApplication() async {
  getIt.registerSingleton(Dio());
  // getIt.registerSingleton(DioClient(getIt<Dio>()));
  // getIt.registerSingleton(AssetService(dioClient: getIt<DioClient>()));
  // getIt.registerSingleton<AssetRepository>(
  //     AssetRepository(assetService: getIt.get<AssetService>()));
  getIt.registerSingleton(AssetController());
}
