// Flutter imports:
import 'package:finfx/features/brokers/presentation/providers/binance_provider.dart';
import 'package:finfx/features/brokers/presentation/providers/delta_provider.dart';
import 'package:finfx/features/brokers/presentation/screens/brokers_screen.dart';
import 'package:finfx/features/home/presentation/widgets/bot_card.dart';
import 'package:finfx/features/home/presentation/widgets/broker_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:finfx/screens/Message%20&%20Notification/Notifications.dart';
import 'package:finfx/features/home/presentation/providers/bot_provider.dart';
import 'package:finfx/features/profile/presentation/providers/profile_provider.dart';

// Custom painter for the line chart
class LineChartPainter extends CustomPainter {
  final Color color;
  final bool isPositive;

  LineChartPainter({required this.color, required this.isPositive});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = size.width;
    final height = size.height;

    // Generate points for a more realistic trading pattern
    final points = <Offset>[];

    if (isPositive) {
      // Upward trend pattern with realistic fluctuations
      points.add(Offset(0, height * 0.7)); // Start
      points.add(Offset(width * 0.1, height * 0.65)); // Small dip
      points.add(Offset(width * 0.2, height * 0.75)); // Rise
      points.add(Offset(width * 0.3, height * 0.7)); // Correction
      points.add(Offset(width * 0.4, height * 0.6)); // Strong rise
      points.add(Offset(width * 0.5, height * 0.55)); // Small dip
      points.add(Offset(width * 0.6, height * 0.45)); // Rise
      points.add(Offset(width * 0.7, height * 0.5)); // Correction
      points.add(Offset(width * 0.8, height * 0.35)); // Rise
      points.add(Offset(width * 0.9, height * 0.3)); // Small dip
      points.add(Offset(width, height * 0.25)); // End higher
    } else {
      // Downward trend pattern with realistic fluctuations
      points.add(Offset(0, height * 0.3)); // Start
      points.add(Offset(width * 0.1, height * 0.35)); // Small rise
      points.add(Offset(width * 0.2, height * 0.25)); // Drop
      points.add(Offset(width * 0.3, height * 0.3)); // Correction
      points.add(Offset(width * 0.4, height * 0.4)); // Drop
      points.add(Offset(width * 0.5, height * 0.45)); // Small rise
      points.add(Offset(width * 0.6, height * 0.55)); // Drop
      points.add(Offset(width * 0.7, height * 0.5)); // Correction
      points.add(Offset(width * 0.8, height * 0.65)); // Drop
      points.add(Offset(width * 0.9, height * 0.7)); // Small rise
      points.add(Offset(width, height * 0.75)); // End lower
    }

