import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../providers/auth_service.dart';
import '../../ui/input_decoration.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isAdmin = false;
  bool _isLoading = false;
  bool _showSingleImage = false;
  Timer? _timer;
  int _formStep = 0; // 0 pour infos perso, 1 pour infos compte

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _showSingleImage = !_showSingleImage;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
      );

      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${_firstNameController.text.trim()}, votre compte a été créé avec succès!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${e.toString()}')),
        );
      }
    } finally {
      if (context.mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                'Media Blur - Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textprimary,
                ),
              ),
              const SizedBox(height: 30),
              // Container blanc avec l'animation d'images
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                ),
                height: 130,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: _showSingleImage
                      ? Image.asset(
                          'assets/how_to_protect.png',
                          key: const ValueKey('single'),
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Row(
                          key: const ValueKey('row'),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/protec_logo.jpg',
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Image.asset(
                                'assets/protec_privacy.png',
                                height: 120,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Onglets de navigation
             Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    ChoiceChip(
      label: const Text('Personal Infos'),
      selected: _formStep == 0,
      onSelected: (_) => setState(() => _formStep = 0),
      selectedColor: AppColors.secondary,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.white, // Fond blanc quand non sélectionné
      side: BorderSide(
        color: Colors.white, // Bordure blanche
        width: 1.0,
      ),
      labelStyle: TextStyle(
        color: _formStep == 0 ? Colors.white : AppColors.textprimary,
      ),
    ),
    const SizedBox(width: 12),
    ChoiceChip(
      label: const Text('Account Infos'),
      selected: _formStep == 1,
      onSelected: (_) => setState(() => _formStep = 1),
      selectedColor: AppColors.secondary,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.white, // Fond blanc quand non sélectionné
      side: BorderSide(
        color: Colors.white, // Bordure blanche
        width: 0,
      ),
      labelStyle: TextStyle(
        color: _formStep == 1 ? Colors.white : AppColors.textprimary,
      ),
    ),
  ],
),
              const SizedBox(height: 20),
              
              // Formulaire avec onglets
              Expanded(
                child: Form(
                  key: _formKey,
                  child: IndexedStack(
                    index: _formStep,
                    children: [
                      // Onglet 1: Informations personnelles
                      Column(
                        children: [
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecorations.standard('First Name', Icons.person),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecorations.standard('Last Name', Icons.person),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () => setState(() => _formStep = 1),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.1,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Onglet 2: Informations du compte
                      Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecorations.standard('Email', Icons.email),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecorations.standard('Password', Icons.lock),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Minimum 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.secondary.withOpacity(0.6),
                              ),
                            ),
                            child: SwitchListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Admin Account',
                                style: TextStyle(
                                  color: AppColors.textprimary,
                                  fontSize: 14,
                                ),
                              ),
                              subtitle: Text(
                                'Access to admin dashboard',
                                style: TextStyle(
                                  color: AppColors.textprimary.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                              value: _isAdmin,
                              onChanged: (value) => setState(() => _isAdmin = value),
                              activeColor: AppColors.primary,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      side: BorderSide(color: AppColors.primary),
                                    ),
                                    onPressed: () => setState(() => _formStep = 0),
                                    child: Text(
                                      'Back',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.1,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    onPressed: _isLoading ? null : () => _register(context),
                                    child: _isLoading
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text(
                                            'Create Account',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.1,
                                              color: AppColors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}