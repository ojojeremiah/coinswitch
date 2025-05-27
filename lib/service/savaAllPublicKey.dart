import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AllPublicKey {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String bitcoinPublicKey = "";
  String ethereumPublicKey = "";
  String litecoinPublickKey = "";
  String dogeCoinPulicKey = "";
  String solanaPublicKey = "";
  String bitcoincashPublicKey = "";
  String xrpPublicKey = "";

  //Save BitcoinPublicKey
  Future<void> loadBitcoinAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'bitcoinPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      bitcoinPublicKey = assetDataMnemonic;
    }
  }

  Future<void> setBitcoinAddress(String key) async {
    await _storage.write(key: 'bitcoinPublicKey', value: key);
  }

  Future<String> getBitcoinData() async {
    await loadBitcoinAddress();
    return bitcoinPublicKey;
  }

  //Save EthereumPublicKey
  Future<void> loadEthereumAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'ethereumPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      ethereumPublicKey = assetDataMnemonic;
    }
  }

  Future<void> setEthereumAddress(String key) async {
    await _storage.write(key: 'ethereumPublicKey', value: key);
  }

  Future<String> getEthereumData() async {
    await loadEthereumAddress();
    return ethereumPublicKey;
  }

  //Save LitecoinPublicKey
  Future<void> loadLitecoinAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'litecoinPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      litecoinPublickKey = assetDataMnemonic;
    }
  }

  Future<void> setLitecoinAddress(String key) async {
    await _storage.write(key: 'litecoinPublicKey', value: key);
  }

  Future<String> getLitecoinData() async {
    await loadLitecoinAddress();
    return litecoinPublickKey;
  }

  // Save DogecoinPublicKey
  Future<void> loadDogeAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'dogecoinPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      dogeCoinPulicKey = assetDataMnemonic;
    }
  }

  Future<void> setDogeAddress(String key) async {
    await _storage.write(key: 'dogecoinPublicKey', value: key);
  }

  Future<String> getDogeData() async {
    await loadDogeAddress();
    return dogeCoinPulicKey;
  }

  // Save SolanaPublicKey
  Future<void> loadSolanaAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'solanaPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      solanaPublicKey = assetDataMnemonic;
    }
  }

  Future<void> setSolanaAddress(String key) async {
    await _storage.write(key: 'solanaPublicKey', value: key);
  }

  Future<String> getSolanaData() async {
    await loadSolanaAddress();
    return solanaPublicKey;
  }

  // Save BitcoincashPublicKey
  Future<void> loadBitcoincashAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'BitcoincashPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      bitcoincashPublicKey = assetDataMnemonic;
    }
  }

  Future<void> setBitcoincashAddress(String key) async {
    await _storage.write(key: 'BitcoincashPublicKey', value: key);
  }

  Future<String> getBitcoincashData() async {
    await loadBitcoincashAddress();
    return bitcoincashPublicKey;
  }

  // Save XrpPublicKey
  Future<void> loadXrpAddress() async {
    final String? assetLoadPrivateKey =
        await _storage.read(key: 'xrpPublicKey');
    if (assetLoadPrivateKey != null) {
      final String assetDataMnemonic = assetLoadPrivateKey;
      bitcoincashPublicKey = assetDataMnemonic;
    }
  }

  Future<void> setXrpAddress(String key) async {
    await _storage.write(key: 'xrpPublicKey', value: key);
  }

  Future<String> getXrpData() async {
    await loadXrpAddress();
    return xrpPublicKey;
  }
}
