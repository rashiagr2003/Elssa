import 'package:flutter/material.dart';

/// Centralized responsive utilities for consistent sizing across the app
class ResponsiveUtils {
  // Private constructor to prevent instantiation
  ResponsiveUtils._();

  /// Device type detection
  static bool isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide >= 600;
  }

  static bool isLargeTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 900;
  }

  static bool isDesktop(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 1200;
  }

  /// Screen size categories
  static ScreenSize getScreenSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) return ScreenSize.extraSmall;
    if (screenWidth < 480) return ScreenSize.small;
    if (screenWidth < 600) return ScreenSize.medium;
    if (screenWidth < 900) return ScreenSize.large;
    if (screenWidth < 1200) return ScreenSize.extraLarge;
    return ScreenSize.desktop;
  }

  /// Get responsive spacing based on screen width
  static double getSpacing(BuildContext context, {double factor = 0.02}) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * factor;
  }

  /// Get responsive border radius
  static double getBorderRadius(BuildContext context, {double factor = 0.03}) {
    final screenWidth = MediaQuery.of(context).size.width;
    double baseRadius = screenWidth * factor;
    return baseRadius.clamp(8.0, 20.0); // Reasonable min/max values
  }
}

/// Screen size enumeration for easy categorization
enum ScreenSize {
  extraSmall, // < 360px
  small, // 360-480px
  medium, // 480-600px
  large, // 600-900px
  extraLarge, // 900-1200px
  desktop, // 1200px+
}

/// Card-specific responsive utilities
class CardResponsive {
  /// OPTIMIZED: Calculate card width to show exactly 3 cards
  static double getSpecialityCardWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    const horizontalPadding = 13.0 * 2; // left + right padding
    const spacingBetweenCards = 12.0; // gap between each card
    const numberOfCards = 3;

    // Total spacing = padding + gaps
    const totalSpacing =
        horizontalPadding + (spacingBetweenCards * (numberOfCards - 1));

    return (screenWidth - totalSpacing) / numberOfCards;
  }

  static double getHealthConcernCardWidth(BuildContext context) {
    return getSpecialityCardWidth(context); // Same width for consistency
  }

  /// OPTIMIZED: Card height based on screen dimensions and aspect ratio
  static double getSpecialityCardHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Use aspect ratio approach for better consistency
    if (screenWidth < 600) {
      return screenHeight * 0.3; // Mobile: 25% of screen height
    } else if (screenWidth < 900) {
      return screenHeight * 0.28; // Tablet portrait: 28% of screen height
    } else {
      return screenHeight * 0.32; // Tablet landscape: 32% of screen height
    }
  }

  /// List height should match card height with small buffer
  static double getSpecialityListHeight(BuildContext context) {
    return getSpecialityCardHeight(context);
  }

  /// Health concern list height (slightly taller for more content)
  static double getHealthConcernListHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return screenHeight * 0.29; // Mobile: slightly taller
    } else if (screenWidth < 900) {
      return screenHeight * 0.30; // Tablet portrait
    } else {
      return screenHeight * 0.36; // Tablet landscape
    }
  }
}

/// Typography responsive utilities
class TypographyResponsive {
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall: // very small phones
        return baseSize * 0.75;
      case ScreenSize.small: // small phones
        return baseSize * 0.85;
      case ScreenSize.medium: // normal phones
        return baseSize * 0.95;
      case ScreenSize.large: // tablets
        return baseSize; // keep as is
      case ScreenSize.extraLarge: // large tablets
        return baseSize * 1.1;
      case ScreenSize.desktop: // desktop
        return baseSize * 1.2;
    }
  }

  /// OPTIMIZED: Title font sizes for consistent readability
  static double getTitleFontSize(
    BuildContext context, {
    bool isHealthConcern = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    double fontSize;
    if (screenWidth < 600) {
      fontSize = isHealthConcern ? 11 : 12; // Mobile
    } else if (screenWidth < 900) {
      fontSize = isHealthConcern ? 13 : 14; // Tablet portrait
    } else {
      fontSize = isHealthConcern ? 15 : 16; // Tablet landscape
    }

    return fontSize;
  }

  /// Subtitle font sizes (for health concerns)
  static double getSubtitleFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 10; // Mobile
    } else if (screenWidth < 900) {
      return 11; // Tablet portrait
    } else {
      return 12; // Tablet landscape
    }
  }

  /// OPTIMIZED: Button font sizes
  static double getButtonFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 10; // Mobile
    } else if (screenWidth < 900) {
      return 12; // Tablet portrait
    } else {
      return 14; // Tablet landscape
    }
  }

  /// Header font sizes
  static double getHeaderFontSize(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 18;
      case ScreenSize.small:
        return 19;
      case ScreenSize.medium:
        return 20;
      case ScreenSize.large:
        return 21;
      case ScreenSize.extraLarge:
        return 22;
      case ScreenSize.desktop:
        return 24;
    }
  }

  /// Form field label font sizes
  static double getLabelFontSize(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 14;
      case ScreenSize.small:
        return 15;
      case ScreenSize.medium:
        return 16;
      case ScreenSize.large:
        return 17;
      case ScreenSize.extraLarge:
        return 18;
      case ScreenSize.desktop:
        return 19;
    }
  }

  /// Form field input font sizes
  static double getFormFieldFontSize(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 14;
      case ScreenSize.small:
        return 15;
      case ScreenSize.medium:
        return 16;
      case ScreenSize.large:
        return 17;
      case ScreenSize.extraLarge:
        return 18;
      case ScreenSize.desktop:
        return 19;
    }
  }
}

