import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class userMnemonic {
  String generateMnemonic() {
    return bip39.generateMnemonic();
  }

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String walletMnemonic = "";

  Future<void> loadAssetMnemonic() async {
    final String? assetLoadPrivateKey = await _storage.read(key: 'mnemonic');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      walletMnemonic = assetDataMnemonic;
    }
  }

  Future<void> seAssettMnemonic(String mnemonic) async {
    await _storage.write(key: 'mnemonic', value: mnemonic);
  }

  Future<String> getAssetsData() async {
    await loadAssetMnemonic();
    return walletMnemonic;
  }

  // Future<void> _saveMnemonic() async {
  //   final String assetData = _walletMnemonic;
  //   await _storage.write(key: 'privateKey', value: jsonEncode(assetData));
  // }
}
