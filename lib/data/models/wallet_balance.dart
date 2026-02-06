class WalletBalance {
  final String chain;
  final String address;
  final List<TokenBalance> tokens;

  WalletBalance({
    required this.chain,
    required this.address,
    required this.tokens,
  });
}

class TokenBalance {
  final String tokenAddress;
  final String symbol;
  final int decimals;
  final String balance;

  TokenBalance({
    required this.tokenAddress,
    required this.symbol,
    required this.decimals,
    required this.balance,
  });
}