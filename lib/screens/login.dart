import 'package:flutter/material.dart';
import 'package:parcial3/screens/home.dart';
import 'package:parcial3/services/data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorText;

  void _login() {
    final username = usernameController.text;
    final password = passwordController.text;

    // Realiza la validación de inicio de sesión con datos locales
    if (username == loginData[0] && password == loginData[1]) {
      // Si las credenciales son válidas, navega a la pantalla de inicio
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      // Si las credenciales no son válidas, muestra un mensaje de error
      setState(() {
        errorText = "Credenciales incorrectas";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            if (errorText != null)
              Text(
                errorText!,
                style: TextStyle(color: Colors.red),
              ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}