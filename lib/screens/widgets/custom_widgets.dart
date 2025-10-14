import 'package:elsaa/constants/responsive_utils.dart';
import 'package:flutter/material.dart';

class PopularServicesSection extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'image':
          'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
      'title': 'Kitchen Cleaning',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      'title': 'Sofa Cleaning',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?w=400',
      'title': 'Full Home',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final headerFontSize = TypographyResponsive.getHeaderFontSize(context);
        final listHeight =
            CardResponsive.getSpecialityListHeight(context) * 0.7;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              child: Text(
                'Popular Services',
                style: TextStyle(
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: SpacingResponsive.getVerticalSpacing(context)),
            SizedBox(
              height: listHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: padding.left),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(
                    image: services[index]['image']!,
                    title: services[index]['title']!,
                    isLast: index == services.length - 1,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// Cleaning Services Section
class CleaningServicesSection extends StatelessWidget {
  final List<Map<String, String>> services = [
    {
      'image':
          'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=400',
      'title': 'Kitchen Cleaning',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      'title': 'Sofa Cleaning',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?w=400',
      'title': 'Full Home',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final headerFontSize = TypographyResponsive.getHeaderFontSize(context);
        final listHeight =
            CardResponsive.getSpecialityListHeight(context) * 0.65;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padding.left),
              child: Text(
                'Cleaning Services',
                style: TextStyle(
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: SpacingResponsive.getVerticalSpacing(context)),
            SizedBox(
              height: listHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: padding.left),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(
                    image: services[index]['image']!,
                    title: services[index]['title']!,
                    isLast: index == services.length - 1,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

// Service Card Widget
class ServiceCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isLast;

  const ServiceCard({
    required this.image,
    required this.title,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = MediaQuery.of(context).size.width * 0.38;
        final imageHeight =
            ComponentResponsive.getSpecialityImageHeight(context) * 0.8;
        final fontSize = TypographyResponsive.getTitleFontSize(context);
        final margin = SpacingResponsive.getCardMargin(context);

        return Container(
          width: cardWidth,
          margin: isLast ? EdgeInsets.zero : margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.getBorderRadius(context, factor: 0.02),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Features Badges
class FeaturesBadges extends StatelessWidget {
  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.schedule,
      'color': Colors.blue,
      'label': 'Trusted & Scheduled',
    },
    {
      'icon': Icons.verified_user,
      'color': Colors.green,
      'label': 'Verified Partners',
    },
    {
      'icon': Icons.star,
      'color': Colors.orange,
      'label': 'Satisfaction Guarantee',
    },
    {
      'icon': Icons.attach_money,
      'color': Colors.purple,
      'label': 'Upfront Pricing',
    },
    {
      'icon': Icons.workspace_premium,
      'color': Colors.amber,
      'label': 'Trained Professionals',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final screenHeight = MediaQuery.of(context).size.height;
        final badgeHeight = screenHeight * 0.12;

        return Container(
          height: badgeHeight,
          color: Colors.white,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: padding.left,
              vertical: 15,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              return FeatureBadge(
                icon: features[index]['icon'],
                color: features[index]['color'],
                label: features[index]['label'],
                isLast: index == features.length - 1,
              );
            },
          ),
        );
      },
    );
  }
}

// Feature Badge Widget
class FeatureBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final bool isLast;

  const FeatureBadge({
    required this.icon,
    required this.color,
    required this.label,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final badgeWidth = ResponsiveUtils.isTablet(context)
            ? screenWidth * 0.18
            : screenWidth * 0.22;
        final iconSize = TypographyResponsive.getResponsiveFontSize(
          context,
          28,
        );
        final fontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          10,
        );

        return Container(
          width: badgeWidth,
          margin: isLast ? EdgeInsets.zero : EdgeInsets.only(right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  width: badgeWidth * 0.7,
                  height: badgeWidth * 0.7,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: iconSize),
                ),
              ),
              SizedBox(height: 8),
              Flexible(
                flex: 2,
                child: Text(
                  label,
                  style: TextStyle(fontSize: fontSize),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Why Choose Us Section
class WhyChooseUsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final headerFontSize = TypographyResponsive.getHeaderFontSize(context);
        final iconSize = TypographyResponsive.getResponsiveFontSize(
          context,
          24,
        );

        return Container(
          margin: EdgeInsets.symmetric(horizontal: padding.left),
          padding: SpacingResponsive.getCardPadding(context) * 2.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.info_outline, size: iconSize),
                  ),
                  SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'Why Choose Us',
                      style: TextStyle(
                        fontSize: headerFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SpacingResponsive.getVerticalSpacing(
                  context,
                  factor: 1.5,
                ),
              ),
              WhyChooseUsItem(
                icon: '🏅',
                title: 'Quality Assurance',
                description: 'Your satisfaction is guaranteed',
              ),
              SizedBox(height: SpacingResponsive.getVerticalSpacing(context)),
              WhyChooseUsItem(
                icon: '💰',
                title: 'Fixed Prices',
                description:
                    'No hidden costs, all the prices are known and fixed before booking',
              ),
              SizedBox(height: SpacingResponsive.getVerticalSpacing(context)),
              WhyChooseUsItem(
                icon: '👋',
                title: 'Hassel free',
                description: 'convenient, time-saving and secure',
              ),
            ],
          ),
        );
      },
    );
  }
}

// Why Choose Us Item
class WhyChooseUsItem extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const WhyChooseUsItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final titleFontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          16,
        );
        final descFontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          13,
        );
        final emojiSize = TypographyResponsive.getResponsiveFontSize(
          context,
          32,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(icon, style: TextStyle(fontSize: emojiSize)),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: descFontSize,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Safety Measures Section
class SafetyMeasuresSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final headerFontSize = TypographyResponsive.getHeaderFontSize(context);

        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          margin: EdgeInsets.symmetric(horizontal: padding.left),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Best-in Class Safety Measures',
                style: TextStyle(
                  fontSize: headerFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SafetyMeasureItem(
                icon: Icons.masks_outlined,
                title: 'Usage of masks, gloves & Sanitisers',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SafetyMeasureItem(
                icon: Icons.social_distance_outlined,
                title: 'Low-contact Service Experience',
                description:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
            ],
          ),
        );
      },
    );
  }
}

// Safety Measure Item
class SafetyMeasureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SafetyMeasureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = TypographyResponsive.getResponsiveFontSize(
          context,
          40,
        );
        final titleFontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          15,
        );
        final descFontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          12,
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: descFontSize,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Custom Bottom Navigation Bar
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final fontSize = TypographyResponsive.getResponsiveFontSize(context, 12);
    final iconSize = ComponentResponsive.getAppBarIconSize(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        selectedFontSize: fontSize,
        unselectedFontSize: fontSize * 0.9,
        elevation: 0,
        backgroundColor: Colors.white,
        iconSize: iconSize,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard_outlined),
            activeIcon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
