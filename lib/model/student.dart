// student.dart

class Student {
  final int id;
  final String nombre;
  final String carrera;
  final int ciclo;
  final String cursoFavorito;

  Student({
    required this.id,
    required this.nombre,
    required this.carrera,
    required this.ciclo,
    required this.cursoFavorito,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      nombre: json['nombre'],
      carrera: json['carrera'],
      ciclo: json['ciclo'],
      cursoFavorito: json['cursoFavorito'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'carrera': carrera,
      'ciclo': ciclo,
      'cursoFavorito': cursoFavorito,
    };
  }
}
