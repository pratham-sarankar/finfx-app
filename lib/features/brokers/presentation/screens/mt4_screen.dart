// Flutter imports:
import 'package:finfx/features/brokers/presentation/providers/mt4_provider.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../../utils/toast_utils.dart';
import '../widgets/broker_selection_form_field.dart';

class MT4Screen extends StatefulWidget {
  const MT4Screen({super.key});

  @override
  State<MT4Screen> createState() => _MT4ScreenState();
}

class _MT4ScreenState extends State<MT4Screen> {
  // Controllers for text fields
  final TextEditingController _brokerController = TextEditingController();
  final TextEditingController _loginIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _brokerServerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize provider only if not already initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mt4Provider = context.read<MT4Provider>();
      if (!mt4Provider.isInitialized) {
        mt4Provider.initialize();
      }
    });
  }

  @override
  void dispose() {
    _brokerController.dispose();
    _loginIdController.dispose();
    _passwordController.dispose();
    _brokerServerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Consumer<MT4Provider>(
      builder: (context, mt4Provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            if (mt4Provider.isConnected) {
              // Refresh logic if needed
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
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
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
                          'Connect${mt4Provider.isConnected ? "ed" : ""} to Meta Trader 4',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 22,
                            fontFamily: "Manrope-Bold",
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mt4Provider.isConnected
                              ? 'Your Meta Trader 4 account is connected and ready'
                              : 'Enter your Meta Trader 4 API credentials to connect your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                            fontSize: 14,
                            fontFamily: "Manrope-Regular",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Error display
                  if (mt4Provider.error != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 16),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              mt4Provider.error!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontFamily: "Manrope-Regular",
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => mt4Provider.clearError(),
                            icon:
                                Icon(Icons.close, color: Colors.red, size: 20),
                          ),
                        ],
                      ),
                    ),

                  // Connection form (if not connected)
                  if (!mt4Provider.isConnected)
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'API Credentials',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 18,
                              fontFamily: "Manrope-Bold",
                            ),
                          ),
                          const SizedBox(height: 16),
                          BrokerSelectionFormField(
                            labelText: 'Broker',
                            onChanged: (broker) {
                              _brokerController.text = broker?.name ?? '';
                            },
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _loginIdController,
                            decoration: InputDecoration(
                              labelText: 'Login ID',
                              labelStyle:
                                  TextStyle(color: colorScheme.onSurface),
                              filled: true,
                              fillColor: colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(color: colorScheme.onSurface),
                              filled: true,
                              fillColor: colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            obscureText: true,
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _brokerServerController,
                            decoration: InputDecoration(
                              labelText: 'Broker Server',
                              labelStyle:
                                  TextStyle(color: colorScheme.onSurface),
                              filled: true,
                              fillColor: colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: mt4Provider.isConnecting
                                  ? null
                                  : () async {
                                      if (_brokerController.text
                                              .trim()
                                              .isEmpty ||
                                          _loginIdController.text
                                              .trim()
                                              .isEmpty ||
                                          _passwordController.text
                                              .trim()
                                              .isEmpty ||
                                          _brokerServerController.text
                                              .trim()
                                              .isEmpty) {
                                        ToastUtils.showError(
                                          context: context,
                                          message: 'Please fill in all fields',
                                        );
                                        return;
                                      }

                                      final success = await mt4Provider.connect(
                                        broker: _brokerController.text,
                                        loginId: _loginIdController.text,
                                        password: _passwordController.text,
                                        brokerServer:
                                            _brokerServerController.text,
                                      );

                                      if (success) {
                                        _brokerController.clear();
                                        _loginIdController.clear();
                                        _passwordController.clear();
                                        _brokerServerController.clear();
                                        ToastUtils.showSuccess(
                                          context: context,
                                          message:
                                              'Successfully connected to MT4!',
                                        );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff2e9844),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: mt4Provider.isConnecting
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'Connect',
                                      style: TextStyle(
                                        fontFamily: "Manrope-Bold",
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Disconnect button (if connected)
                  if (mt4Provider.isConnected)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Connection Status',
                            style: TextStyle(
                              color: colorScheme.onSurface,
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
                                'Connected to MT4',
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
                              onPressed: mt4Provider.isLoading
                                  ? null
                                  : () async {
                                      await mt4Provider.disconnect();
                                      ToastUtils.showInfo(
                                        context: context,
                                        message: 'Disconnected from MT4',
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: mt4Provider.isLoading
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'Disconnect',
                                      style: TextStyle(
                                        fontFamily: "Manrope-Bold",
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
    );
  }
}
