import 'package:finfx/dark_mode.dart';
import 'package:finfx/features/bot/presentation/screen/bot_detail_screen.dart';
import 'package:finfx/features/home/data/models/bot_model.dart';
import 'package:finfx/screens/config/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BotCard extends StatelessWidget {
  const BotCard({super.key, required this.bot});
  final BotModel bot;
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ColorNotifire>(context, listen: true);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BotDetailsScreen(
              bot: bot,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: notifier.container,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: notifier.textColor.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: notifier.textColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    Icon(Icons.show_chart, color: Color(0xff2e9844), size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bot.name,
                      style: TextStyle(
                        color: notifier.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    AppConstants.Height(3),
                    Text(
                      "Connected",
                      style: TextStyle(
                        color: notifier.textColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              CupertinoSwitch(
                value: true,
                onChanged: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
