// import 'package:flutter/material.dart';

// import 'package:ramp_flutter/configuration.dart';
// import 'package:ramp_flutter/offramp_sale.dart';
// import 'package:ramp_flutter/onramp_purchase.dart';
// import 'package:ramp_flutter/ramp_flutter.dart';
// import 'package:ramp_flutter/send_crypto_payload.dart';


// class RampDemoApp extends StatefulWidget {
//   const RampDemoApp({Key? key}) : super(key: key);

//   @override
//   State<RampDemoApp> createState() => _RampDemoAppState();
// }

// class _RampDemoAppState extends State<RampDemoApp> {
//   @override
//   Widget build(BuildContext context) => MaterialApp(home: _RampDemo());
// }

// class _RampDemo extends StatefulWidget {
//   const _RampDemo({Key? key}) : super(key: key);

//   @override
//   State<_RampDemo> createState() => _RampDemoState();
// }

// class _RampDemoState extends State<_RampDemo> {
//   late final RampFlutter ramp;
//   late final Configuration configuration;

//   @override
//   void initState() {
//     super.initState();
//     configuration = Configuration();
//     configuration.hostApiKey = 'YOUR_API_KEY';
//     configuration.hostAppName = "Ramp Flutter";
//     configuration.hostLogoUrl = "https://ramp.network/logo.png";
//     configuration.enabledFlows = ["ONRAMP", "OFFRAMP"];

//     ramp = RampFlutter();
//     ramp.onOnrampPurchaseCreated = onOnrampPurchaseCreated;
//     ramp.onSendCryptoRequested = onSendCryptoRequested;
//     ramp.onOfframpSaleCreated = onOfframpSaleCreated;
//     ramp.onRampClosed = onRampClosed;
//   }

//   _presentRamp() {
//     ramp.showRamp(configuration);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _presentRamp,
//         child: const Text("Present Ramp"),
//       ),
//     );
//   }

//   void onOnrampPurchaseCreated(
//       OnrampPurchase purchase,
//       String purchaseViewToken,
//       String apiUrl,
//       ) {}

//   void onSendCryptoRequested(SendCryptoPayload payload) {}

//   void onOfframpSaleCreated(
//       OfframpSale sale,
//       String saleViewToken,
//       String apiUrl,
//       ) {}

//   void onRampClosed() {}
// }
