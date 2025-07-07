// Flutter imports:
import 'package:finfx/features/brokers/presentation/providers/binance_provider.dart';
import 'package:finfx/features/brokers/presentation/providers/delta_provider.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../../dark_mode.dart';
import '../../../../utils/toast_utils.dart';

class BrokersScreen extends StatefulWidget {
  final int initialTab;
  const BrokersScreen({super.key, this.initialTab = 0});

  @override
  State<BrokersScreen> createState() => _BrokersScreenState();
}

class _BrokersScreenState extends State<BrokersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  ColorNotifire notifier = ColorNotifire();

  // Controllers for text fields
  final TextEditingController _binanceApiKeyController =
      TextEditingController();
  final TextEditingController _binanceApiSecretController =
      TextEditingController();
  final TextEditingController _deltaApiKeyController = TextEditingController();
  final TextEditingController _deltaApiSecretController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.initialTab);
    // Initialize providers
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BinanceProvider>().initialize();
      context.read<DeltaProvider>().initialize();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _binanceApiKeyController.dispose();
    _binanceApiSecretController.dispose();
    _deltaApiKeyController.dispose();
    _deltaApiSecretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        title: Text(
          'API Connection',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Manrope-Bold",
          ),
        ),
        backgroundColor: const Color(0xff2e9844),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
              ),
              decoration: BoxDecoration(
                color: notifier.container.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: notifier.textColor.withValues(alpha: 0.1)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xff2e9844).withValues(alpha: 0.1),
                  border: Border.all(
                      color: const Color(0xff2e9844).withValues(alpha: 0.3)),
                ),
                labelColor: const Color(0xff2e9844),
                unselectedLabelColor: notifier.textColor.withValues(alpha: 0.7),
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
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.currency_exchange_outlined, size: 18),
                        const SizedBox(width: 8),
                        const Text('MT5'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, size: 18),
                        const SizedBox(width: 8),
                        const Text('MT4'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Delta Tab
                  Consumer<DeltaProvider>(
                    builder: (context, deltaProvider, child) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          if (deltaProvider.isConnected) {
                            await deltaProvider.refreshBalance();
                          }
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header section
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: notifier.tabBar1,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          "assets/images/mt5.png",
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Connect${deltaProvider.isConnected ? "ed" : ""} to Meta Trader 5',
                                        style: TextStyle(
                                          color: notifier.textColor,
                                          fontSize: 22,
                                          fontFamily: "Manrope-Bold",
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        deltaProvider.isConnected
                                            ? 'Your Meta Trader 5 account is connected and ready'
                                            : 'Enter your Meta Trader 5 API credentials to connect your account',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: notifier.textColor
                                              .withValues(alpha: 0.7),
                                          fontSize: 14,
                                          fontFamily: "Manrope-Regular",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Error display
                                if (deltaProvider.error != null)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.red
                                              .withValues(alpha: 0.3)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.error_outline,
                                            color: Colors.red, size: 20),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            deltaProvider.error!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontFamily: "Manrope-Regular",
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              deltaProvider.clearError(),
                                          icon: Icon(Icons.close,
                                              color: Colors.red, size: 20),
                                        ),
                                      ],
                                    ),
                                  ),

                                // Balance display (if connected)
                                if (deltaProvider.isConnected &&
                                    deltaProvider.balance != null)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: notifier.tabBar1,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Current Balance',
                                              style: TextStyle(
                                                color: notifier.textColor,
                                                fontSize: 18,
                                                fontFamily: "Manrope-Bold",
                                              ),
                                            ),
                                            if (deltaProvider.isLoading)
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    const Color(0xff2e9844),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: notifier.background,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Available ${deltaProvider.balance!.asset}',
                                                style: TextStyle(
                                                  color: notifier.textColor
                                                      .withValues(alpha: 0.7),
                                                  fontSize: 12,
                                                  fontFamily: "Manrope-Regular",
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${deltaProvider.balance!.availableBalance.toStringAsFixed(2)} ${deltaProvider.balance!.asset}',
                                                style: TextStyle(
                                                  color: notifier.textColor,
                                                  fontSize: 16,
                                                  fontFamily: "Manrope-Bold",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                // Connection form (if not connected)
                                if (!deltaProvider.isConnected)
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: notifier.tabBar1,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'API Credentials',
                                          style: TextStyle(
                                            color: notifier.textColor,
                                            fontSize: 18,
                                            fontFamily: "Manrope-Bold",
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Broker',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: _deltaApiKeyController,
                                          decoration: InputDecoration(
                                            labelText: 'Login ID',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller: _deltaApiSecretController,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          obscureText: true,
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: _deltaApiKeyController,
                                          decoration: InputDecoration(
                                            labelText: 'Broker Server',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: deltaProvider
                                                    .isConnecting
                                                ? null
                                                : () async {
                                                    if (_deltaApiKeyController
                                                            .text
                                                            .trim()
                                                            .isEmpty ||
                                                        _deltaApiSecretController
                                                            .text
                                                            .trim()
                                                            .isEmpty) {
                                                      ToastUtils.showError(
                                                        context: context,
                                                        message:
                                                            'Please enter both API key and secret',
                                                      );
                                                      return;
                                                    }

                                                    final success =
                                                        await deltaProvider
                                                            .connect(
                                                      apiKey:
                                                          _deltaApiKeyController
                                                              .text,
                                                      apiSecret:
                                                          _deltaApiSecretController
                                                              .text,
                                                    );

                                                    if (success) {
                                                      _deltaApiKeyController
                                                          .clear();
                                                      _deltaApiSecretController
                                                          .clear();
                                                      ToastUtils.showSuccess(
                                                        context: context,
                                                        message:
                                                            'Successfully connected to Delta Exchange!',
                                                      );
                                                    }
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff2e9844),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: deltaProvider.isConnecting
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.white),
                                                    ),
                                                  )
                                                : const Text(
                                                    'Connect',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Manrope-Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                // Disconnect button (if connected)
                                if (deltaProvider.isConnected)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: notifier.tabBar1,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Connection Status',
                                          style: TextStyle(
                                            color: notifier.textColor,
                                            fontSize: 18,
                                            fontFamily: "Manrope-Bold",
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Connected to Delta Exchange',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                                fontFamily: "Manrope-Medium",
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: deltaProvider.isLoading
                                                ? null
                                                : () async {
                                                    await deltaProvider
                                                        .disconnect();
                                                    ToastUtils.showInfo(
                                                      context: context,
                                                      message:
                                                          'Disconnected from Delta Exchange',
                                                    );
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: deltaProvider.isLoading
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.white),
                                                    ),
                                                  )
                                                : const Text(
                                                    'Disconnect',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Manrope-Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Binance Tab
                  Consumer<BinanceProvider>(
                    builder: (context, binanceProvider, child) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          if (binanceProvider.isConnected) {
                            await binanceProvider.refreshBalance();
                          }
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header section
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: notifier.tabBar1,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white
                                              .withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          "assets/images/mt4.webp",
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Connect${binanceProvider.isConnected ? "ed" : ""} to Meta Trader 4',
                                        style: TextStyle(
                                          color: notifier.textColor,
                                          fontSize: 22,
                                          fontFamily: "Manrope-Bold",
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        binanceProvider.isConnected
                                            ? 'Your Meta Trader 4 account is connected and ready'
                                            : 'Enter your Meta Trader 4 API credentials to connect your account',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: notifier.textColor
                                              .withValues(alpha: 0.7),
                                          fontSize: 14,
                                          fontFamily: "Manrope-Regular",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Error display
                                if (binanceProvider.error != null)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.red
                                              .withValues(alpha: 0.3)),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.error_outline,
                                            color: Colors.red, size: 20),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            binanceProvider.error!,
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontFamily: "Manrope-Regular",
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              binanceProvider.clearError(),
                                          icon: Icon(Icons.close,
                                              color: Colors.red, size: 20),
                                        ),
                                      ],
                                    ),
                                  ),

                                // Balance display (if connected)
                                if (binanceProvider.isConnected &&
                                    binanceProvider.balance != null)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.only(bottom: 16),
                                    decoration: BoxDecoration(
                                      color: notifier.tabBar1,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Current Balance',
                                              style: TextStyle(
                                                color: notifier.textColor,
                                                fontSize: 18,
                                                fontFamily: "Manrope-Bold",
                                              ),
                                            ),
                                            if (binanceProvider.isLoading)
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    const Color(0xff2e9844),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: notifier.background,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Available BTC',
                                                      style: TextStyle(
                                                        color: notifier
                                                            .textColor
                                                            .withValues(
                                                                alpha: 0.7),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "Manrope-Regular",
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '${binanceProvider.balance!.btcBalance.toStringAsFixed(8)} BTC',
                                                      style: TextStyle(
                                                        color:
                                                            notifier.textColor,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "Manrope-Bold",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: notifier.background,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Locked BTC',
                                                      style: TextStyle(
                                                        color: notifier
                                                            .textColor
                                                            .withValues(
                                                                alpha: 0.7),
                                                        fontSize: 12,
                                                        fontFamily:
                                                            "Manrope-Regular",
                                                      ),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '${binanceProvider.balance!.btcLocked.toStringAsFixed(8)} BTC',
                                                      style: TextStyle(
                                                        color:
                                                            notifier.textColor,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "Manrope-Bold",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                // Connection form (if not connected)
                                if (!binanceProvider.isConnected)
                                  Container(
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: notifier.tabBar1,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'API Credentials',
                                          style: TextStyle(
                                            color: notifier.textColor,
                                            fontSize: 18,
                                            fontFamily: "Manrope-Bold",
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Broker',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          controller: _binanceApiKeyController,
                                          decoration: InputDecoration(
                                            labelText: 'Login ID',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 12),
                                        TextField(
                                          controller:
                                              _binanceApiSecretController,
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          obscureText: true,
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 16),
                                        TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Broker Server',
                                            labelStyle: TextStyle(
                                                color: notifier.textColor),
                                            filled: true,
                                            fillColor: notifier.background,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          style: TextStyle(
                                              color: notifier.textColor),
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: binanceProvider
                                                    .isConnecting
                                                ? null
                                                : () async {
                                                    if (_binanceApiKeyController
                                                            .text
                                                            .trim()
                                                            .isEmpty ||
                                                        _binanceApiSecretController
                                                            .text
                                                            .trim()
                                                            .isEmpty) {
                                                      ToastUtils.showError(
                                                        context: context,
                                                        message:
                                                            'Please enter both API key and secret',
                                                      );
                                                      return;
                                                    }

                                                    final success =
                                                        await binanceProvider
                                                            .connect(
                                                      apiKey:
                                                          _binanceApiKeyController
                                                              .text,
                                                      apiSecret:
                                                          _binanceApiSecretController
                                                              .text,
                                                    );

                                                    if (success) {
                                                      _binanceApiKeyController
                                                          .clear();
                                                      _binanceApiSecretController
                                                          .clear();
                                                      ToastUtils.showSuccess(
                                                        context: context,
                                                        message:
                                                            'Successfully connected to Binance!',
                                                      );
                                                    }
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff2e9844),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: binanceProvider.isConnecting
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.white),
                                                    ),
                                                  )
                                                : const Text(
                                                    'Connect',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Manrope-Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                // Disconnect button (if connected)
                                if (binanceProvider.isConnected)
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: notifier.tabBar1,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Connection Status',
                                          style: TextStyle(
                                            color: notifier.textColor,
                                            fontSize: 18,
                                            fontFamily: "Manrope-Bold",
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Connected to Binance',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                                fontFamily: "Manrope-Medium",
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            onPressed: binanceProvider.isLoading
                                                ? null
                                                : () async {
                                                    await binanceProvider
                                                        .disconnect();
                                                    ToastUtils.showInfo(
                                                      context: context,
                                                      message:
                                                          'Disconnected from Binance',
                                                    );
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: binanceProvider.isLoading
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.white),
                                                    ),
                                                  )
                                                : const Text(
                                                    'Disconnect',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          "Manrope-Bold",
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
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
    );
  }
}
