import 'package:app/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCheckView extends StatefulWidget {
  const AuthCheckView({super.key});

  @override
  State<StatefulWidget> createState() => _AuthCheckViewState();
}

class _AuthCheckViewState extends State<AuthCheckView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwoirdController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwoirdController.dispose();
    super.dispose();
  }

  void _checkUserAndNavigate() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    context.read<AuthBloc>().add(CheckUserExistsRequested(email));
  }

  void _signIn() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    final password = _passwoirdController.text.trim();
    context.read<AuthBloc>().add(AuthSignInRequested(email: email, password: password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Авторизация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Добро пожаловать!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text('Введите ваш email, чтобы продолжить', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Введите корректный email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (!state.userExists) {
                    return const SizedBox.shrink();
                  }
                  return TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.password),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите password';
                      }

                      return null;
                    },
                  );
                },
              ),

              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state.status == AuthStatus.loading;
                    return ElevatedButton(
                      onPressed: state.userExists ? _signIn : _checkUserAndNavigate,
                      child: isLoading ? const CircularProgressIndicator() : const Text('Продолжить'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
