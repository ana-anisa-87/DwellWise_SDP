import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';

/// Screen representing phone verification OTP login page.
class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  
  bool _codeSent = false;
  String _verificationId = '';

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendOtpCode() async {
    final phone = _phoneController.text.trim();
    if (phone.isNotEmpty) {
      await context.read<AuthProvider>().sendOtp(
        phone,
        (verificationId, forceResendingToken) {
          setState(() {
            _verificationId = verificationId;
            _codeSent = true;
          });
        },
      );
    }
  }

  void _verifyOtpCode() {
    // Mock successful sign in on verify for testing stub
    context.go('/tenant-home');
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Phone Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sign In with Mobile OTP',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (!_codeSent) ...[
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'e.g. +88017XXXXXXXX',
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Send Verification Code',
                isLoading: isLoading,
                onPressed: _sendOtpCode,
              ),
            ] else ...[
              Text(
                'Code sent to ${_phoneController.text}',
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'SMS Code',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.pin),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Verify & Login',
                isLoading: isLoading,
                onPressed: _verifyOtpCode,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _codeSent = false;
                    _codeController.clear();
                  });
                },
                child: const Text('Change Phone Number'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
