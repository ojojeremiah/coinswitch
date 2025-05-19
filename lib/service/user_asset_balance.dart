import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:coinswitch/model/availablecrypto.dart';

class UserAssetBalance {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  List<Availablecrypto> _assetsStorage = [];

  // Save assets list to storage
  Future<void> _saveAsset() async {
    try {
      final String assetData = jsonEncode(_assetsStorage.map((asset) => asset.toJson()).toList());
      await _storage.write(key: 'CryptoData', value: assetData);
    } catch (e) {
      log('Error saving assets: $e');
    }
  }

  // Load assets list from storage
  Future<void> _loadAsset() async {
    try {
      String? assetDataStr = await _storage.read(key: 'CryptoData');
      if (assetDataStr != null) {
        final List<dynamic> assetJsonList = jsonDecode(assetDataStr);
        _assetsStorage = assetJsonList.map((itemJson) => Availablecrypto.fromJson(itemJson)).toList();
      }
    } catch (e) {
      log('Error loading assets: $e');
    }
  }

  // Save a given list of assets to storage
  Future<void> _saveAssetsToStorage(List<Availablecrypto> items) async {
    try {
      final String assetData = jsonEncode(items.map((asset) => asset.toJson()).toList());
      log(assetData);
      await _storage.write(key: 'CryptoData', value: assetData);
    } catch (e) {
      log('Error saving assets to storage: $e');
    }
  }

  // Retrieve the current list of assets
  Future<List<Availablecrypto>> getAssetsData() async {
    await _loadAsset();
    return _assetsStorage;
  }

  // Add a new asset to the list and save it
  Future<void> addAsset(Availablecrypto asset) async {
    _assetsStorage.add(asset);
    await _saveAsset();
  }

  // Update the stored assets list with a new list
  Future<void> updateAsset(List<Availablecrypto> assets) async {
    _assetsStorage = assets;
    await _saveAsset();
  }

  // Remove an asset from the list and save the updated list
  Future<void> removeAsset(Availablecrypto asset) async {
    _assetsStorage.remove(asset);
    await _saveAsset();
  }
}