/// Component dimension utilities
class ComponentResponsive {
  static double getAppBarTitleLeftPadding(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 32;
      case ScreenSize.large:
        return 32;
      case ScreenSize.extraLarge:
        return 32;
      case ScreenSize.desktop:
        return 36;
    }
  }

  /// OPTIMIZED: Button heights for cards
  static double getButtonHeight(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 32; // Mobile
    } else if (screenWidth < 900) {
      return 34; // Tablet portrait
    } else {
      return 36; // Tablet landscape
    }
  }

  static double getAppBarHeight(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 56; // normal phones
      case ScreenSize.large:
        return 64; // tablets
      case ScreenSize.extraLarge:
        return 72; // big tablets
      case ScreenSize.desktop:
        return 80; // desktop
    }
  }

  static double getAppBarLeadingSize(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 40; // phones
      case ScreenSize.large: // tablets
        return 54.6;
      case ScreenSize.extraLarge:
        return 56; // big tablets
      case ScreenSize.desktop:
        return 60;
    }
  }

  static double getAppBarLeadingRadius(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 8;
      case ScreenSize.large:
      case ScreenSize.extraLarge:
      case ScreenSize.desktop:
        return 12;
    }
  }

  static double getAppBarIconSize(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 24;
      case ScreenSize.large:
      case ScreenSize.extraLarge:
        return 30; // bigger on tablets
      case ScreenSize.desktop:
        return 32;
    }
  }

  static double getAppBarLeadingMargin(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);
    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 15;
      case ScreenSize.large:
      case ScreenSize.extraLarge:
      case ScreenSize.desktop:
        return 18;
    }
  }

  /// OPTIMIZED: Image heights based on card proportions
  static double getSpecialityImageHeight(BuildContext context) {
    final cardHeight = CardResponsive.getSpecialityCardHeight(context);
    return cardHeight * 0.6; // 60% of card height for image
  }

  static double getHealthConcernImageHeight(BuildContext context) {
    final cardHeight = CardResponsive.getSpecialityCardHeight(context);
    return cardHeight *
        0.4; // 55% of card height for image in health concerns (increased)
  }

  /// Dropdown dimensions
  static double getDropdownWidth(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 150;
      case ScreenSize.small:
        return 180;
      case ScreenSize.medium:
        return 200;
      case ScreenSize.large:
        return 320;
      case ScreenSize.extraLarge:
        return 340;
      case ScreenSize.desktop:
        return 361;
    }
  }

  /// Dropdown icon size
  static double getDropdownIconSize(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 20;
      case ScreenSize.small:
        return 22;
      case ScreenSize.medium:
        return 24;
      case ScreenSize.large:
        return 26;
      case ScreenSize.extraLarge:
        return 28;
      case ScreenSize.desktop:
        return 30;
    }
  }

  /// Form field dimensions
  static double getFormFieldHeight(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 50;
      case ScreenSize.small:
        return 52;
      case ScreenSize.medium:
        return 54;
      case ScreenSize.large:
        return 56;
      case ScreenSize.extraLarge:
        return 58;
      case ScreenSize.desktop:
        return 60;
    }
  }

  static double getFormFieldBorderRadius(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
      case ScreenSize.small:
      case ScreenSize.medium:
        return 8;
      case ScreenSize.large:
      case ScreenSize.extraLarge:
      case ScreenSize.desktop:
        return 10;
    }
  }

  static double getFormFieldVerticalPadding(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 14;
      case ScreenSize.small:
        return 15;
      case ScreenSize.medium:
        return 16;
      case ScreenSize.large:
        return 17;
      case ScreenSize.extraLarge:
        return 18;
      case ScreenSize.desktop:
        return 19;
    }
  }

  static double getFormFieldHorizontalPadding(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 12;
      case ScreenSize.small:
        return 14;
      case ScreenSize.medium:
        return 16;
      case ScreenSize.large:
        return 18;
      case ScreenSize.extraLarge:
        return 20;
      case ScreenSize.desktop:
        return 22;
    }
  }

  /// Logo heights
  static double getLogoHeight(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return 35;
      case ScreenSize.small:
        return 40;
      case ScreenSize.medium:
        return 50;
      case ScreenSize.large:
        return 60;
      case ScreenSize.extraLarge:
        return 70;
      case ScreenSize.desktop:
        return 80;
    }
  }
}

/// Padding and margin utilities
class SpacingResponsive {
  /// OPTIMIZED: Card padding for better proportions
  static EdgeInsets getCardPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 4.0,
      ); // Mobile
    } else if (screenWidth < 900) {
      return EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0);
      ; // Tablet portrait
    } else {
      return const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 8.0,
      ); // Tablet landscape
    }
  }

  /// OPTIMIZED: List padding for 3-card layout
  static EdgeInsets getListPadding(BuildContext context) {
    return const EdgeInsets.symmetric(horizontal: 8.0);
  }

  static EdgeInsets getCardMargin(BuildContext context) {
    return const EdgeInsets.only(right: 12.0);
  }

  static EdgeInsets getSectionPadding(BuildContext context) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    switch (screenSize) {
      case ScreenSize.extraSmall:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ScreenSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case ScreenSize.medium:
        return const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
      case ScreenSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
      case ScreenSize.extraLarge:
        return const EdgeInsets.symmetric(horizontal: 22, vertical: 16);
      case ScreenSize.desktop:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 18);
    }
  }

  /// Vertical spacing
  static double getVerticalSpacing(
    BuildContext context, {
    double factor = 1.0,
  }) {
    final screenSize = ResponsiveUtils.getScreenSize(context);

    double baseSpacing = switch (screenSize) {
      ScreenSize.extraSmall => 8,
      ScreenSize.small => 10,
      ScreenSize.medium => 12,
      ScreenSize.large => 14,
      ScreenSize.extraLarge => 16,
      ScreenSize.desktop => 20,
    };

    return baseSpacing * factor;
  }
}
