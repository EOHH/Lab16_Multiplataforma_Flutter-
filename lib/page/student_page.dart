import 'package:flutter/material.dart';
import 'package:lab15_flutter/model/student.dart';
import 'package:lab15_flutter/data/api_service.dart';
import 'package:lab15_flutter/page/add_student_page.dart';
import 'package:lab15_flutter/page/update_student_page.dart';

class StudentPage extends StatefulWidget {
  final ApiService apiService;

  StudentPage({required this.apiService});

  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<Student> students = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true;
    });
    try {
      students = await widget.apiService.getStudents();
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _navigateToAddStudentPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddStudentPage(apiService: widget.apiService),
      ),
    );

    if (result == true) {
      fetchStudents();
    }
  }

  Future<void> _navigateToUpdateStudentPage(Student student) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateStudentPage(apiService: widget.apiService, student: student),
      ),
    );

    if (result == true) {
      fetchStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students'),
        backgroundColor: const Color.fromARGB(255, 243, 124, 33), // Cambiar color de fondo de la barra de navegación
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          title: Text(
                            student.nombre,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Carrera: ${student.carrera}'),
                              Text('Ciclo: ${student.ciclo}'),
                              Text('Curso Favorito: ${student.cursoFavorito ?? 'No asignado'}'),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.green),
                                onPressed: () => _navigateToUpdateStudentPage(student),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  // Implementar la lógica para eliminar estudiante
                                  await widget.apiService.deleteStudent(student.id);
                                  fetchStudents();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _navigateToAddStudentPage,
                    child: Text('Add Student'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 243, 124, 33), // Cambiar color de texto del botón
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
