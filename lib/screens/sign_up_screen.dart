import 'package:elsaa/constants/app_colors.dart';
import 'package:elsaa/constants/responsive_utils.dart';
import 'package:elsaa/screens/login_screen.dart';
import 'package:elsaa/screens/otp_verification_screen.dart';
import 'package:elsaa/constants/validators.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String _selectedDialCode = '+1';
  String _selectedCountryCode = 'US';
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Signing up with $_selectedDialCode ${_phoneController.text}',
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OTPVerificationScreen(phoneNumber: _phoneController.text),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
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
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: SpacingResponsive.getVerticalSpacing(context, factor: 4),
      ),
      child: SizedBox(
        height: screenHeight * 0.3,
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
              bottom: 40,
              left: 40,
              child: _circle(AppColors.accent.withOpacity(0.3), 8),
            ),
            Positioned(
              top: 80,
              left: 30,
              child: _circle(Colors.orange.withOpacity(0.3), 6),
            ),
            // Main illustration icon
            Center(
              child: Container(
                padding: EdgeInsets.all(
                  SpacingResponsive.getVerticalSpacing(context, factor: 5),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.weekend_rounded,
                  size: TypographyResponsive.getResponsiveFontSize(
                    context,
                    100,
                  ),
                  color: AppColors.primary,
                ),
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
            // Title
            Text(
              'Your Home Services Expert',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TypographyResponsive.getResponsiveFontSize(
                  context,
                  22,
                ),
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 1),
            ),
            // Subtitle
            Text(
              'Continue with Phone Number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: TypographyResponsive.getResponsiveFontSize(
                  context,
                  18,
                ),
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 3),
            ),
            _buildPhoneInputField(context),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 3),
            ),
            _buildSignUpButton(context),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 2),
            ),
            _buildOtherOptionButton(context),
            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 3),
            ),

            SizedBox(
              height: SpacingResponsive.getVerticalSpacing(context, factor: 3),
            ),
            _buildLoginRedirect(context),
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

  Widget _buildSignUpButton(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleSignUp,
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
                'SIGN UP',
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

  Widget _buildOtherOptionButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Other login options coming soon!')),
        );
      },
      child: Text(
        'VIEW OTHER OPTION',
        style: TextStyle(
          fontSize: TypographyResponsive.getFormFieldFontSize(context),
          color: AppColors.accent,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 150,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.inputBorder,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildLoginRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ALREADY HAVE AN ACCOUNT? ',
          style: TextStyle(
            fontSize: TypographyResponsive.getFormFieldFontSize(context) - 2,
            color: AppColors.textSecondary,
            letterSpacing: 0.5,
          ),
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigating to login...')),
            );

            // Navigate to LoginScreen using MaterialPageRoute
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ), // Replace LoginScreen with your screen
            );
          },
          child: Text(
            'LOG IN',
            style: TextStyle(
              fontSize: TypographyResponsive.getFormFieldFontSize(context) - 2,
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
