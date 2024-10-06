import 'package:flutter/material.dart';
import 'package:lingopanda_xh/constants/colors_constants.dart';
import 'package:lingopanda_xh/constants/string_constants.dart';
import 'package:lingopanda_xh/constants/text_styles_constants.dart';
import 'package:lingopanda_xh/modules/home/home_view.dart';
import 'package:lingopanda_xh/modules/login/login_view.dart';
import 'package:lingopanda_xh/providers/auth_provider.dart';
import 'package:lingopanda_xh/widgets/my_button.dart';
import 'package:lingopanda_xh/widgets/my_text_fiels.dart';
import 'package:provider/provider.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _validateInputs(BuildContext context) {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return false;
    } else if (!_emailController.text.contains('@') ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email')),
      );
      return false;
    } else if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 6 characters')),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthServiceProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  StringConstants.comments,
                  style: PoppinsTextStyle.bold(
                      fontSize: 20, color: AppColors.primaryBlue),
                ),
                const Spacer(),
                MyTextField(
                  hintText: StringConstants.name,
                  controller: _nameController,
                ),
                MyTextField(
                  hintText: StringConstants.email,
                  controller: _emailController,
                ),
                MyTextField(
                  hintText: StringConstants.password,
                  controller: _passwordController,
                  obscureText: true,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                const Spacer(),
                if (authProvider.errorMessage != null) ...[
                  Center(
                    child: Text(
                      authProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        isLoading: authProvider.isLoading,
                        text: StringConstants.signup,
                        onPressed: () async {
                          if (_validateInputs(context)) {
                            authProvider.clearError();

                            await authProvider.signUp(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _nameController.text.trim(),
                            );

                            if (authProvider.errorMessage == null) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Signup successful!')),
                              );
                              Navigator.pushReplacement(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeView(),
                                  ));
                            }
                          }
                        }),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.alreadyHaveAccount,
                      style: PoppinsTextStyle.regular(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ));
                      },
                      child: Text(
                        StringConstants.login,
                        style: PoppinsTextStyle.bold(
                            fontSize: 16, color: AppColors.primaryBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
