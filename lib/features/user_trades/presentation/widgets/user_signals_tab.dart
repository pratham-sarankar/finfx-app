import 'package:finfx/widgets/signal_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finfx/dark_mode.dart';
import 'package:finfx/features/user_trades/presentation/providers/user_signals_provider.dart';
import 'package:finfx/features/bot/presentation/widgets/performance_overview_widget.dart';

class UserSignalsTab extends StatefulWidget {
  final String status; // 'opened' or 'closed'

  const UserSignalsTab({
    super.key,
    required this.status,
  });

  @override
  State<UserSignalsTab> createState() => _UserSignalsTabState();
}

class _UserSignalsTabState extends State<UserSignalsTab> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final userSignalsProvider = context.read<UserSignalsProvider>();
      if (userSignalsProvider.canLoadMore(widget.status)) {
        userSignalsProvider.loadMoreUserSignals(widget.status);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSignalsProvider>(
      builder: (context, userSignalsProvider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await userSignalsProvider.refreshUserSignals(widget.status);
          },
          child: _buildSignalList(userSignalsProvider),
        );
      },
    );
  }

  Widget _buildSignalList(UserSignalsProvider userSignalsProvider) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    if (userSignalsProvider.isLoading(widget.status)) {
      return Center(
        child: CircularProgressIndicator(
          color: colorScheme.primary,
        ),
      );
    }

    if (userSignalsProvider.getError(widget.status) != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading signals',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              userSignalsProvider.getError(widget.status)!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                userSignalsProvider.clearError(widget.status);
                userSignalsProvider.fetchUserSignals(widget.status);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final signals = userSignalsProvider.getSignals(widget.status);
    if (signals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_cellular_alt_outlined,
              color: colorScheme.onSurface.withOpacity(0.5),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No ${widget.status} trades found',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You don\'t have any ${widget.status} trades yet.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
        controller: _scrollController,
        children: [
          _buildPerformanceCard(userSignalsProvider),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: signals.length +
                (userSignalsProvider.isLoadingMore(widget.status) ||
                        userSignalsProvider.canLoadMore(widget.status)
                    ? 1
                    : 0),
            itemBuilder: (context, index) {
              if (index == signals.length) {
                // Show loading indicator at the bottom
                return _buildLoadingMoreIndicator(
                    userSignalsProvider.isLoadingMore(widget.status));
              }
              final signal = signals[index];
              return SignalCard(signal: signal);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingMoreIndicator(bool isLoadingMore) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoadingMore) ...[
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              isLoadingMore
                  ? 'Loading more signals...'
                  : 'More signals available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceCard(UserSignalsProvider userSignalsProvider) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // If we have performance overview data from the API, use the new widget
    final performanceOverview =
        userSignalsProvider.getPerformanceOverview(widget.status);
    if (performanceOverview != null) {
      return PerformanceOverviewWidget(
        performanceOverview: performanceOverview,
      );
    }

    // Fallback to basic performance metrics if no overview data
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Performance Overview',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (userSignalsProvider.hasActiveFilters) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Filtered',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                '${userSignalsProvider.getCurrentPage(widget.status)}/${userSignalsProvider.getTotalPages(widget.status)}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPerformanceMetric(
                  'Total PnL',
                  '\$${userSignalsProvider.getTotalPnL(widget.status).toStringAsFixed(2)}',
                  userSignalsProvider.getTotalPnL(widget.status) >= 0
                      ? colorScheme.primary
                      : colorScheme.error),
              _buildPerformanceMetric(
                  'Win Rate',
                  '${userSignalsProvider.getWinRate(widget.status).toStringAsFixed(1)}%',
                  colorScheme.primary),
              _buildPerformanceMetric(
                  'Avg ROI',
                  '${userSignalsProvider.getAverageROI(widget.status).toStringAsFixed(2)}%',
                  colorScheme.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetric(String label, String value, Color valueColor) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
