// import 'package:auth_service/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   void _login() async {
//     try {
//       await context.read<AuthService>().loginWithEmail(
//             _emailController.text,
//             _passwordController.text,
//           );
//     } on LogInWithEmailAndPasswordFailure catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: ${e.message}")));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: $e")));
//     }
//   }

//   void _register() async {
//     try {
//       await context.read<AuthService>().signUpWithEmail(
//             _emailController.text,
//             _passwordController.text,
//           );
//     } on SignUpWithEmailAndPasswordFailure catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: ${e.message}")));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ошибка: $e")));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title:const Text("Вход")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration:const  InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration:const  InputDecoration(labelText: "Пароль"),
//               obscureText: true,
//             ),
//            const SizedBox(height: 16),
//             ElevatedButton(onPressed: _login, child:const Text("Войти")),
//             TextButton(onPressed: _register, child:const Text("Создать аккаунт")),
//           ],
//         ),
//       ),
//     );
//   }
// }
