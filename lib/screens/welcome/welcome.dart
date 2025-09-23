// import 'dart:convert';

import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:qalb/db/helper.dart';
import 'package:qalb/main.dart';
import 'package:qalb/screens/welcome/login.dart';
import 'package:qalb/screens/welcome/otp_verify.dart';
import 'package:qalb/storage/secure_storage.dart';
import 'package:qalb/theme_manager.dart';
import 'package:uuid/uuid.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentStep = 0; // 0 = Welcome, 1 = Login, 2 = OTP
  String? _phoneNumber;
  String? _code;
  bool _isPhoneValid = false;
  bool _isLoading = false;

  void _prevStep() {
    setState(() {
      if (_currentStep > 0) _currentStep--;
    });
  }

  void _setPhoneNumber(String phoneNumber, bool isValid) {
    setState(() {
      _phoneNumber = phoneNumber;
      _isPhoneValid = isValid;
    });
  }

  void _setCode(String code) {
    setState(() => _code = code);
    if (code.length == 6) _nextStep();
  }

  // create uuid4 device id
  String _createDeviceId() => const Uuid().v4();

  Future<String> getDeviceId() async {
    final storage = SecureStorageHelper();
    var did = await storage.getDeviceId();

    if (did != null) return did;

    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        final androidInfo = await deviceInfo.androidInfo;
        did = androidInfo.id; // or androidInfo.androidId
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosInfo = await deviceInfo.iosInfo;
        did = iosInfo.identifierForVendor ?? _createDeviceId();
      } else {
        did = _createDeviceId();
      }
    } catch (e) {
      did = _createDeviceId();
    }

    await storage.saveDeviceId(did);
    return did;
  }

  Future<void> _nextStep() async {
    if (_currentStep == 1) {
      if (!_isPhoneValid) return;
      setState(() => _isLoading = true);

      try {
        final deviceId = await getDeviceId();
        final response = await http.post(
          Uri.parse('http://192.168.0.100:8000/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'phone': _phoneNumber, 'deviceId': deviceId}),
        );

        if (response.statusCode != 200) {
          setState(() => _isLoading = false);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Failed to send verification code. Please try again.",
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          _isLoading = false;
          _currentStep++;
        });
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (_currentStep == 2) {
      setState(() => _isLoading = true);

      try {
        final deviceId = await getDeviceId();
        final response = await http.post(
          Uri.parse('http://192.168.0.100:8000/verify-otp'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'phone': _phoneNumber,
            'deviceId': deviceId,
            'code': _code,
          }),
        );

        if (response.statusCode != 200) {
          setState(() => _isLoading = false);

          final data = jsonDecode(response.body);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['detail']),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final data = jsonDecode(response.body);
        print(data);
        final session = data['session'];
        final token = session['token'];
        final storage = SecureStorageHelper();
        await storage.saveAuthToken(token);

        final db = DBHelper();
        await db.addUserInfo(
          data["user"]['firstName'] ?? "",
          data["user"]['lastName'] ?? "",
          data["user"]['phone'],
          data["user"]['username'],
          data["user"]['statusMessage'],
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyHomePage()),
        );
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      setState(() {
        if (_currentStep < 2) _currentStep++;
      });
    }
  }

  Widget _buildWelcomeContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/messaging.json',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        Text(
          "Welcome to DeenCircle",
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          "Connect with friends and family",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget centerContent;

    switch (_currentStep) {
      case 0:
        centerContent = _buildWelcomeContent();
        break;
      case 1:
        centerContent = LoginSection(onPhoneNumberChanged: _setPhoneNumber);
        break;
      case 2:
        centerContent = OTPSection(
          phoneNumber: _phoneNumber ?? "",
          onCodeChanged: _setCode,
        );
        break;
      default:
        centerContent = const SizedBox.shrink();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🔹 Top bar with theme toggle and back button
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    onPressed: _prevStep,
                  )
                else
                  const SizedBox(width: 48), // placeholder
                // const SizedBox(width: 48), // placeholder
                Consumer<ThemeManager>(
                  builder: (context, themeManager, child) {
                    return IconButton(
                      icon: Icon(
                        themeManager.isDarkMode
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () => themeManager.toggleTheme(),
                    );
                  },
                ),
              ],
            ),
          ),

          // 🔹 Middle content
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: centerContent,
              ),
            ),
          ),

          // 🔹 Bottom button
          Visibility(
            visible: _currentStep != 2,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: (_currentStep == 1 && !_isPhoneValid)
                          ? null
                          : (_isLoading ? null : _nextStep),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _currentStep == 0 ? "Get Started" : "Continue",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
