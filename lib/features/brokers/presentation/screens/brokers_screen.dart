// Flutter imports:
import 'package:finfx/features/brokers/presentation/providers/mt4_provider.dart';
import 'package:finfx/features/brokers/presentation/providers/mt5_provider.dart';
import 'package:finfx/features/brokers/presentation/screens/mt4_screen.dart';
import 'package:finfx/features/brokers/presentation/screens/mt5_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

class BrokersScreen extends StatefulWidget {
  final int initialTab;
  const BrokersScreen({super.key, this.initialTab = 0});

  @override
  State<BrokersScreen> createState() => _BrokersScreenState();
}

class _BrokersScreenState extends State<BrokersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    // Initialize providers only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Only initialize if not already initialized
      final mt5Provider = context.read<MT5Provider>();
      final mt4Provider = context.read<MT4Provider>();

      if (!mt5Provider.isInitialized) {
        mt5Provider.initialize();
      }
      if (!mt4Provider.isInitialized) {
        mt4Provider.initialize();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'API Connection',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                height: 1.8,
              ),
            ),
            Consumer2<MT5Provider, MT4Provider>(
              builder: (context, mt5Provider, mt4Provider, child) {
                final totalConnections = (mt5Provider.isConnected ? 1 : 0) +
                    (mt4Provider.isConnected ? 1 : 0);
                String displayText;
                if (totalConnections == 0) {
                  displayText = 'No Connected Brokers';
                } else if (totalConnections == 1) {
                  displayText = '1 Broker Connected';
                } else {
                  displayText = '$totalConnections Brokers Connected';
                }
                return Text(
                  displayText,
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 15,
                    height: 1.2,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.2)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: colorScheme.primary,
                unselectedLabelColor:
                    colorScheme.onSurface.withValues(alpha: 0.7),
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
                tabs: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.currency_exchange_outlined,
                          size: 18,
                          color: _tabController.index == 0
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.7)),
                      const SizedBox(width: 8),
                      const Text('MT5'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_balance_wallet_outlined,
                          size: 18,
                          color: _tabController.index == 1
                              ? colorScheme.primary
                              : colorScheme.onSurface.withValues(alpha: 0.7)),
                      const SizedBox(width: 8),
                      const Text('MT4'),
                    ],
                  ),
                ].map((child) => Tab(child: child)).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // MT5 Tab
                  const MT5Screen(),
                  // MT4 Tab
                  const MT4Screen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
