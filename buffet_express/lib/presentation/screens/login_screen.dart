// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F0), // Fondo beige
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // --- ENCABEZADO SUPERIOR ---
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E3D32),
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '12',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TÉCNICA N.° 12',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              'Buffet escolar',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3D32),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (isDesktop)
                      const Text(
                        'Buenos Aires, Argentina',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                  ],
                ),
              ),

              // --- CONTENIDO PRINCIPAL (Divide en PC / Apila en Móvil) ---
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 1100),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(flex: 5, child: _buildLeftPanel()),
                              const SizedBox(width: 24),
                              Expanded(flex: 6, child: _buildRightPanel()),
                            ],
                          )
                        : Column(
                            children: [
                              _buildLeftPanel(),
                              const SizedBox(height: 24),
                              _buildRightPanel(),
                            ],
                          ),
                  ),
                ),
              ),

              // --- PIE DE PÁGINA ---
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TÉCNICA N.° 12 / Buffet escolar',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    if (isDesktop)
                      const Text(
                        'Buenos Aires, Argentina · Retiro en el buffet escolar',
                        style: TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- PANEL IZQUIERDO (Verde Oscuro) ---
  Widget _buildLeftPanel() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3D32),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'TU PAUSA FAVORITA',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Bienvenido al sitio web del buffet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Acá podrás comprar productos antes del recreo para recibirlo luego durante este',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          const SizedBox(height: 32),
          Container(
            width: 60,
            height: 3,
            color: const Color(0xFFE07A5F),
          ), // Línea naranja
          const SizedBox(height: 32),
          const Text(
            'Elegí algo rico y armá tu pedido.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildStep('01', 'Elegí tus productos'),
          _buildStep('02', 'Elegí cómo pagar'),
          _buildStep('03', 'Retirá en el buffet escolar'),
        ],
      ),
    );
  }

  Widget _buildStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  // --- PANEL DERECHO (Blanco - Formulario) ---
  Widget _buildRightPanel() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Registro',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3D32),
            ),
          ),
          const SizedBox(height: 32),

          _buildTextField(
            'Email Address',
            'alex@ejemplo.com',
            _emailController,
          ),
          const SizedBox(height: 20),
          _buildTextField('Nombre y apellido', 'Alex García', _nameController),
          const SizedBox(height: 20),
          _buildTextField('Curso', '3.º 1.ª', _courseController),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                // Al registrarse, navega a la tienda usando GoRouter
                context.go('/tienda');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3D32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Register with us',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 32),
          // Separador "Or"
          Row(
            children: [
              const Expanded(child: Divider(color: Colors.black12)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Or',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                ),
              ),
              const Expanded(child: Divider(color: Colors.black12)),
            ],
          ),
          const SizedBox(height: 24),

          // Iconos Sociales (Simulados)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.g_mobiledata, Colors.red), // Google
              const SizedBox(width: 20),
              _buildSocialIcon(Icons.apple, Colors.black), // Apple
              const SizedBox(width: 20),
              _buildSocialIcon(
                Icons.facebook,
                const Color(0xFF1877F2),
              ), // Facebook
              const SizedBox(width: 20),
              _buildSocialIcon(
                Icons.chat,
                const Color(0xFF1DA1F2),
              ), // Twitter/X
            ],
          ),

          if (!MediaQuery.of(context).size.width.isFinite ||
              MediaQuery.of(context).size.width < 900) ...[
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Buenos Aires, Argentina',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E3D32),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF1E3D32),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return InkWell(
      onTap: () {},
      child: Icon(icon, color: color, size: 28),
    );
  }
}
