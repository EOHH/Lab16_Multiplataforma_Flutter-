import 'package:flutter/material.dart';
import 'package:lab15_flutter/data/api_service.dart';
import 'package:lab15_flutter/model/student.dart';

class UpdateStudentPage extends StatefulWidget {
  final ApiService apiService;
  final Student student;

  UpdateStudentPage({required this.apiService, required this.student});

  @override
  _UpdateStudentPageState createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController carreraController = TextEditingController();
  TextEditingController cursoFavoritoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales del estudiante
    nombreController.text = widget.student.nombre;
    carreraController.text = widget.student.carrera;
    cursoFavoritoController.text = widget.student.cursoFavorito ?? ''; // Manejar caso nulo
  }

  Future<void> _updateStudent() async {
    // Crear un nuevo objeto Student con los datos actualizados
    Student updatedStudent = Student(
      id: widget.student.id,
      nombre: nombreController.text,
      carrera: carreraController.text,
      ciclo: widget.student.ciclo, // Mantener el ciclo actual o modificar según tu lógica
      cursoFavorito: cursoFavoritoController.text, // Actualizar curso favorito con el valor del campo de texto
    );

    try {
      // Llamar al servicio de API para actualizar el estudiante
      await widget.apiService.updateStudent(updatedStudent);
      // Navegar de regreso a la página anterior con resultado exitoso
      Navigator.pop(context, true);
    } catch (e) {
      // Manejar cualquier error de actualización aquí
      print('Error updating student: $e');
      // Mostrar mensaje de error si es necesario
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating student'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
        backgroundColor: const Color.fromARGB(255, 243, 124, 33), // Cambiar el color de fondo del app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: carreraController,
              decoration: InputDecoration(
                labelText: 'Carrera',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: cursoFavoritoController,
              decoration: InputDecoration(
                labelText: 'Curso Favorito',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateStudent,
              child: Text('Actualizar Estudiante'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 243, 124, 33)), // Cambiar el color de fondo del botón
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Cambiar el color del texto del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}
