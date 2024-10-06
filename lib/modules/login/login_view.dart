import 'package:flutter/material.dart';
import 'package:lingopanda_xh/modules/home/home_view.dart';
import 'package:lingopanda_xh/modules/signup/signup_view.dart';
import 'package:lingopanda_xh/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:lingopanda_xh/constants/colors_constants.dart';
import 'package:lingopanda_xh/constants/string_constants.dart';
import 'package:lingopanda_xh/constants/text_styles_constants.dart';
import 'package:lingopanda_xh/widgets/my_button.dart';
import 'package:lingopanda_xh/widgets/my_text_fiels.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(email);
  }

  bool _isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthServiceProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                StringConstants.comments,
                style: PoppinsTextStyle.bold(
                  fontSize: 20,
                  color: AppColors.primaryBlue,
                ),
              ),
              const Spacer(),
              MyTextField(
                hintText: StringConstants.email,
                controller: _emailController,
              ),
              MyTextField(
                hintText: StringConstants.password,
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Spacer(),
              if (authProvider.errorMessage != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      authProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    isLoading: authProvider.isLoading,
                    text: StringConstants.login,
                    onPressed: () async {
                      authProvider.clearError();

                      String email = _emailController.text.trim();
                      String password = _passwordController.text.trim();

                      if (!_isValidEmail(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please enter a valid email address.'),
                          ),
                        );
                        return;
                      }

                      if (!_isValidPassword(password)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Password must be at least 6 characters long.'),
                          ),
                        );
                        return;
                      }

                      await authProvider.login(email, password);

                      if (authProvider.errorMessage == null) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Login successful!')),
                        );
                        Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ));
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringConstants.newHere,
                    style: PoppinsTextStyle.regular(fontSize: 16),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      authProvider.clearError();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupView(),
                          ));
                    },
                    child: Text(
                      StringConstants.signup,
                      style: PoppinsTextStyle.bold(
                          fontSize: 16, color: AppColors.primaryBlue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
