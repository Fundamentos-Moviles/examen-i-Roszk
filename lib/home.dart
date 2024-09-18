import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String nombreAlumno;

  HomeScreen({required this.nombreAlumno});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> listaExamen = [
    'id # edad # dia de cumpleaños # mes de cumpleaños # Nombre # apellidos # descripción # num de estrellas en gris',
    '1 # 28 # 23 # Marzo # Alejandro # Ordaz # Cumpleaños del profesor # 5',
    '2 # 29 # 15 # Abril # Ana # Gómez # Cumpleaños de mi amiga # 4',
    '3 # 40 # 03 # Octubre # Luis # Pérez # Cumpleaños del colega # 3',
    '4 # 32 # 20 # Diciembre # Marta # Ruiz # Cumpleaños de la tía # 2',
    '5 # 27 # 15 # Julio # Carlos # Sánchez # Cumpleaños de un colega # 4',
    '6 # 26 # 09 # Enero # Rosa # Martínez # Cumpleaños de la hermana # 3',
    '7 # 33 # 11 # Febrero # Juan # López # Cumpleaños del primo # 5',
    '8 # 25 # 14 # Marzo # Clara # Fernández # Cumpleaños de la amiga # 4',
    '9 # 31 # 21 # Abril # Pablo # Moreno # Cumpleaños del vecino # 2',
    '10 # 45 # 07 # Mayo # Laura # Ruiz # Cumpleaños del jefe # 3',
    '11 # 30 # 18 # Junio # Jorge # González # Cumpleaños del compañero # 5',
    '12 # 29 # 24 # Julio # Isabel # Castro # Cumpleaños de la madre # 4',
    '13 # 35 # 15 # Agosto # Javier # Romero # Cumpleaños del amigo # 2',
    '14 # 28 # 30 # Septiembre # Patricia # Ramírez # Cumpleaños del compañero de trabajo # 3',
    '15 # 40 # 11 # Octubre # Roberto # Ruiz # Cumpleaños del colega # 5',
    '16 # 31 # 22 # Noviembre # Marta # Sánchez # Cumpleaños de la abuela # 4',
    '17 # 27 # 03 # Diciembre # Manuel # Ortega # Cumpleaños del tío # 3',
    '18 # 33 # 12 # Enero # Julia # García # Cumpleaños de la amiga del colegio # 2',
    '19 # 29 # 20 # Febrero # Sergio # López # Cumpleaños del amigo de la infancia # 4',
    '20 # 42 # 28 # Marzo # Laura # Martínez # Cumpleaños de la compañera # 5',
    '21 # 34 # 16 # Abril # Ricardo # Fernández # Cumpleaños del vecino # 2',
    '22 # 31 # 11 # Mayo # Natalia # Sánchez # Cumpleaños del amigo # 3',
    '23 # 29 # 25 # Junio # Alejandro # Mendoza # Cumpleaños del profesor # 5',
  ];

  List<Map<String, dynamic>> parseListaExamen() {
    final data = List<String>.from(listaExamen);
    data.removeAt(0);

    return data.map((entry) {
      final parts = entry.split(' # ');
      if (parts.length < 8) {
        throw Exception('Entrada con datos insuficientes: $entry');
      }
      return {
        'id': parts[0],
        'day': parts[2],
        'month': parts[3],
        'name': '${parts[4]} ${parts[5]}',
        'description': parts[6],
        'stars': int.tryParse(parts[7]) ?? 0,
      };
    }).toList();
  }

  List<Map<String, dynamic>> getOrderedBirthdays() {
    final list = parseListaExamen();
    list.sort((a, b) => (a['id'] as String).compareTo(b['id'] as String));
    return list;
  }

  final List<Map<String, dynamic>> birthdays = [];

  @override
  void initState() {
    super.initState();
    birthdays.addAll(getOrderedBirthdays());
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void deleteItem(String id) {
    final forbiddenIds = ['1', '10', '15', '20', '23'];

    if (forbiddenIds.contains(id)) {
      showSnackBar(context, 'No se puede eliminar el ID $id');
    } else {
      setState(() {
        birthdays.removeWhere((birthday) => birthday['id'] == id);
      });
      showSnackBar(context, 'Elemento con ID $id eliminado');
    }
  }

  Widget buildStars(int stars) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }

  IconData getIconForId(String id) {
    final specialIds = ['1', '5', '10', '15'];
    if (specialIds.contains(id)) {
      return Icons.star;
    }
    return Icons.star_border;
  }

  Color getColorForId(String id) {
    final specialIds = ['1', '5', '10', '15'];
    if (specialIds.contains(id)) {
      return Colors.yellow;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF410101),
      appBar: AppBar(
        backgroundColor: Color(0xFF640101),
        title: Text('Calendario de Cumpleaños'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Nombre del Alumno: ${widget.nombreAlumno}',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: birthdays.length,
                itemBuilder: (context, index) {
                  final birthday = birthdays[index];
                  final id = birthday['id'] as String;
                  final day = birthday['day'] as String;
                  final month = birthday['month'] as String;
                  final name = birthday['name'] as String;
                  final description = birthday['description'] as String;
                  final stars = birthday['stars'] as int;

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        '$day - $month',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name),
                          Text(description),
                          buildStars(stars),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(getIconForId(id), color: getColorForId(id)),
                            onPressed: () {

                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteItem(id),
                          ),
                        ],
                      ),
                      onTap: () {
                        showSnackBar(
                          context,
                          'ID: $id\nFecha de nacimiento: $day de $month\nNombre completo: $name\nDescripción: $description\nN° de estrellas: $stars',
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'SEGUNDA VISTA: ${widget.nombreAlumno}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
