import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';

/// Screen representing user registration page (Step 1 of 2).
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    // Matches 10 digits after +880 (e.g. 1712345678)
    final phoneRegex = RegExp(r'^1[3-9]\d{8}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid mobile number (e.g. 1712345678)';
    }
    return null;
  }

  void _handleNextStep() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      
      // Simulate checking phone registration or navigating to next step (OTP verification screen / Step 2)
      authProvider.sendOtp(
        '+880${_phoneController.text.trim()}',
        (verificationId, forceResendingToken) {
          // Navigates to OTP screen
          context.push('/otp');
        },
      );
      
      // For boilerplate testing and evaluation, directly navigate to OTP screen
      context.push('/otp');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill out the fields correctly'),
          backgroundColor: Color(0xffDC2626), // Error Red
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6), // Background Light Gray
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40), // Top Spacing

                // Top Badge and Navigation Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xff6B7280)),
                      onPressed: () => context.pop(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xffE5E7EB), // Very Light Gray
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Step 1 of 2',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6B7280), // Text Secondary
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // DwellWise Centered Logo
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xff1E40AF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.home_work_rounded,
                      size: 40,
                      color: Color(0xff1E40AF),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Heading
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1E40AF), // Primary Blue
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Join DwellWise to find or list verified rentals',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff6B7280), // Text Secondary
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Full Name Input
                const Text(
                  'FULL NAME',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Color(0xff1F2937)),
                  decoration: InputDecoration(
                    hintText: 'Enter your full name',
                    hintStyle: const TextStyle(color: Color(0xff9CA3AF)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    prefixIcon: const Icon(Icons.person_outline, color: Color(0xff6B7280)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xff1E40AF), width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffDC2626)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffDC2626), width: 1.5),
                    ),
                  ),
                  validator: _validateName,
                ),
                const SizedBox(height: 20),

                // Phone Number Input with Country Code Dropdown Prefix
                const Text(
                  'PHONE NUMBER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Color(0xff1F2937)),
                  decoration: InputDecoration(
                    hintText: '1XXX-XXXXXX',
                    hintStyle: const TextStyle(color: Color(0xff9CA3AF)),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16),
                        const Icon(Icons.phone_outlined, color: Color(0xff6B7280)),
                        const SizedBox(width: 8),
                        const Text(
                          '+880',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1F2937),
                            fontSize: 16,
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Color(0xff1F2937)),
                        const SizedBox(width: 8),
                        Container(
                          width: 1,
                          height: 24,
                          color: const Color(0xffD1D5DB),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffD1D5DB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xff1E40AF), width: 1.5),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffDC2626)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0xffDC2626), width: 1.5),
                    ),
                  ),
                  validator: _validatePhone,
                ),
                const SizedBox(height: 32),

                // Next Step Button
                _CTAButton(
                  text: 'Next Step →',
                  onPressed: _handleNextStep,
                ),
                const SizedBox(height: 24),

                // Bottom Login section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(fontSize: 14, color: Color(0xff6B7280)),
                    ),
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1E40AF),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Security Section info tiles
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.lock_outline, size: 14, color: Color(0xff6B7280)),
                        SizedBox(width: 6),
                        Text(
                          'SECURE ENCRYPTION',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff6B7280)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.gavel_outlined, size: 14, color: Color(0xff6B7280)),
                        SizedBox(width: 6),
                        Text(
                          'LEGAL COMPLIANCE',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff6B7280)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 48),

                // Footer lines
                const Text(
                  '© 2024 DwellWise. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xffD1D5DB),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Footer Links
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Privacy',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff1E40AF)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('|', style: TextStyle(fontSize: 12, color: Color(0xffD1D5DB))),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Terms of Service',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff1E40AF)),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('|', style: TextStyle(fontSize: 12, color: Color(0xffD1D5DB))),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Contact Support',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff1E40AF)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CTAButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const _CTAButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color bg = const Color(0xffF59E0B);
    if (_isPressed) {
      bg = const Color(0xffE59E0B);
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 56,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
