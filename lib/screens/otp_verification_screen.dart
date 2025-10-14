import 'package:elsaa/constants/app_colors.dart';
import 'package:elsaa/constants/responsive_utils.dart';
import 'package:elsaa/screens/service_location_screen.dart';
import 'package:elsaa/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({Key? key, required this.phoneNumber})
    : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  bool _isLoading = false;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOtpInput(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if current field is filled
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // All fields filled, unfocus keyboard
        _focusNodes[index].unfocus();
      }
    }
  }

  void _handleBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  String _getOTP() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  bool _isOTPComplete() {
    return _otpControllers.every((controller) => controller.text.isNotEmpty);
  }

  void _handleVerify() {
    if (_isOTPComplete()) {
      setState(() => _isLoading = true);

      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP Verified: ${_getOTP()}'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceLocationScreen()),
        );
      });
    }
  }

  void _handleResendOTP() {
    setState(() => _resendCountdown = 30);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('OTP resent to your phone number'),
        backgroundColor: Colors.blue,
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      _startCountdown();
    });
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_resendCountdown > 1 && mounted) {
        setState(() => _resendCountdown--);
        _startCountdown();
      } else if (mounted) {
        setState(() => _resendCountdown = 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: TypographyResponsive.getResponsiveFontSize(
                          context,
                          24,
                        ),
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 3,
                  ),
                ),

                // Illustration Section
                SizedBox(
                  height: screenHeight * 0.3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Decorative circle
                      Positioned(
                        top: 20,
                        right: 40,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Main icon illustration
                      Center(
                        child: Icon(
                          Icons.phone_android_rounded,
                          size: TypographyResponsive.getResponsiveFontSize(
                            context,
                            100,
                          ),
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 2,
                  ),
                ),

                // Title
                Text(
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: TypographyResponsive.getHeaderFontSize(context),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 1,
                  ),
                ),

                // Subtitle with phone number
                Text(
                  'Enter the OTP sent to ${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: TypographyResponsive.getFormFieldFontSize(
                      context,
                    ),
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 3,
                  ),
                ),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SpacingResponsive.getVerticalSpacing(
                          context,
                          factor: 0.8,
                        ),
                      ),
                      child: SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _otpControllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            fontSize:
                                TypographyResponsive.getResponsiveFontSize(
                                  context,
                                  28,
                                ),
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.inputBorder,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.inputBorder,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _handleOtpInput(value, index);
                            } else {
                              _handleBackspace(value, index);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 2,
                  ),
                ),

                // Resend OTP Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OTP not recived? ',
                      style: TextStyle(
                        fontSize: TypographyResponsive.getFormFieldFontSize(
                          context,
                        ),
                        color: AppColors.textSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: _resendCountdown == 0 ? _handleResendOTP : null,
                      child: Text(
                        _resendCountdown > 0
                            ? 'RESEND OTP (${_resendCountdown}s)'
                            : 'RESEND OTP',
                        style: TextStyle(
                          fontSize: TypographyResponsive.getFormFieldFontSize(
                            context,
                          ),
                          color: _resendCountdown > 0
                              ? AppColors.textLight
                              : AppColors.accent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 5,
                  ),
                ),

                // Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isOTPComplete() && !_isLoading
                        ? _handleVerify
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isOTPComplete()
                          ? AppColors.buttonPrimary
                          : AppColors.textLight,
                      foregroundColor: AppColors.buttonText,
                      padding: EdgeInsets.symmetric(
                        vertical: SpacingResponsive.getVerticalSpacing(
                          context,
                          factor: 2,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            'VERIFY & PROCEED',
                            style: TextStyle(
                              fontSize:
                                  TypographyResponsive.getResponsiveFontSize(
                                    context,
                                    16,
                                  ),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                  ),
                ),

                SizedBox(
                  height: SpacingResponsive.getVerticalSpacing(
                    context,
                    factor: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
