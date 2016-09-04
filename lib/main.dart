import 'package:flutter/material.dart';

class Book {
  const Book({this.name, this.cover, this.author});
  final String name;
  final String cover;
  final String author;
}

final List<Book> _books = <Book>[
  new Book(name: 'The Dart Programming Language',
           cover: 'https://www.dartlang.org/assets/covers/dart-programming-language-8b8de43f050ae53fcfc477051363ae2c41515b443ffa7f9c4998a06be5db2589.jpg',
           author: 'Gilad Bracha'),
  new Book(name: 'Learning Dart - Second Edition',
           cover: 'https://www.dartlang.org/assets/covers/learning-dart-a03a3eca556e403d8a908cedd2b37eddb276dbae4d3c8195e1f22586573fd11a.png',
           author: 'Ivo Balbaert and Dzenan Ridjanovic'),
  new Book(name: 'Dart By Example',
           cover: 'https://www.dartlang.org/assets/covers/dart-by-example-8673cc1a199706f99ef00a6be28a64a06ea9678c3dde2e5d0524496fbd529cf5.png',
           author: 'Davy Mitchell'),
  new Book(name: 'Dart Essentials',
           cover: 'https://www.dartlang.org/assets/covers/dart-essentials-sikora-8cfb7b6cb29992e044caa606e7d89ff7a5b94f3af05ca71eccbaee6d93dc6d31.png',
           author: 'Martin Sikora'),
  new Book(name: 'Web Programming with Dart',
           cover: 'https://www.dartlang.org/assets/covers/web-programming-with-dart-4f1ecccf83483e392c24f9665439d487e55a4bd642d16dd7d26ec56292d3938f.jpg',
           author: 'Moises Belchin and Patricia Juberias'),
  new Book(name: 'Mastering Dart',
           cover: 'https://www.dartlang.org/assets/covers/mastering-dart-73ea94b742abca996d44074f6a1b890179da5b3040c717b46347e760bd81fda1.jpg',
           author: 'Sergey Akopkokhyants'),
  new Book(name: 'Dart Cookbook',
           cover: 'https://www.dartlang.org/assets/covers/dart-cookbook-ceca13c8def69dedd85a8e1f07f4d468588ff923459bb562575403f8fdfdc0fc.jpg',
           author: 'Ivo Balbaert'),
  new Book(name: 'Aprende Dart',
           cover: 'https://www.dartlang.org/assets/covers/aprende-dart-cb95db86d0b1caef73088140fc16d1e3eed6103dee57ea84ab31a70c21fc378f.jpg',
           author: 'Moises Belchin and Patricia Juberias'),
  new Book(name: 'Dart for Absolute Beginners',
           cover: 'https://www.dartlang.org/assets/covers/dart-for-absolute-beginners-e2ea5fb5d29478b0375e2855a3eeb714b7902e303a1f83d6f9a1e30e5d39cf94.jpg',
           author: 'David Kopec'),
  new Book(name: 'Dart for Hipsters',
           cover: 'https://www.dartlang.org/assets/covers/dart-for-hipsters-91d0c271741896d087a2c22224f7b99a122520f88d0e9810b49bfb1e5c0fbf86.png',
           author: 'Chris Strom'),
  new Book(name: 'Dart in Action',
           cover: 'https://www.dartlang.org/assets/covers/dart-in-action-6ab8e93b577bf90572ef4c77b10a3dfb0e73d8d4c9c9dd071b22d6a6810cb67d.jpg',
           author: 'Chris Strom'),
  new Book(name: 'Dart: Up and Running',
           cover: 'https://www.dartlang.org/assets/covers/dart-up-and-running-c78e202bb2ad89c04c68c6d0f4564342acbf2cd0a53f98b17130afdf6bc7b75f.gif',
           author: 'Kathy Walrath and Seth Ladd'),
];

typedef void BookChangedCallback(Book book, bool read);

class BookListItem extends StatelessWidget {
  BookListItem({Book book, this.read, this.onBookChanged})
      : book = book,
        super(key: new ObjectKey(book));

  final Book book;
  final bool read;
  final BookChangedCallback onBookChanged;

  TextStyle _getTextStyle(BuildContext context) {
    if (!read) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListItem(
      onTap: () {
        onBookChanged(book, !read);
      },
      title: new Text(book.name, style: _getTextStyle(context)),
      leading: new Image.network(book.cover, fit: ImageFit.cover),
      subtitle: new Text('Written by ' + book.author, style: _getTextStyle(context)),
    );
  }
}

class FlutterBookList extends StatefulWidget {
  FlutterBookList({Key key, this.books}) : super(key: key);

  final List<Book> books;

  @override
  _FlutterBookListState createState() => new _FlutterBookListState();
}

class _FlutterBookListState extends State<FlutterBookList> {
  Set<Book> _books = new Set<Book>();

  void _handleBookChanged(Book book, bool read) {
    setState(() {
      if (read)
        _books.add(book);
      else
        _books.remove(book);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Book List'),
      ),
      body: new MaterialList(
        type: MaterialListType.oneLineWithAvatar,
        children: config.books.map((Book book) {
          return new BookListItem(
            book: book,
            read: _books.contains(book),
            onBookChanged: _handleBookChanged,
          );
        }),
      ),
    );
  }
}

void main() {
  runApp(
    new MaterialApp(
      title: 'Book demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new FlutterBookList(books: _books)
    )
  );
}
