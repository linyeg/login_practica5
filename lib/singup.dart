import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  List<String> itemsDropDown = [
    "Australia",
    "Canada",
    "Brazil",
    "United States",
    "Japan",
    "Mexico",
  ];
  String? valueDropDown = "Australia";

  String email = "";
  String userName = "";
  String password = "";
  DateTime? birthDate;
  String date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Color.fromARGB(255, 157, 116, 173),
        title: const Center(
            child: (Text(
          'Sing up Screen',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ))),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            )),
      ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(children: [
            Column(
              children: [
                const Text(
                  "Registro",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿Ya tienes cuenta?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: const Text("Iniciar Sesión"))
                  ],
                ),
                //USERNAME LABEL TEXT
                CtmTextFormField(
                  labelTxt: 'Username',
                  onChanged: (value) {
                    setState(() {
                      userName = value;
                    });
                  },
                  //Email Label Text
                ),
                CtmTextFormField(
                  labelTxt: 'Email',
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                //Password label text
                CustomPassword(onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                }),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        label: const Text(
                          "Fecha de nacimiento",
                        ),
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        //Mostrar el valor de la fecha
                        onPressed: () async {
                          birthDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 36500)),
                              lastDate: DateTime.now());
                          setState(() {
                            date =
                                "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}";
                          });
                        },
                      ),
                    ),
                    (birthDate == null) ? const Text("") : Text(" $date")
                  ],
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Country"),
                ),
                const SizedBox(height: 10),
                DropdownButton(
                    value: valueDropDown,
                    items: itemsDropDown
                        .map((item) =>
                            DropdownMenuItem(value: item, child: Text(item)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        valueDropDown = value;
                      });
                    }),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(300, 50),
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    onPressed: () {
                      debugPrint(userName);
                      debugPrint(email);
                      debugPrint(password);
                      debugPrint("$birthDate");
                    },
                    child: const Text("Registrate",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ))),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class CtmTextFormField extends StatelessWidget {
  final TextInputFormatter? format;
  final String labelTxt;
  final Function(String)? onChanged;

  const CtmTextFormField({
    this.onChanged,
    this.format,
    super.key,
    required this.labelTxt,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [
        format ?? FilteringTextInputFormatter.singleLineFormatter
      ],
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: labelTxt,
          fillColor: Color.fromARGB(255, 224, 205, 226),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
  }
}

class CustomPassword extends StatefulWidget {
  final Function(String)? onChanged;
  const CustomPassword({
    super.key,
    this.onChanged,
  });

  @override
  State<CustomPassword> createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
  @override
  Widget build(BuildContext context) {
    bool show = true;
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: show,
      decoration: InputDecoration(
          suffixIcon: (show == true)
              ? IconButton(
                  icon: const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      show = false;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      show = true;
                    });
                  },
                ),
          labelText: "Contraseña",
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 134, 134, 134),
              fontSize: 15,
              fontWeight: FontWeight.bold),
          fillColor: Color.fromARGB(255, 224, 205, 226),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25))),
    );
  }
}
