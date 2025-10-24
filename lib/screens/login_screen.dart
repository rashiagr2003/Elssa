import 'package:country_code_picker/country_code_picker.dart';
import 'package:elsaa/constants/app_colors.dart';
import 'package:elsaa/constants/responsive_utils.dart';
import 'package:elsaa/screens/otp_verification_screen.dart';
import 'package:elsaa/screens/service_location_screen.dart';
import 'package:elsaa/screens/sign_up_screen.dart';
import 'package:elsaa/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';

import 'home_screen.dart';
import 'widgets/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedDialCode = '+1';
  String _selectedCountryCode = 'US';
  bool _isLoading = false;
  bool _obscurePassword = true;
  final _authService = AuthService();
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);

    try {
      final userCredential = await _authService.signInWithGoogle();

      setState(() => _isGoogleLoading = false);

      if (userCredential != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Welcome ${userCredential.user?.displayName ?? "User"}!',
            ),
            backgroundColor: Colors.green,
          ),
        );
        // Navigate to home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LocationServicesScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Google sign-in cancelled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      setState(() => _isGoogleLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google sign-in failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Logging in with $_selectedDialCode ${_phoneController.text}',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              phoneNumber: _phoneController.text,
              verificationId: '',
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _buildIllustrationSection(context),
                _buildFormSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustrationSection(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      padding: EdgeInsets.symmetric(
        vertical: SpacingResponsive.getVerticalSpacing(context, factor: 2),
      ),
      child: SizedBox(
        height: screenHeight * 0.25,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Decorative circles
            Positioned(
              top: 20,
              right: 50,
              child: _circle(AppColors.lightBlue.withOpacity(0.3), 12),
            ),
            Positioned(
              bottom: 20,
              left: 40,
              child: _circle(AppColors.accent.withOpacity(0.3), 8),
            ),
            // Back Button

            // Main illustration
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: TypographyResponsive.getResponsiveFontSize(
                        context,
                        28,
                      ),
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  _buildSocialButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(Color color, double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );

  Widget _buildFormSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        SpacingResponsive.getSectionPadding(context).horizontal / 2,
        SpacingResponsive.getVerticalSpacing(context, factor: 3),
        SpacingResponsive.getSectionPadding(context).horizontal / 2,
        SpacingResponsive.getVerticalSpacing(context, factor: 4),
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
            ),
            _buildPhoneInputField(context),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
            ),

            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
            ),
            _buildLoginButton(context),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
            ),

            _buildForgotPasswordButton(context),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 4),
            ),
            _buildSignUpRedirect(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInputField(BuildContext context) {
    String? errorText;
    return StatefulBuilder(
      builder: (context, setInnerState) {
        void validate() {
          final error = Validator.validatePhoneNumber(
            _phoneController.text,
            _selectedDialCode,
          );
          setInnerState(() => errorText = error);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(
                  ComponentResponsive.getFormFieldBorderRadius(context),
                ),
                border: Border.all(
                  color: (errorText != null && errorText!.isNotEmpty)
                      ? Colors.red
                      : AppColors.inputBorder.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (code) {
                      setState(() {
                        _selectedDialCode = code.dialCode ?? '+1';
                        _selectedCountryCode = code.code ?? 'US';
                      });
                      validate();
                    },
                    initialSelection: 'US',
                    favorite: const ['+1', 'US', '+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    padding: EdgeInsets.zero,
                    textStyle: TextStyle(
                      fontSize: TypographyResponsive.getFormFieldFontSize(
                        context,
                      ),
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: ComponentResponsive.getFormFieldHeight(context),
                    color: AppColors.inputBorder,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontSize: TypographyResponsive.getFormFieldFontSize(
                          context,
                        ),
                        color: AppColors.textPrimary,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Enter Mobile Number',
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        errorStyle: TextStyle(fontSize: 0, height: 0),
                      ),
                      onChanged: (_) => validate(),
                      validator: (value) {
                        final error = Validator.validatePhoneNumber(
                          value,
                          _selectedDialCode,
                        );
                        setInnerState(() => errorText = error);
                        return error;
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (errorText != null && errorText!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  top: ComponentResponsive.getFormFieldVerticalPadding(context),
                  left:
                      ComponentResponsive.getFormFieldHorizontalPadding(
                        context,
                      ) /
                      2,
                ),
                child: Text(
                  errorText!,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: TypographyResponsive.getResponsiveFontSize(
                      context,
                      10,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Forgot password coming soon!')),
          );
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: TypographyResponsive.getFormFieldFontSize(context) - 2,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.buttonText,
          padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 16 : 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                'LOG IN',
                style: TextStyle(
                  fontSize: TypographyResponsive.getResponsiveFontSize(
                    context,
                    16,
                  ),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
      ),
    );
  }

  Widget _buildSocialButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        SizedBox(
          height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
        ),
        _buildGoogleSignInButton(context),
        SizedBox(
          height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
        ),
        _buildSocialButton(context, 'Continue with Facebook', Icons.facebook),
      ],
    );
  }

  Widget _buildSocialButton(BuildContext context, String label, IconData icon) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: OutlinedButton.icon(
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('$label login coming soon!')));
        },
        icon: Icon(
          icon,
          color: AppColors.primary,
          size: TypographyResponsive.getResponsiveFontSize(context, 20),
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: TypographyResponsive.getFormFieldFontSize(context) - 2,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.inputBorder, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildGoogleSignInButton(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: OutlinedButton.icon(
        onPressed: _isGoogleLoading ? null : _handleGoogleSignIn,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 14 : 16),
          side: BorderSide(
            color: AppColors.inputBorder.withOpacity(0.5),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.transparent,
        ),
        icon: _isGoogleLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Image.asset(
                'assets/google_logo.png', // Add Google logo to assets
                height: 24,
                width: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.g_mobiledata,
                    size: 28,
                    color: Colors.red,
                  );
                },
              ),
        label: Text(
          'Continue with Google',
          style: TextStyle(
            fontSize: TypographyResponsive.getResponsiveFontSize(context, 15),
            color: Colors.red,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "DON'T HAVE AN ACCOUNT? ",
          style: TextStyle(
            fontSize: TypographyResponsive.getFormFieldFontSize(context),
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigating to sign up...')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text(
            'SIGN UP',
            style: TextStyle(
              fontSize: TypographyResponsive.getFormFieldFontSize(context),
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
