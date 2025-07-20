import 'package:flutter/material.dart';

enum TileType {
  regular,
  withSwitch,
  withBadge,
  withCountryFlag,
  logout,
}

class ProfileTileBadge {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const ProfileTileBadge({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.fontSize = 10,
  });

  static const ProfileTileBadge verified = ProfileTileBadge(
    text: "Verified",
    backgroundColor: Color(0xffE8F5E9),
    textColor: Color(0xff2E7D32),
  );
}

class ProfileTile extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final VoidCallback? onTap;
  final TileType tileType;
  final ProfileTileBadge? badge;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final String? countryFlagImage;
  final double imageScale;
  final bool centerImage;
  final Widget? trailingWidget;

  const ProfileTile({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    this.onTap,
    this.tileType = TileType.regular,
    this.badge,
    this.switchValue,
    this.onSwitchChanged,
    this.countryFlagImage,
    this.imageScale = 3,
    this.centerImage = false,
    this.trailingWidget,
  });

  const ProfileTile.regular({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    this.onTap,
    this.imageScale = 3,
    this.centerImage = false,
    this.trailingWidget,
  })  : tileType = TileType.regular,
        badge = null,
        switchValue = null,
        onSwitchChanged = null,
        countryFlagImage = null;

  const ProfileTile.withSwitch({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.switchValue,
    required this.onSwitchChanged,
    this.imageScale = 3,
    this.centerImage = false,
  })  : tileType = TileType.withSwitch,
        onTap = null,
        badge = null,
        countryFlagImage = null,
        trailingWidget = null;

  const ProfileTile.withBadge({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.badge,
    this.onTap,
    this.imageScale = 3,
    this.centerImage = false,
  })  : tileType = TileType.withBadge,
        switchValue = null,
        onSwitchChanged = null,
        countryFlagImage = null,
        trailingWidget = null;

  const ProfileTile.withCountryFlag({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.countryFlagImage,
    this.onTap,
    this.imageScale = 3,
    this.centerImage = false,
  })  : tileType = TileType.withCountryFlag,
        badge = null,
        switchValue = null,
        onSwitchChanged = null,
        trailingWidget = null;

  const ProfileTile.logout({
    super.key,
    required this.onTap,
  })  : image = "",
        name = "Logout",
        description = "",
        tileType = TileType.logout,
        badge = null,
        switchValue = null,
        onSwitchChanged = null,
        countryFlagImage = null,
        imageScale = 3,
        centerImage = false,
        trailingWidget = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    switch (tileType) {
      case TileType.logout:
        return _buildLogoutTile(colorScheme);
      default:
        return _buildRegularTile(colorScheme);
    }
  }

  Widget _buildLogoutTile(ColorScheme colorScheme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorScheme.surface,
          border: Border.all(color: colorScheme.outline),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.logout,
                color: colorScheme.onSurface,
                size: 24,
              ),
              const SizedBox(width: 15),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Manrope-Bold",
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: colorScheme.onSurfaceVariant,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegularTile(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colorScheme.outline),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                _buildIconContainer(colorScheme),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Manrope_bold",
                              fontSize: 14,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: 8),
                            _buildBadge(),
                          ],
                        ],
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: "Manrope_bold",
                          fontSize: 12,
                          letterSpacing: 0.2,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTrailingWidget(colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(ColorScheme colorScheme) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: colorScheme.surfaceContainer,
      ),
      child: centerImage
          ? Center(
              child: Image.asset(
                image,
                scale: imageScale,
                color: colorScheme.onSurfaceVariant,
              ),
            )
          : Image.asset(
              image,
              scale: imageScale,
              color: colorScheme.onSurfaceVariant,
            ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: badge!.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        badge!.text,
        style: TextStyle(
          color: badge!.textColor,
          fontSize: badge!.fontSize,
          fontFamily: "Manrope-Regular",
        ),
      ),
    );
  }

  Widget _buildTrailingWidget(ColorScheme colorScheme) {
    if (trailingWidget != null) {
      return trailingWidget!;
    }

    switch (tileType) {
      case TileType.withCountryFlag:
        if (countryFlagImage != null) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(countryFlagImage!),
              ),
              const SizedBox(width: 8),
              _buildArrowIcon(colorScheme),
            ],
          );
        }
        break;
      case TileType.withSwitch:
        return Switch(
          value: switchValue ?? false,
          onChanged: onSwitchChanged,
        );
      default:
        break;
    }

    return _buildArrowIcon(colorScheme);
  }

  Widget _buildArrowIcon(ColorScheme colorScheme) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: colorScheme.onSurfaceVariant,
          size: 18,
        ),
      ),
    );
  }
}
