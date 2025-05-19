class Endpoints {
  Endpoints._();
  static const int receiveTimeout = 15000;
  static const int connectionTimeout = 15000;
  static const allNfts =
      "https://api.opensea.io/api/v2/collections?chain=ethereum&include_hidden=true&limit=20&order_by=market_cap";
  static const openseakey = "82da87acaf1045a7aa12da281bfd29ad";
  static const allProducts =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
  static const assetBalanceHead = "https://api.blockcypher.com/v1";
  static const assetBalanceNetworkForDoge = "/doge";
  static const assetBalanceNetworkforBitcoin = "/btc";
  static const assetBalanceNetworkforLitecoin = "/ltc";
  static const assetBalanceNetworkforEthereum = "/eth";
  static const assetBalanceMiddle = "/main/addrs/";
  static const assetBalanceTail = "/balance";
  static const bscapisac = "https://api.bscscan.com/api?";
  static const bnbAPIKey = "VAY4Z3G84QVW3N1JTBWMNGWAHET7GNJT9C";
  static const solanaBalance =
      "https://solana-gateway.moralis.io/account/mainnet/";
  static const solanaBalanceTail = "/portfolio";
  static const solanaAPIKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJub25jZSI6IjVjMTZhZTJkLTEwNmQtNDk3YS04MzEyLTZmMjJlNTFhNDBmOCIsIm9yZ0lkIjoiMzg4MDk4IiwidXNlcklkIjoiMzk4Nzg4IiwidHlwZUlkIjoiMjk3NGE2MzItOWRhYy00MzVkLWE5NmYtYmU0N2I1NjEwMzAzIiwidHlwZSI6IlBST0pFQ1QiLCJpYXQiOjE3MTMyMTg3OTUsImV4cCI6NDg2ODk3ODc5NX0.Qn4XnIKiGTad54oEtZMkHwzXhWX9Xw6u_acIWDsDCEc";
  static const exchangeRatehead =
      'https://api.coingecko.com/api/v3/simple/price?ids=';
  static const exchangeRatetail = '&vs_currencies=usd';
}
