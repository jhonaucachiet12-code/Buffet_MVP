import 'package:material_ui/material_ui.dart';

import '../../core/theme/app_theme.dart';
import 'home_screen.dart'; // Pantalla del alumno
import 'admin_screen.dart'; // Pantalla del admin

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  bool isStudent = true; // Toggle para demo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.fastfood, size: 50, color: AppTheme.darkGreen),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido al sitio web del buffet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Acá podrás comprar productos antes del recreo para retirarlos luego.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              // Inputs
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              if (isStudent) ...[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre y apellido',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _courseController,
                  decoration: const InputDecoration(
                    labelText: 'Curso',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
              const SizedBox(height: 30),

              // Botón de Login
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isStudent) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => AdminScreen()),
                      );
                    }
                  },
                  child: Text(
                    isStudent
                        ? 'Registrarse / Ingresar'
                        : 'Ingresar como Admin',
                  ),
                ),
              ),

              // Botón de cambio de rol para testing
              TextButton(
                onPressed: () => setState(() => isStudent = !isStudent),
                child: Text(
                  isStudent
                      ? 'Ingresar como Administrador'
                      : 'Ingresar como Alumno',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
