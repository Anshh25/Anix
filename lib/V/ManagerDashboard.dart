import 'package:anix/C/AuthController.dart'; // Import the controller
import 'package:anix/V/SignInScreen.dart'; // Import the SignInScreen
import 'package:flutter/material.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  final AuthController _authController = AuthController();

  // --- NEW: Sign Out Method ---
  Future<void> _signOut() async {
    await _authController.signOut();
    if (mounted) {
      // Navigate to the SignInScreen and remove all previous screens
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager Dashboard"),
        backgroundColor: const Color(0xFF4834D4),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: _signOut,
          ),
        ],
      ),
      body: const Center(
        child: Text("Manager Dashboard"),
      ),
    );
  }
}