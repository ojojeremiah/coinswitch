import 'dart:developer';
import 'dart:typed_data';

import 'package:bitcoin_base/bitcoin_base.dart';
import 'package:blockchain_utils/hex/hex.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';
import 'package:xrpl_dart/xrpl_dart.dart';
import 'package:bs58check/bs58check.dart';

abstract class UserWalletAddress {
  Future<String> getWalletPrivateKey(String mnemonic);
  Future<EthereumAddress> getEthereumPublicKey(String privateAddress);
  Future getBitcoinbaseAddressPublicKey(String privateKey);
  Future getLitecoinbaseAddressPublicKey(String privateKey);
  Future getDogecoinbaseAddressPublicKey(String privateKey);
  Future getBitcoinCashbaseAddressPublicKey(String privateKey);
  Future getBitcoinSVbaseAddressPublicKey(String privateKey);
  Future getSolanaPublicKey(String privateKey);
  Future getDashPublicKey(String privateKey);
  Future getXrpPublicKey(String privateKey);
  Future getTronPublicKey(String privateKey);
}

class UserWallet extends GetxController implements UserWalletAddress {
  String privateAssetKey = "";

  @override
  Future<String> getWalletPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    privateAssetKey = privateKey;
    log(privateAssetKey);
    return privateKey;
  }

  @override
  Future<EthereumAddress> getEthereumPublicKey(String privateAddress) async {
    final private = EthPrivateKey.fromHex(privateAddress);
    final address = private.address;
    print("$address");
    return address;
  }

  @override
  Future getBitcoinbaseAddressPublicKey(String privateKey) async {
    final publicKey = ECPrivate.fromHex(privateKey);
    final p2pkh = publicKey.getPublic();
    final p2pkh1 = p2pkh.toSegwitAddress();
    final p2pwkhAddress = p2pkh1.toAddress(BitcoinNetwork.mainnet);
    print(p2pkh.toString().length);
    print("public key ${publicKey.toHex().length}");
    return p2pwkhAddress;
  }

  @override
  Future getLitecoinbaseAddressPublicKey(String privateKey) async {
    final publicKey = ECPrivate.fromHex(privateKey);
    final p2pkh = publicKey.getPublic();
    final p2pkh1 = p2pkh.toSegwitAddress();
    final p2pwkhAddress = p2pkh1.toAddress(LitecoinNetwork.mainnet);
    print(p2pkh.toString().length);
    print("public key ${publicKey.toHex().length}");
    return p2pwkhAddress;
  }

  @override
  Future getDogecoinbaseAddressPublicKey(String privateKey) async {
    final publicKey = ECPrivate.fromHex(privateKey);
    final p2pkh = publicKey.getPublic();
    final p2pkh1 = p2pkh.toAddress();
    final p2pwkhAddress = p2pkh1.toAddress(DogecoinNetwork.mainnet);
    print(p2pkh.toString().length);
    print("public key ${publicKey.toHex().length}");
    return p2pwkhAddress;
  }

  @override
  Future getBitcoinCashbaseAddressPublicKey(String privateKey) async {
    final publicKey = ECPrivate.fromHex(privateKey);
    final p2pkh = publicKey.getPublic();
    final p2pkh1 = p2pkh.toP2pkAddress();
    final p2pwkhAddress = p2pkh1.toAddress(BitcoinCashNetwork.mainnet);
    print(p2pkh.toString().length);
    print("public key ${publicKey.toHex().length}");
    return p2pwkhAddress.substring(12);
  }

  @override
  Future getBitcoinSVbaseAddressPublicKey(String privateKey) async {
    final publicKey = ECPrivate.fromHex(privateKey);
    final p2pkh = publicKey.getPublic();
    final p2pkh1 = p2pkh.toSegwitAddress();
    final p2pwkhAddress = p2pkh1.toAddress(BitcoinSVNetwork.mainnet);
    print(p2pkh.toString().length);
    print("public key ${publicKey.toHex().length}");
    return p2pwkhAddress;
  }

  @override
  Future getSolanaPublicKey(String privateKey) async {
    final keyPair = await Ed25519HDKeyPair.fromMnemonic(privateKey);
    final prKey = keyPair.address;
    List<int> bytes = base58decode(prKey);
    final publicKey = Ed25519HDPublicKey(bytes);
    return publicKey;
  }

  @override
  Future getDashPublicKey(String privateKey) async {
    final publicKey = ECPrivate.fromHex(privateKey);
    final p2pkh = publicKey.getPublic();
    final p2pkh1 = p2pkh.toAddress();
    final p2pwkhAddress = p2pkh1.toAddress(DashNetwork.mainnet);
    print(p2pkh.toString().length);
    print("public key ${publicKey.toHex().length}");
    return p2pwkhAddress;
  }

  @override
  Future<String> getXrpPublicKey(String privateKey) async {
    final private = XRPPrivateKey.fromHex(
      privateKey,
      algorithm: XRPKeyAlgorithm.ed25519,
    );

    final getPublicKey = private.getPublic();
    final addressClass = getPublicKey.toAddress();
    final xrpAddress = addressClass.address;

    log("===========================");
    log('$xrpAddress, xrpaddress');
    log("==============================");
    log('$addressClass, addressclass');
    log('==========================');

    final xAddress = addressClass.toXAddress(isTestnet: false);
    log('$xAddress');

    return xrpAddress;
  }

  @override
  Future getTronPublicKey(String privateKeyHex) async {
    final privateKey = BigInt.parse(privateKeyHex, radix: 16);
    final domainParams = ECCurve_secp256k1();
    final G = domainParams.G;
    final publicKey = G * privateKey;

    final x = publicKey!.x!.toBigInteger()!;
    final y = publicKey.y!.toBigInteger()!;

    final pubKeyBytes = Uint8List.fromList([
      0x04,
      ..._bigIntToBytes(x, 32),
      ..._bigIntToBytes(y, 32),
    ]);

    final hashed = sha3(pubKeyBytes.sublist(1)); // remove 0x04 prefix
    final addressHex = '41' +
        hex.encode(hashed).substring(0, 40); // Tron addresses start with '41'
    final addressBytes = hex.decode(addressHex);

// ✅ Use base58CheckEncode from bs58check package (not base58encode)
    final base58Address = base58CheckEncode(Uint8List.fromList(addressBytes));

    log("Tron address ==============$base58Address");

    return base58Address;
  }

  String base58CheckEncode(Uint8List input) {
    final hash0 = sha256.convert(input).bytes;
    final hash1 = sha256.convert(hash0).bytes;
    final checksum = hash1.sublist(0, 4);
    final addressBytes = Uint8List.fromList(input + checksum);
    return base58encode(addressBytes);
  }

  Uint8List sha3(Uint8List input) {
    final digest = KeccakDigest(256);

    return Uint8List.fromList(digest.process(input));
  }

  Uint8List _bigIntToBytes(BigInt number, int length) {
    final bytes = number.toRadixString(16).padLeft(length * 2, '0');
    return Uint8List.fromList(hex.decode(bytes));
  }
}
