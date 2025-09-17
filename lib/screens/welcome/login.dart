import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

class LoginSection extends StatefulWidget {
  final Function(String, bool) onPhoneNumberChanged;

  const LoginSection({super.key, required this.onPhoneNumberChanged});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Enter phone number",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Please confirm country code and enter phone number to login or register",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
        const SizedBox(height: 40),

        // Phone input field
        IntlPhoneField(
          controller: _phoneController,
          initialCountryCode: 'BD',
          languageCode: "en",
          flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 12),
          dropdownIconPosition: IconPosition.trailing,
          style: Theme.of(context).textTheme.bodyLarge,
          onChanged: (phone) {
            bool isValid = phone.number.isNotEmpty && phone.number.length >= 10;
            widget.onPhoneNumberChanged(phone.completeNumber, isValid);
          },
          decoration: InputDecoration(
            labelText: 'Phone Number',
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),

        const SizedBox(height: 20),
        Text(
          "We'll send you a verification code via SMS",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
