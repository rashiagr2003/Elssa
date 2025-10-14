import 'package:elsaa/constants/responsive_utils.dart';
import 'package:elsaa/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ServiceLocationScreen extends StatelessWidget {
  const ServiceLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: SpacingResponsive.getVerticalSpacing(
                      context,
                      factor: 20,
                    ),
                  ),

                  Image.asset('assets/service_text.png'),
                ],
              ),
            ),
            Column(
              children: [
                LocationCTAButtons(
                  onCurrentLocationTap: () {
                    print('Current location tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeServicesScreen(),
                      ),
                    );
                  },
                  onOtherLocationTap: () {
                    print('Other location tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeServicesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LocationCTAButtons extends StatelessWidget {
  final VoidCallback? onCurrentLocationTap;
  final VoidCallback? onOtherLocationTap;

  const LocationCTAButtons({
    Key? key,
    this.onCurrentLocationTap,
    this.onOtherLocationTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary Button - Current Location
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onCurrentLocationTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C1C1E),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.my_location, size: 20, color: Colors.white),
                  const SizedBox(width: 12),
                  Text(
                    'Your current location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Secondary Button - Other Location
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton(
              onPressed: onOtherLocationTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF8E8E93),
                side: BorderSide(color: const Color(0xFFE5E5EA), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                backgroundColor: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 20, color: const Color(0xFF8E8E93)),
                  const SizedBox(width: 12),
                  Text(
                    'Some other location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: SpacingResponsive.getVerticalSpacing(context, factor: 4),
          ),
        ],
      ),
    );
  }
}

// Example usage in a screen
class LocationServicesScreen extends StatelessWidget {
  const LocationServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hey, nice to meet you!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF8E8E93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'See services around',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Illustration placeholder
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/location_illustration.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            LocationCTAButtons(
              onCurrentLocationTap: () {
                print('Current location tapped');
                // Handle current location action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeServicesScreen()),
                );
              },
              onOtherLocationTap: () {
                print('Other location tapped');
                // Handle other location action
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeServicesScreen()),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
