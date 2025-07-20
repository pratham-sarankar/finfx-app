import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LotSizeScreen extends StatefulWidget {
  const LotSizeScreen({super.key, this.initialValue = 0});
  final double initialValue;
  @override
  State<LotSizeScreen> createState() => _LotSizeScreenState();
}

class _LotSizeScreenState extends State<LotSizeScreen> {
  late double _lotSize;
  late final TextEditingController _controller;
  String? _errorMessage;

  @override
  void initState() {
    _lotSize = widget.initialValue;
    _controller = TextEditingController(text: _lotSize.toStringAsFixed(2))
      ..addListener(
        () {
          final value = double.tryParse(_controller.text);
          if (value != null) {
            setState(() {
              _lotSize = value;
              _errorMessage = null;
            });
          }
        },
      );
    super.initState();
  }

  void _updateController() {
    _controller.value = _controller.value.copyWith(
      text: _lotSize.toStringAsFixed(2),
      selection:
          TextSelection.collapsed(offset: _lotSize.toStringAsFixed(2).length),
    );
  }

  void _increment() {
    setState(() {
      _lotSize += 0.1;
      _lotSize = double.parse(_lotSize.toStringAsFixed(2));
      _errorMessage = null;
      _updateController();
    });
  }

  void _decrement() {
    setState(() {
      _lotSize = (_lotSize - 0.1).clamp(0, double.infinity);
      _lotSize = double.parse(_lotSize.toStringAsFixed(2));
      _errorMessage = null;
      _updateController();
    });
  }

  bool _validateLotSize() {
    final value = double.tryParse(_controller.text);
    if (value == null) {
      setState(() {
        _errorMessage = "Please enter a valid number";
      });
      return false;
    }
    if (value <= 0) {
      setState(() {
        _errorMessage = "Lot size must be greater than 0";
      });
      return false;
    }
    return true;
  }

  void _onContinue() {
    if (_validateLotSize()) {
      Navigator.of(context).pop(_lotSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Lot Size"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Stack(
          children: [
            Column(
              children: [
                TextField(
                  controller: _controller,
                  style: TextStyle(color: colorScheme.onSurface),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Lot Size",
                    fillColor: colorScheme.surfaceContainer,
                    prefixIcon: Icon(CupertinoIcons.number_square_fill),
                    prefixIconColor:
                        colorScheme.onSurface.withValues(alpha: 0.8),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintStyle: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    errorStyle: TextStyle(
                      color: colorScheme.error,
                      fontSize: 12,
                    ),
                    errorText: _errorMessage,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    FilledButton(
                      onPressed: _decrement,
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Text("-0.1"),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: _increment,
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      child: Text("+0.1"),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
            Positioned(
              bottom: 12,
              right: 5,
              left: 5,
              child: ElevatedButton(
                onPressed: _onContinue,
                style: ButtonStyle(
                    minimumSize: WidgetStatePropertyAll(Size(0, 55)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)))),
                child: Text("Continue"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
