import 'package:finfx/features/bot/presentation/screen/bot_connection_success_screen.dart';
import 'package:finfx/features/home/data/models/bot_model.dart';
import 'package:finfx/features/subscriptions/data/models/bot_package_model.dart';
import 'package:finfx/features/subscriptions/presentation/screens/lot_size_screen.dart';
import 'package:finfx/features/subscriptions/presentation/screens/package_selection_screen.dart';
import 'package:finfx/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bot_details_provider.dart';

class BotDetailsTab extends StatefulWidget {
  const BotDetailsTab({super.key, required this.bot});
  final BotModel bot;
  @override
  State<BotDetailsTab> createState() => _BotDetailsTabState();
}

class _BotDetailsTabState extends State<BotDetailsTab>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Always refresh bot details when tab initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BotDetailsProvider>().loadBotDetails(widget.bot.id);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh bot details when app becomes active
    if (state == AppLifecycleState.resumed) {
      context.read<BotDetailsProvider>().loadBotDetails(widget.bot.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<BotDetailsProvider>(
      builder: (context, botDetailsProvider, child) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bot Info Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xff2e9844)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.smart_toy,
                              color: const Color(0xff2e9844),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.bot.name,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 20,
                                    fontFamily: "Manrope-Bold",
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Trading Bot',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 14,
                                    fontFamily: "Manrope-Regular",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Subscription Status
                      if (botDetailsProvider.subscriptionStatus != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subscription Status',
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontSize: 16,
                                      fontFamily: "Manrope-Bold",
                                    ),
                                  ),
                                  if (botDetailsProvider.isLoading)
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          const Color(0xff2e9844),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    _getStatusIcon(botDetailsProvider
                                        .subscriptionStatus
                                        ?.subscription
                                        ?.status),
                                    color: _getStatusColor(botDetailsProvider
                                        .subscriptionStatus
                                        ?.subscription
                                        ?.status),
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _getStatusText(botDetailsProvider
                                        .subscriptionStatus
                                        ?.subscription
                                        ?.status),
                                    style: TextStyle(
                                      color: _getStatusColor(botDetailsProvider
                                          .subscriptionStatus
                                          ?.subscription
                                          ?.status),
                                      fontSize: 14,
                                      fontFamily: "Manrope-Medium",
                                    ),
                                  ),
                                ],
                              ),
                              if (botDetailsProvider
                                      .subscriptionStatus!.subscription !=
                                  null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Subscribed: ${_formatDate(botDetailsProvider.subscriptionStatus!.subscription!.subscribedAt)}',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 12,
                                    fontFamily: "Manrope-Regular",
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Bot Description
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About This Bot',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 18,
                          fontFamily: "Manrope-Bold",
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.bot.description,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                          fontFamily: "Manrope-Regular",
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Performance Overview
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Performance Overview',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 18,
                          fontFamily: "Manrope-Bold",
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Performance Metrics
                      if (botDetailsProvider.isLoadingPerformance)
                        _buildPerformanceShimmer(colorScheme)
                      else if (botDetailsProvider.performanceOverview !=
                          null) ...[
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Total Trades',
                                value: botDetailsProvider
                                    .performanceOverview!.totalTrades
                                    .toString(),
                                color: Colors.orange,
                                icon: Icons.swap_horiz,
                                colorScheme: colorScheme,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Total Return',
                                value: botDetailsProvider
                                    .performanceOverview!.formattedTotalReturn,
                                color: botDetailsProvider
                                    .performanceOverview!.totalReturnColor,
                                icon: botDetailsProvider
                                    .performanceOverview!.totalReturnIcon,
                                colorScheme: colorScheme,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Win Rate',
                                value: botDetailsProvider
                                    .performanceOverview!.formattedWinRate,
                                color: botDetailsProvider
                                    .performanceOverview!.winRateColor,
                                icon: botDetailsProvider
                                    .performanceOverview!.winRateIcon,
                                colorScheme: colorScheme,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildMetricCard(
                                title: 'Profit Factor',
                                value: botDetailsProvider
                                    .performanceOverview!.formattedProfitFactor,
                                color: botDetailsProvider
                                    .performanceOverview!.profitFactorColor,
                                icon: botDetailsProvider
                                    .performanceOverview!.profitFactorIcon,
                                colorScheme: colorScheme,
                              ),
                            ),
                          ],
                        ),
                      ] else if (botDetailsProvider.performanceError != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.red.withValues(alpha: 0.3)),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline,
                                  color: Colors.red, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Failed to load performance data',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontFamily: "Manrope-Regular",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colorScheme.onSurface.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: colorScheme.onSurfaceVariant,
                                  size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'No performance data available',
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 14,
                                    fontFamily: "Manrope-Regular",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // Add bottom padding for floating action button
                const SizedBox(height: 80),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: botDetailsProvider.isToggling
                ? null
                : () async {
                    final subscriptionStatus = botDetailsProvider
                        .subscriptionStatus?.subscription?.status;

                    if (subscriptionStatus == 'active') {
                      // Pause the subscription
                      final success =
                          await botDetailsProvider.updateSubscriptionStatus(
                              botDetailsProvider
                                  .subscriptionStatus!.subscription!.id,
                              'paused');
                      if (success) {
                        ToastUtils.showSuccess(
                          context: context,
                          message:
                              'Successfully paused subscription for ${widget.bot.name}',
                        );
                      } else {
                        ToastUtils.showError(
                          context: context,
                          message: botDetailsProvider.error ??
                              'Failed to pause subscription',
                        );
                      }
                      return;
                    } else if (subscriptionStatus == 'paused') {
                      // Reactivate the subscription
                      final success =
                          await botDetailsProvider.updateSubscriptionStatus(
                              botDetailsProvider
                                  .subscriptionStatus!.subscription!.id,
                              'active');
                      if (success) {
                        ToastUtils.showSuccess(
                          context: context,
                          message:
                              'Successfully reactivated subscription for ${widget.bot.name}',
                        );
                      } else {
                        ToastUtils.showError(
                          context: context,
                          message: botDetailsProvider.error ??
                              'Failed to reactivate subscription',
                        );
                      }
                      return;
                    } else {
                      // Connect (subscribe) - for expired or no subscription
                      final selectedLotSize =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return LotSizeScreen();
                        },
                        fullscreenDialog: true,
                      ));
                      if (selectedLotSize == null) return;
                      print(selectedLotSize);
                      final selectedPackage =
                          await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return PackageSelectionScreen(botId: widget.bot.id);
                        },
                      ));
                      if (selectedPackage == null) return;
                      print(
                          'Selected Package: ${selectedPackage.bot.name} - ${selectedPackage.package.name} - \$${selectedPackage.price}');
                      // Add subscription
                      final success = await botDetailsProvider.subscribeToBot(
                        widget.bot.id,
                        selectedPackage.id,
                        selectedLotSize,
                      );
                      if (success) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return BotConnectionSuccessScreen();
                          },
                        ));
                      } else {
                        ToastUtils.showError(
                          context: context,
                          message: 'Failed to subscribe to ${widget.bot.name}',
                        );
                      }

                      // final success = await botDetailsProvider
                      //     .toggleSubscription(widget.bot.id);
                      // if (success) {
                      //   if (botDetailsProvider.isSubscribed) {
                      //     ToastUtils.showSuccess(
                      //       context: context,
                      //       message:
                      //           'Successfully subscribed to ${widget.bot.name}!',
                      //     );
                      //   } else {
                      //     ToastUtils.showInfo(
                      //       context: context,
                      //       message:
                      //           'Subscription cancelled for ${widget.bot.name}',
                      //     );
                      //   }
                      // } else {
                      //   ToastUtils.showError(
                      //     context: context,
                      //     message: botDetailsProvider.error ??
                      //         'Failed to toggle subscription',
                      //   );
                      // }
                    }
                  },
            backgroundColor: _getFloatingActionButtonColor(
                botDetailsProvider.subscriptionStatus?.subscription?.status),
            icon: botDetailsProvider.isToggling
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Icon(
                    _getFloatingActionButtonIcon(botDetailsProvider
                        .subscriptionStatus?.subscription?.status),
                    color: Colors.white,
                  ),
            label: Text(
              botDetailsProvider.isToggling
                  ? 'Processing...'
                  : _getFloatingActionButtonText(botDetailsProvider
                      .subscriptionStatus?.subscription?.status),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: "Manrope-Bold",
                fontSize: 16,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required ColorScheme colorScheme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 12,
                  fontFamily: "Manrope-Regular",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontFamily: "Manrope-Bold",
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildPerformanceShimmer(ColorScheme colorScheme) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildShimmerMetricCard(colorScheme),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildShimmerMetricCard(colorScheme),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildShimmerMetricCard(colorScheme),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildShimmerMetricCard(colorScheme),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildShimmerMetricCard(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: colorScheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: 80,
            height: 18,
            decoration: BoxDecoration(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
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

  String _getStatusText(String? status) {
    switch (status) {
      case 'active':
        return 'Active Subscription';
      case 'paused':
        return 'Paused Subscription';
      case 'expired':
        return 'Expired Subscription';
      default:
        return 'Not Subscribed';
    }
  }

  IconData _getStatusIcon(String? status) {
    switch (status) {
      case 'active':
        return Icons.check_circle;
      case 'paused':
        return Icons.pause_circle;
      case 'expired':
        return Icons.schedule;
      default:
        return Icons.cancel;
    }
  }

  Color _getFloatingActionButtonColor(String? status) {
    switch (status) {
      case 'active':
        return const Color(0xFFFF9800); // Orange for pause
      case 'paused':
        return const Color(0xFF4CAF50); // Green for reactivate
      case 'expired':
        return const Color(0xff2e9844); // Green for connect again
      default:
        return const Color(0xff2e9844); // Green for connect
    }
  }

  IconData _getFloatingActionButtonIcon(String? status) {
    switch (status) {
      case 'active':
        return Icons.pause;
      case 'paused':
        return Icons.play_arrow;
      case 'expired':
        return Icons.link;
      default:
        return Icons.link;
    }
  }

  String _getFloatingActionButtonText(String? status) {
    switch (status) {
      case 'active':
        return 'Pause';
      case 'paused':
        return 'Reactivate';
      case 'expired':
        return 'Connect Again';
      default:
        return 'Connect';
    }
  }
}
