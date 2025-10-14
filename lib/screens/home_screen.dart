import 'package:elsaa/constants/responsive_utils.dart';
import 'package:elsaa/screens/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

// Main Screen
class HomeServicesScreen extends StatefulWidget {
  const HomeServicesScreen({Key? key}) : super(key: key);

  @override
  State<HomeServicesScreen> createState() => _HomeServicesScreenState();
}

class _HomeServicesScreenState extends State<HomeServicesScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationHeader(),
              HeroSection(),
              SizedBox(height: SpacingResponsive.getVerticalSpacing(context)),
              ServiceCategories(),
              SizedBox(
                height: SpacingResponsive.getVerticalSpacing(
                  context,
                  factor: 1.5,
                ),
              ),
              PopularServicesSection(),

              CleaningServicesSection(),

              FeaturesBadges(),
              SizedBox(
                height: SpacingResponsive.getVerticalSpacing(
                  context,
                  factor: 1.5,
                ),
              ),
              WhyChooseUsSection(),
              SizedBox(
                height: SpacingResponsive.getVerticalSpacing(
                  context,
                  factor: 1.5,
                ),
              ),
              SafetyMeasuresSection(),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Location Header Widget
class LocationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final fontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          16,
        );
        final subFontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          12,
        );

        return Padding(
          padding: padding,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on_outlined, size: fontSize),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, size: fontSize + 4),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Inner Circle, Connaught Place, New Delhi, Del...',
                      style: TextStyle(
                        fontSize: subFontSize,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                iconSize: ComponentResponsive.getAppBarIconSize(context),
                onPressed: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

// Hero Section with Background Image
class HeroSection extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.build, 'label': 'Renovation'},
    {'icon': Icons.construction, 'label': 'Handyman'},
    {'icon': Icons.home_work, 'label': 'Home shifting'},
    {'icon': Icons.yard, 'label': 'Gardening'},
    {'icon': Icons.cleaning_services, 'label': 'Declutter'},
    {'icon': Icons.format_paint, 'label': 'Painting'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final screenHeight = MediaQuery.of(context).size.height;
        final heroHeight = ResponsiveUtils.isTablet(context)
            ? screenHeight * 0.31
            : screenHeight * 0.28;
        final fontSize = TypographyResponsive.getResponsiveFontSize(
          context,
          14,
        );
        final iconSize = TypographyResponsive.getResponsiveFontSize(
          context,
          18,
        );

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: padding.left),
          height: heroHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context),
            ),
            image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=800',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding.left,
              vertical: padding.top,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: menuItems.map((item) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item['icon'], color: Colors.white, size: iconSize),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        item['label'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// Service Categories Grid
class ServiceCategories extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.build_outlined, 'label': 'Renovation'},
    {'icon': Icons.construction_outlined, 'label': 'Handyman'},
    {'icon': Icons.moving_outlined, 'label': 'Home shifting'},
    {'icon': Icons.content_cut_outlined, 'label': 'Gardening'},
    {'icon': Icons.chair_outlined, 'label': 'Declutter'},
    {'icon': Icons.format_paint_outlined, 'label': 'Painting'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final padding = SpacingResponsive.getSectionPadding(context);
        final screenWidth = MediaQuery.of(context).size.width;

        // Calculate grid columns based on screen width
        int crossAxisCount = 3;
        if (ResponsiveUtils.isDesktop(context)) {
          crossAxisCount = 6;
        } else if (ResponsiveUtils.isLargeTablet(context)) {
          crossAxisCount = 4;
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: padding.left),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              crossAxisSpacing: SpacingResponsive.getVerticalSpacing(context),
              mainAxisSpacing: SpacingResponsive.getVerticalSpacing(context),
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ServiceCategoryCard(
                icon: categories[index]['icon'],
                label: categories[index]['label'],
              );
            },
          ),
        );
      },
    );
  }
}

// Service Category Card
class ServiceCategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const ServiceCategoryCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final iconSize = constraints.maxWidth * 0.35;
        final fontSize = TypographyResponsive.getTitleFontSize(context);

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context, factor: 0.02),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: Colors.blue[700]),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
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

// Popular Services Section
