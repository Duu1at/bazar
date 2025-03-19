import 'package:auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhobePage extends StatefulWidget {
  const PhobePage({super.key});

  @override
  State<PhobePage> createState() => _PhobePageState();
}

class _PhobePageState extends State<PhobePage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  void _login() async {
    try {
      await context.read<AuthService>().loginWithPhone(
            _phoneController.text,
          );
    } on LoginWithPhoneException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: ${e.message}")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: $e")));
    }
  }

  void _otp() async {
    try {
      await context.read<AuthService>().verifyOTP(_otpController.text);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: ${e.message}")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: ${e}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Вход")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
            ),
            ElevatedButton(onPressed: _login, child: Text("Send")),
            SizedBox(height: 60),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: "OTP"),
            ),
            ElevatedButton(onPressed: _otp, child: Text("Send")),
          ],
        ),
      ),
    );
  }
}
