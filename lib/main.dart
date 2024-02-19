import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Student {
  String name;
  double averageScore;
  String photo;
  bool isActive;

  Student({required this.name, required this.averageScore, required this.photo, this.isActive = false});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Student> students = [
    /*Student(name: 'Саттаров Тимур', averageScore: 85.0, photo: 'https://paywin.kz/images/1.jpg'),
    Student(name: 'Мурашева Жулдыз', averageScore: 92.0, photo: 'https://paywin.kz/images/2.jpg', isActive: true),
    Student(name: 'Турешов Ержан', averageScore: 78.0, photo: 'https://paywin.kz/images/3.jpg'),
    Student(name: 'Байзакова Айжан', averageScore: 88.0, photo: 'https://paywin.kz/images/4.jpg', isActive: true),*/
    Student(name: 'Саттаров Тимур', averageScore: 85.0, photo: 'https://i1.poltava.to/news/63/6201/photo.jpg'),
    Student(name: 'Мурашева Жулдыз', averageScore: 92.0, photo: 'https://img.freepik.com/premium-psd/portrait-of-student-holding-laptop-with-mock-up_23-2148513605.jpg', isActive: true),
    Student(name: 'Турешов Ержан', averageScore: 78.0, photo: 'https://i1.poltava.to/news/63/6201/content/stud.jpg'),
    Student(name: 'Байзакова Айжан', averageScore: 88.0, photo: 'https://www.mgpu.ru/wp-content/uploads/2021/01/i-m-prepared-exam-very-well-scaled.jpg', isActive: true),
  ];

  List<Student> get activeStudents => students.where((student) => student.isActive).toList();
  List<Student> get allStudents => students;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Студенты'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Все студенты'),
              Tab(text: 'Активные студенты'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StudentList(students: allStudents),
            StudentList(students: activeStudents),
          ],
        ),
      ),
    );
  }
}

class StudentList extends StatelessWidget {
  final List<Student> students;

  const StudentList({Key? key, required this.students}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network(students[index].photo, width: 50, height: 50,),
          title: Text(students[index].name),
          subtitle: Text('Средний балл: ${students[index].averageScore}'),
          trailing: ElevatedButton(
            onPressed: () => _showConfirmationBottomSheet(context, students[index]),
            child: Text(students[index].isActive ? 'Неактивный' : 'Активный'),
          ),
        );
      },
    );
  }

  void _showConfirmationBottomSheet(BuildContext context, Student student) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Вы уверены что хотите сделать студента ${student.name} ${student.isActive ? 'не активном' : 'активном'}?'),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Отмена'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      student.isActive = !student.isActive;
                      Navigator.pop(context);
                    },
                    child: Text(student.isActive ? 'Неактивный' : 'Активный'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}