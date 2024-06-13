import 'package:flutter/material.dart';
import 'package:libraryit/api/book_api.dart';
import 'package:libraryit/models/book.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LibraryIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 177, 235, 243)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Book Collection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Book> _bookList = List<Book>.empty();
  final BookApi _api = BookApi.newFromToken('tok');

  void loadAllBooks() async {
    final result = await _api.getAllBooks();
    setState(() {
      _bookList = List<Book>.from(result['data']);
    });
  }

  @override
  void initState() {
    super.initState();
    loadAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title, 
          style: const TextStyle(fontWeight: FontWeight.w700)
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _bookList.length,

          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(_bookList[index].title)
                  ],
                ),
              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        tooltip: 'Add Book',
        child: const Icon(Icons.add),
      ),
    );
  }
}
