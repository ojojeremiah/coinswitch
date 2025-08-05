import 'package:coinswitch/controller/allavailableadress.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class EthereumUsdtService {
  String? rpcUrl;
  Web3Client? client;
  EthPrivateKey? credentials;

  DeployedContract? usdtContract;
  ContractFunction? transferFunction;

  final AllAvailableAddress allAvailableAddress =
      Get.put(AllAvailableAddress());

  Future<void> initialize() async {
    rpcUrl = dotenv.env['RPC_URL'] ?? '';
    if (rpcUrl!.isEmpty) throw Exception('RPC_URL not found in .env');

    final privateKey = allAvailableAddress.userwalletPrivateKey.value;
    if (privateKey.isEmpty) throw Exception('Private key is empty');

    client = Web3Client(rpcUrl!, Client());
    credentials = EthPrivateKey.fromHex(privateKey);

    // Load USDT contract
    final usdtAbi = dotenv.env['USDT_ABI'];
    final usdtContractAddress = dotenv.env['ETHER_USDT_CONTRACT_ADDRESS'];
    if (usdtAbi == null || usdtContractAddress == null) {
      throw Exception('USDT_ABI or USDT_CONTRACT_ADDRESS missing from .env');
    }

    usdtContract = DeployedContract(
      ContractAbi.fromJson(usdtAbi, 'USDT'),
      EthereumAddress.fromHex(usdtContractAddress),
    );

    transferFunction = usdtContract!.function('transfer');
  }

  Future<String> sendUsdt(String toAddressHex, double amountInUsdt) async {
    try {
      await initialize();

      if (amountInUsdt <= 0) {
        throw ArgumentError('amountInUsdt must be greater than 0');
      }

      final sender = await credentials!.extractAddress();
      final toAddress = EthereumAddress.fromHex(toAddressHex);
      final gasPrice = await client!.getGasPrice();

      // Convert USDT to 6 decimals (USDT has 6 decimals)
      final amount = BigInt.from(amountInUsdt * 1e6);

      // Calculate fee (1.85% of USDT in ETH)
      final feeEthReceiverHex = dotenv.env['ETHEREUM_FEE_ADDRESS'];
      if (feeEthReceiverHex == null || feeEthReceiverHex.isEmpty) {
        throw Exception('ETHEREUM_FEE_ADDRESS not found in .env');
      }

      final feeReceiver = EthereumAddress.fromHex(feeEthReceiverHex);
      final feeInUsdt = amount * BigInt.from(185) ~/ BigInt.from(10000);
      final sendAmount = amount - feeInUsdt;

      if (sendAmount <= BigInt.zero) {
        throw Exception("Amount too small after fee deduction.");
      }

      // USDT transfer: send to recipient
      final tx1 = Transaction.callContract(
        contract: usdtContract!,
        function: transferFunction!,
        parameters: [toAddress, sendAmount],
        from: sender,
        gasPrice: gasPrice,
        maxGas: 60000,
      );

      final txHash1 = await client!.sendTransaction(
        credentials!,
        tx1,
        chainId: 1, // mainnet
      );

      // USDT transfer: fee to platform
      final tx2 = Transaction.callContract(
        contract: usdtContract!,
        function: transferFunction!,
        parameters: [feeReceiver, feeInUsdt],
        from: sender,
        gasPrice: gasPrice,
        maxGas: 60000,
      );

      await client!.sendTransaction(
        credentials!,
        tx2,
        chainId: 1,
      );

      return txHash1;
    } catch (e, st) {
      print('sendUsdt error: $e');
      print(st);
      rethrow;
    }
  }

  void dispose() {
    client?.dispose();
  }
}
