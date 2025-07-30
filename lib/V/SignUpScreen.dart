import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKeySignUp = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
      
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "./images/ic_launcher.png",
                    fit: BoxFit.contain,
                    height: MediaQuery.sizeOf(context).height * 0.095,
                  ),
                ),
      
                const SizedBox(height: 60),
      
                // Sign in title
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      
                const SizedBox(height: 60),
      
                // Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKeySignUp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

      
                        const SizedBox(height: 20),
      
                        // Email Field
                        const Text(
                          'Email address',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 78,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
      
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 78,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 15),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
      
                        const SizedBox(height: 20),
      
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
      
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black45,
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF2C3E50),
                              elevation: 8,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13,),
                        Center(child: Text("New business owner?")),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
      
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black45,
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF2C3E50),
                              elevation: 8,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
