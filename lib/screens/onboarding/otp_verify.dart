// lib/screens/onboarding/otp_verify.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPSection extends StatefulWidget {
  final String phoneNumber;
  final Function(String) onCodeChanged;

  const OTPSection({
    super.key,
    required this.phoneNumber,
    required this.onCodeChanged,
  });

  @override
  State<OTPSection> createState() => _OTPSectionState();
}

class _OTPSectionState extends State<OTPSection> with CodeAutoFill {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _countDown = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    listenForCode(); // Start listening for OTP via SMS Retriever API

    // Auto-focus the OTP field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void codeUpdated() {
    // Called when SMS is received
    if (code != null) {
      _otpController.text = code!;
      _onOTPCompleted(code!);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    cancel(); // Stop listening for SMS
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _countDown = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _countDown--;
        });
      }
    });
  }

  void _resendOTP() {
    if (_canResend) {
      _otpController.clear();
      listenForCode(); // Start listening again

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP resent successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      _startTimer();
    }
  }

  void _onOTPCompleted(String otp) {
    widget.onCodeChanged(otp);
    // // Navigate to Home Page
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (_) => const MyHomePage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor, width: 1.5),
        color: Theme.of(context).colorScheme.surface,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).hintColor, width: 2),
        color: Theme.of(context).colorScheme.surface,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
        color: Theme.of(context).primaryColor.withOpacity(0.1),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HugeIcon(
          icon: HugeIcons.strokeRoundedMessage02,
          color: Theme.of(context).colorScheme.primary,
          size: 80,
        ),
        const SizedBox(height: 24),
        Text(
          "Enter verification code",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            children: [
              const TextSpan(text: "We've sent a 6-digit code to\n"),
              TextSpan(
                text: widget.phoneNumber,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).textTheme.bodySmall?.color?.withAlpha(150),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Pinput(
          controller: _otpController,
          focusNode: _focusNode,
          length: 6,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          onCompleted: _onOTPCompleted,
          onChanged: (value) => setState(() {}),
          cursor: Container(
            height: 24,
            width: 2,
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            GestureDetector(
              onTap: _canResend ? _resendOTP : null,
              child: Text(
                _canResend ? "Resend" : "Resend in ${_countDown}s",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: _canResend
                      ? Theme.of(context).textTheme.bodySmall?.color
                      : Theme.of(context).disabledColor,
                  fontWeight: FontWeight.w600,
                  decoration: _canResend ? TextDecoration.underline : null,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(vertical: 15),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            onPressed: _otpController.text.length == 6
                ? () => _onOTPCompleted(_otpController.text)
                : null,
            child: Text(
              "Verify & Continue",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