    // Draw the path with smooth curves
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final xc = (points[i].dx + points[i + 1].dx) / 2;
      final yc = (points[i].dy + points[i + 1].dy) / 2;
      path.quadraticBezierTo(points[i].dx, points[i].dy, xc, yc);
    }

    path.lineTo(points.last.dx, points.last.dy);

    // Draw the area below the line
    final fillPath = Path.from(path);
    fillPath.lineTo(width, height);
    fillPath.lineTo(0, height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Draw the main line
    canvas.drawPath(path, paint);

    // Draw entry and exit points
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Entry point
    canvas.drawCircle(
      points[0],
      3,
      dotPaint,
    );
    canvas.drawCircle(
      points[0],
      3,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Exit point
    canvas.drawCircle(
      points.last,
      3,
      dotPaint,
    );
    canvas.drawCircle(
      points.last,
      3,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Draw arrows
    _drawArrow(canvas, points[0], isPositive ? -1 : 1, color);
    _drawArrow(canvas, points.last, isPositive ? -1 : 1, color);
  }

  void _drawArrow(Canvas canvas, Offset point, int direction, Color color) {
    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final arrowPath = Path();
    final arrowSize = 8.0;
    final arrowHeight = 6.0;

    if (direction == 1) {
      arrowPath.moveTo(point.dx, point.dy - arrowSize);
      arrowPath.lineTo(
          point.dx - arrowHeight, point.dy - arrowSize + arrowHeight);
      arrowPath.lineTo(
          point.dx + arrowHeight, point.dy - arrowSize + arrowHeight);
    } else {
      arrowPath.moveTo(point.dx, point.dy + arrowSize);
      arrowPath.lineTo(
          point.dx - arrowHeight, point.dy + arrowSize - arrowHeight);
      arrowPath.lineTo(
          point.dx + arrowHeight, point.dy + arrowSize - arrowHeight);
    }
    arrowPath.close();
    canvas.drawPath(arrowPath, arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({Key? key, this.onSettingsTap}) : super(key: key);
  final VoidCallback? onSettingsTap;

  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize broker providers and fetch bots
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BotProvider>().fetchBots();
      context.read<BinanceProvider>().initialize();
      context.read<DeltaProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.sizeOf(context);
    final botProvider = Provider.of<BotProvider>(context, listen: true);

    // Get greeting based on current time
    String greeting = _getTimeBasedGreeting();

    // Show error via Snackbar if there's an error
    if (botProvider.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(botProvider.error!),
            backgroundColor: Colors.red,
          ),
        );
        botProvider.clearError();
      });
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colorScheme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: colorScheme.brightness == Brightness.dark
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: colorScheme.surface,
        systemNavigationBarIconBrightness:
            colorScheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              // Refresh bots
              await context.read<BotProvider>().fetchBots();
              // Refresh broker balances
              final binanceProvider = context.read<BinanceProvider>();
              final deltaProvider = context.read<DeltaProvider>();

              if (binanceProvider.isConnected) {
                await binanceProvider.refreshBalance();
              }
              if (deltaProvider.isConnected) {
                await deltaProvider.refreshBalance();
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Modern Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/app-icon.png",
                                width: size.width * 0.12,
                                height: size.width * 0.12,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${greeting} 👋",
                                      style: TextStyle(
                                        color: colorScheme.onSurface
                                            .withValues(alpha: 0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Consumer<ProfileProvider>(
                                      builder:
                                          (context, profileProvider, child) {
                                        final userName =
                                            profileProvider.profile?.fullName ??
                                                '';
                                        return Text(
                                          userName.isNotEmpty
                                              ? userName
                                              : "Dear User",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: colorScheme.onSurface,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            height: 1,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            // notification icon disabled for now
                            // _modernIconButton(Icons.notifications_outlined),
                            const SizedBox(width: 10),
                            _modernIconButton(Icons.settings_outlined),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Broker Cards Section
                    _brokerCardsSection(colorScheme),
                    const SizedBox(height: 28),

                    // Strategies Section (Horizontal Scroll)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Trading Bot",
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.trending_up, color: Color(0xff2e9844)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Modern Bot List
                    if (botProvider.isLoading)
                      Column(
                        children: List.generate(
                            3, (index) => _buildShimmerBotCard(colorScheme)),
                      )
                    else if (botProvider.bots.isNotEmpty)
                      Column(
                        children: botProvider.bots
                            .map((bot) => BotCard(bot: bot))
                            .toList(),
                      )
                    else
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color:
                                  colorScheme.outline.withValues(alpha: 0.2)),
                        ),
                        child: Center(
                          child: Text(
                            "No bots available",
                            style: TextStyle(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Modern header icon button
  Widget _modernIconButton(IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        if (icon == Icons.notifications_outlined) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Notifications(),
            ),
          );
        } else if (icon == Icons.settings_outlined) {
          if (widget.onSettingsTap != null) {
            widget.onSettingsTap!();
          } else {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: colorScheme.onSurface, size: 22),
      ),
    );
  }

  // Broker Cards Section
  Widget _brokerCardsSection(ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Broker Connections",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.swipe_left,
                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Swipe",
                  style: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: [
              BrokerCard(
                brokerName: "Meta Trader 5",
                logoPath: "assets/images/mt5.png",
                isConnected: context.watch<DeltaProvider>().isConnected,
                balance: context.watch<DeltaProvider>().balance,
                isLoading: context.watch<DeltaProvider>().isLoading,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BrokersScreen(initialTab: 0),
                    ),
                  );
                },
              ),
              const SizedBox(width: 12),
              BrokerCard(
                brokerName: "Meta Trader 4",
                logoPath: "assets/images/mt4.webp",
                isConnected: context.watch<BinanceProvider>().isConnected,
                balance: context.watch<BinanceProvider>().balance,
                isLoading: context.watch<BinanceProvider>().isLoading,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BrokersScreen(initialTab: 1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerBotCard(ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.show_chart,
                      color: colorScheme.onSurface, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 16,
                              decoration: BoxDecoration(
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Container(
                              height: 9,
                              width: 40,
                              decoration: BoxDecoration(
                                color: colorScheme.onSurface
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 12,
                        width: 80,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    height: 13,
                    width: 60,
                    decoration: BoxDecoration(
                      color: colorScheme.onSurface.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 11,
                        width: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 11,
                        width: 35,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        height: 11,
                        width: 30,
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
          ],
        ),
      ),
    );
  }

  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
