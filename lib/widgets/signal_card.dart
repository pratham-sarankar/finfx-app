import 'package:finfx/models/signal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignalCard extends StatelessWidget {
  const SignalCard({
    super.key,
    required this.signal,
  });
  final Signal signal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        _showTradingDetailsBottomSheet(
          context: context,
          signal: signal,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    signal.pairName,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      text: "${signal.direction == "SHORT" ? "Sell" : "Buy"}",
                      children: [
                        TextSpan(
                          text: " at ",
                          style: TextStyle(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: signal.entryPrice.toStringAsFixed(2),
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        )
                      ],
                    ),
                    style: TextStyle(
                      color: signal.direction == "SHORT"
                          ? Colors.red
                          : const Color(0xff3794ff),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${signal.profitLoss.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: signal.profitLoss.isNegative
                        ? Colors.red
                        : Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (signal.entryTime != null)
                  Text(
                    DateFormat('dd MMM yyyy hh:mm:ss a')
                        .format(signal.entryTime!),
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTradingDetailsBottomSheet({
    required BuildContext context,
    required Signal signal,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.3,
          maxChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                // Drag handle bar
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 10),
                // Trade ID
                Text(
                  "#${signal.tradeId}",
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                // Scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top section with Pair, Action/Price, PnL, and Close Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    signal.bot?.name ?? 'Bot',
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          "${signal.direction == "SHORT" ? "Sell" : "Buy"}",
                                      children: [
                                        TextSpan(
                                          text: " at ",
                                          style: TextStyle(
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                        TextSpan(
                                          text: signal.entryPrice
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        )
                                      ],
                                    ),
                                    style: TextStyle(
                                      color: signal.direction == "SHORT"
                                          ? Colors.red
                                          : const Color(0xff3794ff),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${signal.profitLoss.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: signal.profitLoss.isNegative
                                        ? Colors.red
                                        : Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (signal.entryTime != null)
                                  Text(
                                    DateFormat('dd MMM yyyy hh:mm:ss a')
                                        .format(signal.entryTime!),
                                    style: TextStyle(
                                      color: colorScheme.onSurfaceVariant,
                                      fontSize: 12,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        if (signal.entryTime != null)
                          _buildDetailRow(
                            "Open time",
                            DateFormat('dd MMM yyyy hh:mm:ss a')
                                .format(signal.entryTime!),
                            context: context,
                          ),
                        _buildDetailRow(
                          "Open Price",
                          signal.entryPrice.toStringAsFixed(2),
                          context: context,
                        ),
                        if (signal.exitTime != null)
                          _buildDetailRow(
                            "Close time",
                            DateFormat('dd MMM yyyy hh:mm:ss a')
                                .format(signal.exitTime!),
                            context: context,
                          ),
                        if (signal.exitPrice != null)
                          _buildDetailRow(
                            "Close Price",
                            signal.exitPrice!.toStringAsFixed(2),
                            context: context,
                          ),
                        const SizedBox(height: 32),
                        // Close Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 204, 47, 47),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    required BuildContext context,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
