import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainLogInScreen extends StatefulWidget {
  const MainLogInScreen({super.key});

  @override
  State<MainLogInScreen> createState() => _MainLogInScreenState();
}

class _MainLogInScreenState extends State<MainLogInScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: const Color.fromARGB(255, 157, 116, 173),
        title: const Center(
            child: (Text(
          'Login Screen',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ))),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 20),
          const Text(
            "Bienvenid@",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Usuario/Email",
                labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                fillColor: Color.fromARGB(255, 224, 205, 226),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25))),
          ),
          const SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.visibility_off),
                labelText: "Contraseña",
                labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                fillColor: Color.fromARGB(255, 224, 205, 226),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25))),
          ),
          //Forgot password button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(fontSize: 12, color: Colors.red),
                )),
          ),
          //check box
          Row(
            children: [
              Checkbox(
                  activeColor: Color.fromARGB(255, 0, 0, 0),
                  value: isSelected,
                  onChanged: (newValue) {
                    setState(() {
                      isSelected = newValue!;
                    });
                  }),
              Text("Recuerdame",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700]!,
                      fontWeight: FontWeight.bold))
            ],
            //Iniciar sesión botón
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(300, 50),
                  backgroundColor: Color.fromARGB(255, 34, 34, 34),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'perfil');
                },
                child: const Text("Iniciar Sesión",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20))),
          ),
          //iniciar sesión con Facebook
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                minimumSize: const Size(300, 50),
                backgroundColor: const Color.fromARGB(255, 252, 252, 252),
              ),
              onPressed: () {},
              icon: const Icon(
                // <-- Icon
                Icons.facebook_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 24.0,
              ),
              label: const Text('Iniciar Sesión con Facebook',
                  style:
                      TextStyle(color: Colors.black, fontSize: 20)), // <-- Text
            ),
          ),
          //Hipervinculo para ir a Singup.dart
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 15,
              ),
              children: [
                const TextSpan(text: "¿Aún no tienes cuenta? "),
                TextSpan(
                    style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                    //make link blue and underline
                    text: "Crea una cuenta",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        //on tap code here, you can navigate to other page or URL
                        Navigator.pushNamed(context, 'Singup');
                      }),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
