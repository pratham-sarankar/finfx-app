import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finfx/features/subscriptions/presentation/providers/subscriptions_provider.dart';
import 'package:finfx/features/subscriptions/presentation/widgets/subscription_card.dart';

class MySubscriptionsScreen extends StatefulWidget {
  const MySubscriptionsScreen({super.key});

  @override
  State<MySubscriptionsScreen> createState() => _MySubscriptionsScreenState();
}

class _MySubscriptionsScreenState extends State<MySubscriptionsScreen> {
  String selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    // Fetch subscriptions when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<SubscriptionsProvider>()
          .fetchSubscriptions(status: selectedFilter);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final subscriptionsProvider =
        Provider.of<SubscriptionsProvider>(context, listen: true);

    // Show error via Snackbar if there's an error
    if (subscriptionsProvider.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(subscriptionsProvider.error!),
            backgroundColor: Colors.red,
          ),
        );
        subscriptionsProvider.clearError();
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25, bottom: 10),
              child: Text(
                "My Subscriptions",
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontFamily: "Manrope-Bold",
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            // Filter Bar
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  _buildFilterChip('all', 'All'),
                  _buildFilterChip('active', 'Active'),
                  _buildFilterChip('cancelled', 'Cancelled'),
                ],
              ),
            ),
            // Subscriptions List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await subscriptionsProvider.fetchSubscriptions(
                      status: selectedFilter);
                },
                child: subscriptionsProvider.isLoading
                    ? _buildShimmerList()
                    : subscriptionsProvider.subscriptions.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount:
                                subscriptionsProvider.subscriptions.length,
                            itemBuilder: (context, index) {
                              final subscription =
                                  subscriptionsProvider.subscriptions[index];
                              return SubscriptionCard(
                                  subscription: subscription);
                            },
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = selectedFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = filter;
          });
          // Fetch subscriptions for the selected filter
          context.read<SubscriptionsProvider>().fetchSubscriptions(
                status: filter == 'all' ? null : filter,
              );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xff2e9844).withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? const Color(0xff2e9844).withValues(alpha: 0.3)
                  : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xff2e9844)
                  : colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
              fontFamily: isSelected ? "Manrope-Bold" : "Manrope-Regular",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;
    String message;
    String subMessage;

    switch (selectedFilter) {
      case 'all':
        message = 'No subscriptions yet!';
        subMessage = 'Explore our bots and start your investment journey.';
        break;
      case 'active':
        message = 'No active subscriptions';
        subMessage = 'You don\'t have any active subscriptions at the moment.';
        break;
      case 'cancelled':
        message = 'No cancelled subscriptions';
        subMessage = 'You don\'t have any cancelled subscriptions.';
        break;
      default:
        message = 'No subscriptions found';
        subMessage = 'Try changing the filter or subscribe to a new bot.';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: 64,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 20,
              fontFamily: "Manrope-Bold",
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subMessage,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
              fontFamily: "Manrope-Regular",
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildShimmerCard();
      },
    );
  }

  Widget _buildShimmerCard() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
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
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
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
                            child: Container(
                              height: 18,
                              decoration: BoxDecoration(
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 14,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 14,
                        width: 120,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
