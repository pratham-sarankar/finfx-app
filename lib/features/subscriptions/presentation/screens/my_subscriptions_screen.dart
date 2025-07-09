import 'package:finfx/features/subscriptions/presentation/widgets/subscription_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../dark_mode.dart';

class MySubscriptionsScreen extends StatefulWidget {
  const MySubscriptionsScreen({super.key, this.subscriptions = const []});

  final List<Map<String, dynamic>> subscriptions;

  @override
  State<MySubscriptionsScreen> createState() => _MySubscriptionsScreenState();
}

class _MySubscriptionsScreenState extends State<MySubscriptionsScreen> {
  String selectedFilter = 'All';

  // Dummy data for demonstration
  List<Map<String, dynamic>> get dummySubscriptions => [
        {
          "userId": "686d338fc39deb504d02331c",
          "status": "active",
          "subscribedAt": "2025-07-08T15:07:27.756Z",
          "id": "686d342fc39deb504d02334a",
          "bot": {
            "id": "686d3414c39deb504d02333f",
            "name": "Smart Bot",
            "description": "AI-powered trading bot for smart investments.",
            "recommendedCapital": 1000,
            "performanceDuration": "1M",
            "script": "USD"
          }
        },
        {
          "userId": "686d338fc39deb504d02331c",
          "status": "cancelled",
          "subscribedAt": "2024-05-01T10:00:00.000Z",
          "id": "686d342fc39deb504d02334b",
          "bot": {
            "id": "686d3414c39deb504d02333g",
            "name": "Growth Bot",
            "description": "Maximizes portfolio growth with minimal risk.",
            "recommendedCapital": 500,
            "performanceDuration": "3M",
            "script": "USD"
          }
        },
        {
          "userId": "686d338fc39deb504d02331c",
          "status": "inactive",
          "subscribedAt": "2024-12-15T08:30:00.000Z",
          "id": "686d342fc39deb504d02334c",
          "bot": {
            "id": "686d3414c39deb504d02333h",
            "name": "Safe Bot",
            "description":
                "Focuses on capital preservation and steady returns.",
            "recommendedCapital": 250,
            "performanceDuration": "6M",
            "script": "USD"
          }
        },
        {
          "userId": "686d338fc39deb504d02331c",
          "status": "active",
          "subscribedAt": "2024-11-20T14:30:00.000Z",
          "id": "686d342fc39deb504d02334d",
          "bot": {
            "id": "686d3414c39deb504d02333i",
            "name": "Premium Bot",
            "description":
                "Advanced trading strategies for experienced investors.",
            "recommendedCapital": 2000,
            "performanceDuration": "6M",
            "script": "USD"
          }
        },
      ];

  List<Map<String, dynamic>> get filteredSubscriptions {
    if (selectedFilter == 'All') {
      return dummySubscriptions;
    }
    return dummySubscriptions
        .where((sub) => sub['status'] == selectedFilter.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    ColorNotifire notifier = Provider.of<ColorNotifire>(context, listen: true);
    final subs = filteredSubscriptions;

    return Scaffold(
      backgroundColor: notifier.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 25, bottom: 10),
              child: Text(
                "My Subscriptions",
                style: TextStyle(
                  color: notifier.textColor,
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
                color: notifier.tabBar1,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: notifier.getContainerBorder),
              ),
              child: Row(
                children: [
                  _buildFilterChip('All', notifier),
                  _buildFilterChip('Active', notifier),
                  _buildFilterChip('Inactive', notifier),
                  _buildFilterChip('Cancelled', notifier),
                ],
              ),
            ),
            // Subscriptions List
            Expanded(
              child: subs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sentiment_dissatisfied,
                            size: 64,
                            color: notifier.textColor.withValues(alpha: 0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            selectedFilter == 'All'
                                ? 'No subscriptions yet!'
                                : 'No $selectedFilter subscriptions',
                            style: TextStyle(
                              color: notifier.textColor,
                              fontSize: 20,
                              fontFamily: "Manrope-Bold",
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedFilter == 'All'
                                ? 'Explore our bots and start your investment journey.'
                                : 'Try changing the filter or subscribe to a new bot.',
                            style: TextStyle(
                              color: notifier.textColor.withValues(alpha: 0.7),
                              fontSize: 14,
                              fontFamily: "Manrope-Regular",
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: subs.length,
                      itemBuilder: (context, index) {
                        final sub = subs[index];
                        return SubscriptionCard(subscription: sub);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String filter, ColorNotifire notifier) {
    final isSelected = selectedFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = filter;
          });
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
            filter,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xff2e9844)
                  : notifier.textColor.withValues(alpha: 0.7),
              fontSize: 14,
              fontFamily: isSelected ? "Manrope-Bold" : "Manrope-Regular",
            ),
          ),
        ),
      ),
    );
  }
}
