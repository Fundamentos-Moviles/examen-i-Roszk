import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  String nombreAlumno = 'Rodrigo Bautista Ruiz';

  void login() {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Datos incompletos';
      });
    } else if (email != 'test@correo.mx' && password != 'FDM2') {
      setState(() {
        errorMessage = 'Correo y contraseña incorrectos';
      });
    } else if (email != 'test@correo.mx') {
      setState(() {
        errorMessage = 'Correo incorrecto';
      });
    } else if (password != 'FDM2') {
      setState(() {
        errorMessage = 'Contraseña incorrecta';
      });
    } else {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(nombreAlumno: nombreAlumno)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            color: Color(0xFF015236),
          ),

          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
            painter: PatternPainter(),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Bienvenido a tu primer EXAMEN',
                      style: TextStyle(
                        color: Colors.lightGreenAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ingresa tu correo electrónico:',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Correo',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ingresa tu contraseña:',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Mi primer examen, ¿estará sencillo?',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double squareSize = size.width / 4;
    double radius = squareSize / 3.0;

    List<List<Color>> colorPattern = [
      [Color(0xFF01644a), Color(0xFF015236), Color(0xFF01412e), Color(0xFF02b274)],
      [Color(0xFF02b274), Color(0xFF01412e), Color(0xFF01644a), Color(0xFF015236)],
      [Color(0xFF01412e), Color(0xFF02b274), Color(0xFF015236), Color(0xFF01644a)],
      [Color(0xFF015236), Color(0xFF01644a), Color(0xFF02b274), Color(0xFF01412e)],
      [Color(0xFF01644a), Color(0xFF015236), Color(0xFF01412e), Color(0xFF02b274)],
      [Color(0xFF02b274), Color(0xFF01412e), Color(0xFF01644a), Color(0xFF015236)],
    ];

    for (int row = 0; row < 6; row++) {
      for (int col = 0; col < 4; col++) {
        Paint paint = Paint()..color = colorPattern[row][col];
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(col * squareSize, row * squareSize, squareSize, squareSize),
            Radius.circular(radius),
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
