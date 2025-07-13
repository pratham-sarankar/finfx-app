import 'package:finfx/features/brokers/domain/models/binance_balance.dart';
import 'package:finfx/features/brokers/domain/models/delta_balance.dart';
import 'package:finfx/themes/theme.dart';
import 'package:flutter/material.dart';

class BrokerCard extends StatelessWidget {
  final String brokerName;
  final String logoPath;
  final bool isConnected;
  final dynamic balance;
  final bool isLoading;
  final VoidCallback onTap;

  const BrokerCard({
    Key? key,
    required this.brokerName,
    required this.logoPath,
    required this.isConnected,
    required this.balance,
    required this.isLoading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gradient = _getThemeGradient(context, colorScheme);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width:
            MediaQuery.of(context).size.width - 40, // Full width minus padding
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Left side - Logo and status
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        padding: brokerName == "Delta"
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            logoPath,
                            fit: BoxFit.contain,
                            width: brokerName == "Delta" ? 36 : null,
                            height: brokerName == "Delta" ? 36 : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            brokerName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color:
                                      isConnected ? Colors.green : Colors.grey,
                                  shape: BoxShape.circle,
                                  boxShadow: isConnected
                                      ? [
                                          BoxShadow(
                                            color: Colors.green
                                                .withValues(alpha: 0.5),
                                            blurRadius: 4,
                                            spreadRadius: 1,
                                          ),
                                        ]
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                isConnected ? "Connected" : "Disconnected",
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Right side - Balance or connection status
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isConnected && balance != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isLoading)
                              _buildShimmerLoader()
                            else
                              Text(
                                _formatBalance(balance),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Active",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Connect Now",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Tap to connect",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer loading effect for balance
  Widget _buildShimmerLoader() {
    return Container(
      width: 80,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Container(
            width: 80,
            height: 16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.3),
                  Colors.white.withValues(alpha: 0.1),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          Positioned.fill(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: -1.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value * 80, 0),
                  child: Container(
                    width: 40,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.white.withValues(alpha: 0.4),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Format balance based on broker type
  String _formatBalance(dynamic balance) {
    if (balance is BinanceBalance) {
      final totalBalance = balance.btcBalance + balance.btcLocked;
      if (totalBalance >= 1) {
        return "${totalBalance.toStringAsFixed(2)} BTC";
      } else {
        return "${(totalBalance * 1000).toStringAsFixed(0)} mBTC";
      }
    } else if (balance is DeltaBalance) {
      return "${balance.availableBalance.toStringAsFixed(2)} ${balance.asset}";
    }
    return "0.00";
  }

  // Generate theme-based gradient based on broker name
  LinearGradient _getThemeGradient(
      BuildContext context, ColorScheme colorScheme) {
    final brokerColors = Theme.of(context).extension<BrokerColors>();

    if (brokerName.toLowerCase().contains("meta trader 5") ||
        brokerName.toLowerCase().contains("mt5")) {
      // Vibrant blue gradient for MT5 using theme colors
      return LinearGradient(
        colors: [
          brokerColors?.mt5Primary ?? const Color(0xFF00D4FF),
          brokerColors?.mt5Secondary ?? const Color(0xFF0099CC),
          brokerColors?.mt5Tertiary ?? const Color(0xFF0066FF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (brokerName.toLowerCase().contains("meta trader 4") ||
        brokerName.toLowerCase().contains("mt4")) {
      // Vibrant orange gradient for MT4 using theme colors
      return LinearGradient(
        colors: [
          brokerColors?.mt4Primary ?? const Color(0xFFFF6B35),
          brokerColors?.mt4Secondary ?? const Color(0xFFFF8C42),
          brokerColors?.mt4Tertiary ?? const Color(0xFFFFA726),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      // Default gradient using app's primary colors
      return LinearGradient(
        colors: [
          colorScheme.primary,
          colorScheme.primaryContainer,
          colorScheme.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }
}
