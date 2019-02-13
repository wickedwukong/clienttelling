import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // #docregion build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'John Lewis Clienttelling',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class Customer {
  String firstName;
  String lastName;

  Customer(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  String fullName() {
    return firstName + " " + lastName;
  }
}

class RandomWordsState extends State<RandomWords> {
  final _customers = <Customer>[
    Customer("Joanna", "Biggar"),
    Customer("Esther", "Jackson"),
    Customer("Daisy", "Woodward"),
    Customer("Gabrielle", "John"),
    Customer("Amy", "Ixer"),
    Customer("Angela", "Worley"),
    Customer("Rohina", "Adams"),
    Customer("Lucy", "Tamley")
  ];
  final _saved = new Set<Customer>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          /*2*/

          final index = i ~/ 2;
          if (index < _customers.length)
            return _buildRow(_customers[index]);
          else
            return _buildRow(_customers.last);
        },
        itemCount: _customers.length * 2
    );
  }

  Widget _buildRow(Customer customer) {
    final bool alreadySaved = _saved.contains(customer);
    return ListTile(
      title: Text(
        customer.fullName(),
        style: _biggerFont,
      ),
      trailing: new Icon(
        // Add the lines from here...
        alreadySaved ? Icons.arrow_forward : Icons.arrow_forward,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute<void>(
            builder: (BuildContext context) {
              final Iterable<ListTile> tiles = _saved.map(
                    (Customer customer) {
                  return new ListTile(
                    title: new Text(
                      customer.fullName(),
                      style: _biggerFont,
                    ),
                  );
                },
              );
              final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList();

              return new Scaffold(
                // Add 6 lines from here...
                appBar: new AppBar(
                  title: Text(customer.fullName()),
                ),
                body: new ListView(children: divided),
              ); // ... to here.
            },
          ),
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (Customer customer) {
              return new ListTile(
                title: new Text(
                  customer.fullName(),
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return new Scaffold(
            // Add 6 lines from here...
            appBar: new AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          ); // ... to here.
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/jl.jpg',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0), child: Text('Welcome, Tom Monetto'))
          ],

        ),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
