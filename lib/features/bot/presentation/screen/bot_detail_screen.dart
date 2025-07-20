// Flutter imports:
import 'package:finfx/features/bot/presentation/screen/bot_details_tab.dart';
import 'package:finfx/features/home/data/models/bot_model.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:finfx/features/bot/presentation/screen/bot_signals_screen.dart';
import 'package:finfx/features/bot/presentation/providers/bot_details_provider.dart';

class BotDetailsScreen extends StatefulWidget {
  final BotModel bot;

  const BotDetailsScreen({
    Key? key,
    required this.bot,
  }) : super(key: key);

  @override
  _BotDetailsScreenState createState() => _BotDetailsScreenState();
}

class _BotDetailsScreenState extends State<BotDetailsScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Refresh subscription status when app becomes active
    if (state == AppLifecycleState.resumed) {
      context.read<BotDetailsProvider>().loadSubscriptionStatus(widget.bot.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Refresh subscription status when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context
            .read<BotDetailsProvider>()
            .loadSubscriptionStatus(widget.bot.id);
      }
    });

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.bot.name,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
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
                    Icon(Icons.analytics_outlined,
                        size: 18,
                        color: _tabController.index == 0
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.7)),
                    const SizedBox(width: 8),
                    const Text('Details'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_active_outlined,
                        size: 18,
                        color: _tabController.index == 1
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.7)),
                    const SizedBox(width: 8),
                    const Text('Signals'),
                  ],
                ),
              ].map((child) => Tab(child: child)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Details Tab
          BotDetailsTab(
            bot: widget.bot,
          ),
          // Signals Tab
          BotSignalsScreen(
            bot: widget.bot,
          ),
        ],
      ),
    );
  }
}
