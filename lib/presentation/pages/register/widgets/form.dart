import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/widgets/main_button.dart';
import 'package:wallet_app/core/widgets/main_textfield.dart';
import 'package:wallet_app/l10n/languages.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_bloc.dart';
import 'package:wallet_app/presentation/cubit/auth/auth_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().register(
          email: _email.text, password: _password.text, name: _name.text);
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: state is AuthLoading,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                MainTextFormField(
                  labelText: Languages.of(context).email,
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                MainTextFormField(
                  labelText: Languages.of(context).password,
                  controller: _password,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                MainTextFormField(
                  labelText: Languages.of(context).name,
                  controller: _name,
                  validator: (_) => null,
                ),
                const SizedBox(height: 16),
                MainButton(
                  onTap: state is AuthLoading ? null : _onSubmit,
                  title: state is AuthLoading
                      ? Languages.of(context).loading
                      : Languages.of(context).register,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
