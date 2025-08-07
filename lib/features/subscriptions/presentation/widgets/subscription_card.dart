import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:finfx/features/subscriptions/data/models/subscription_model.dart';
import 'package:finfx/features/subscriptions/presentation/providers/subscriptions_provider.dart';

class SubscriptionCard extends StatelessWidget {
  final SubscriptionModel subscription;

  const SubscriptionCard({
    super.key,
    required this.subscription,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'active':
        return const Color(0xFF4CAF50);
      case 'paused':
        return const Color(0xFFFF9800);
      case 'expired':
        return const Color(0xFF9E9E9E);
      default:
        return const Color(0xFF607D8B);
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'Active';
      case 'paused':
        return 'Paused';
      case 'expired':
        return 'Expired';
      default:
        return 'Unknown';
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'active':
        return Icons.check_circle;
      case 'paused':
        return Icons.pause_circle;
      case 'expired':
        return Icons.schedule;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final formattedDate =
        DateFormat('MMM d, yyyy').format(subscription.subscribedAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: getStatusColor(subscription.status)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.smart_toy,
                        color: getStatusColor(subscription.status),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  subscription.bot.name,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 18,
                                    fontFamily: "Manrope-Bold",
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: getStatusColor(subscription.status)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: getStatusColor(subscription.status)
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getStatusIcon(subscription.status),
                                      color:
                                          getStatusColor(subscription.status),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      getStatusText(subscription.status),
                                      style: TextStyle(
                                        color:
                                            getStatusColor(subscription.status),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        fontFamily: "Manrope-SemiBold",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            subscription.bot.description,
                            style: TextStyle(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.7),
                              fontSize: 14,
                              fontFamily: "Manrope-Regular",
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 16,
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Subscribed: ',
                                style: TextStyle(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                  fontSize: 12,
                                  fontFamily: "Manrope-Regular",
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 12,
                                  fontFamily: "Manrope-SemiBold",
                                ),
                              ),
                            ],
                          ),
                          if ((subscription.status == 'active' ||
                                  subscription.status == 'paused') &&
                              subscription.expiresAt != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 16,
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Expires: ',
                                  style: TextStyle(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                    fontSize: 12,
                                    fontFamily: "Manrope-Regular",
                                  ),
                                ),
                                Text(
                                  DateFormat('MMM d, yyyy')
                                      .format(subscription.expiresAt!),
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 12,
                                    fontFamily: "Manrope-SemiBold",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (subscription.status == 'active' ||
                    subscription.status == 'paused') ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: subscription.status == 'active'
                        ? ElevatedButton(
                            onPressed: () => _pauseSubscription(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9800)
                                  .withValues(alpha: 0.1),
                              foregroundColor: const Color(0xFFFF9800),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: const Color(0xFFFF9800)
                                        .withValues(alpha: 0.3)),
                              ),
                            ),
                            child: const Text(
                              'Pause',
                              style: TextStyle(
                                fontFamily: "Manrope-SemiBold",
                                fontSize: 14,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () => _reactivateSubscription(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50)
                                  .withValues(alpha: 0.1),
                              foregroundColor: const Color(0xFF4CAF50),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: const Color(0xFF4CAF50)
                                        .withValues(alpha: 0.3)),
                              ),
                            ),
                            child: const Text(
                              'Reactivate',
                              style: TextStyle(
                                fontFamily: "Manrope-SemiBold",
                                fontSize: 14,
                              ),
                            ),
                          ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pauseSubscription(BuildContext context) async {
    final provider = context.read<SubscriptionsProvider>();
    final success =
        await provider.updateSubscriptionStatus(subscription.id, 'paused');

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subscription paused successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to pause subscription'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _reactivateSubscription(BuildContext context) async {
    final provider = context.read<SubscriptionsProvider>();
    final success =
        await provider.updateSubscriptionStatus(subscription.id, 'active');

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subscription reactivated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Failed to reactivate subscription'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
