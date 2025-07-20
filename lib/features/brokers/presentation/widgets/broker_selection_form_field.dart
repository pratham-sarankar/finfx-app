// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../../../services/api_service.dart';
import '../../data/services/broker_service.dart';
import '../../domain/models/broker_model.dart';

class BrokerSelectionFormField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final BrokerModel? initialValue;
  final void Function(BrokerModel?)? onChanged;
  final String? Function(BrokerModel?)? validator;
  final bool enabled;
  final InputDecoration? decoration;

  const BrokerSelectionFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.decoration,
  });

  @override
  State<BrokerSelectionFormField> createState() =>
      _BrokerSelectionFormFieldState();
}

class _BrokerSelectionFormFieldState extends State<BrokerSelectionFormField> {
  late BrokerService _brokerService;
  List<BrokerModel> _brokers = [];
  bool _isLoading = true;
  String? _error;
  BrokerModel? _selectedBroker;

  @override
  void initState() {
    super.initState();
    _selectedBroker = widget.initialValue;
    _brokerService = BrokerService(
      apiService: context.read<ApiService>(),
    );
    _loadBrokers();
  }

  Future<void> _loadBrokers() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final brokers = await _brokerService.getBrokers();

      setState(() {
        _brokers = brokers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FormField<BrokerModel>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      builder: (FormFieldState<BrokerModel> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: field.hasError
                    ? Border.all(color: Colors.red, width: 1)
                    : Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
              ),
              child: _isLoading
                  ? _buildLoadingState(colorScheme)
                  : _error != null
                      ? _buildErrorState(colorScheme)
                      : _buildDropdownState(colorScheme, field),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 12),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontFamily: "Manrope-Regular",
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingState(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Loading brokers...',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
              fontFamily: "Manrope-Regular",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _error ?? 'Failed to load brokers',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontFamily: "Manrope-Regular",
              ),
            ),
          ),
          IconButton(
            onPressed: _loadBrokers,
            icon: Icon(
              Icons.refresh,
              color: colorScheme.primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownState(
      ColorScheme colorScheme, FormFieldState<BrokerModel> field) {
    return DropdownButtonFormField<BrokerModel>(
      value: _selectedBroker,
      decoration: widget.decoration ??
          InputDecoration(
            labelText: widget.labelText ?? 'Broker',
            labelStyle: TextStyle(
              color: colorScheme.onSurface,
              fontFamily: "Manrope-Regular",
            ),
            hintText: widget.hintText ?? 'Select a broker',
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.5),
              fontFamily: "Manrope-Regular",
            ),
            filled: true,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
      style: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 14,
        fontFamily: "Manrope-Regular",
      ),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: colorScheme.onSurface.withValues(alpha: 0.7),
      ),
      dropdownColor: colorScheme.surface,
      items: _brokers.map((BrokerModel broker) {
        return DropdownMenuItem<BrokerModel>(
          value: broker,
          child: Text(
            broker.name,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 14,
              fontFamily: "Manrope-Regular",
            ),
          ),
        );
      }).toList(),
      onChanged: widget.enabled
          ? (BrokerModel? newValue) {
              setState(() {
                _selectedBroker = newValue;
              });
              field.didChange(newValue);
              widget.onChanged?.call(newValue);
            }
          : null,
      validator: widget.validator,
    );
  }
}
