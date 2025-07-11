import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:coinswitch/controller/user_wallet.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

final AllAvailableAddress allAvailableAddress = Get.put(AllAvailableAddress());
final UserWallet userWallet = Get.put(UserWallet());

class EthereumService {
  late final String rpcUrl;
  late final Web3Client client;
  late final EthPrivateKey credentials;

  EthereumService() {
    rpcUrl = dotenv.env['RPC_URL'] ?? '';
    if (rpcUrl.isEmpty) throw Exception('RPC_URL not found in .env');

    final privateKey = allAvailableAddress.userwalletPrivateKey.value;
    if (privateKey.isEmpty) throw Exception('Private key is empty');

    client = Web3Client(rpcUrl, Client());
    credentials = EthPrivateKey.fromHex(privateKey);
  }

  Future<String> sendEth(String toAddressHex, BigInt amountInEther) async {
    try {
      final toAddress = EthereumAddress.fromHex(toAddressHex);
      final sender = credentials.address;

      final gasPrice = await client.getGasPrice();
      final amountInWei = EtherAmount.fromBigInt(
        EtherUnit.ether,
        amountInEther,
      );

      final tx = Transaction(
        from: sender,
        to: toAddress,
        value: amountInWei,
        gasPrice: gasPrice,
        maxGas: 21000,
      );

      final txHash = await client.sendTransaction(
        credentials,
        tx,
        chainId: 1,
      );
      return txHash;
    } catch (e) {
      rethrow;
    }
  }
}
