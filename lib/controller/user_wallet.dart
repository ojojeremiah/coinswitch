import 'package:bitcoin_base/bitcoin_base.dart';
import 'package:get/get.dart';
import 'package:solana/base58.dart';
import 'package:solana/solana.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:hex/hex.dart';

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
}

class UserWallet extends GetxController implements UserWalletAddress {
  String privateAssetKey = "";

  @override
  Future<String> getWalletPrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final privateKey = HEX.encode(master.key);
    privateAssetKey = privateKey;
    print(privateAssetKey);
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
}
