import 'package:flutter/material.dart';
import 'package:lab15_flutter/model/student.dart';
import 'package:lab15_flutter/data/api_service.dart';

class AddStudentPage extends StatefulWidget {
  final ApiService apiService;

  AddStudentPage({required this.apiService});

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _carreraController = TextEditingController();
  final _cicloController = TextEditingController();
  final _cursoFavoritoController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text;
      final carrera = _carreraController.text;
      final ciclo = int.parse(_cicloController.text);
      final cursoFavorito = _cursoFavoritoController.text;

      final newStudent = Student(
        id: 0,
        nombre: nombre,
        carrera: carrera,
        ciclo: ciclo,
        cursoFavorito: cursoFavorito,
      );

      try {
        await widget.apiService.createStudent(newStudent);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating student')));
      }
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _carreraController.dispose();
    _cicloController.dispose();
    _cursoFavoritoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
        backgroundColor: const Color.fromARGB(255, 243, 124, 33), // Cambiar el color de fondo del app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _carreraController,
                decoration: InputDecoration(
                  labelText: 'Carrera',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una carrera';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cicloController,
                decoration: InputDecoration(
                  labelText: 'Ciclo',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un ciclo';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un número válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _cursoFavoritoController,
                decoration: InputDecoration(
                  labelText: 'Curso Favorito',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un curso favorito';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Guardar'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 243, 124, 33)), // Cambiar el color de fondo del botón
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambiar el color del texto del botón
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
