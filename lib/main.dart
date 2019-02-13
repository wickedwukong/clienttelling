import 'package:flutter/material.dart';
import 'package:clienttelling/recommendation.dart';
import 'package:clienttelling/customer.dart';

void main() => runApp(ClienttellingApp());

class ClienttellingApp extends StatelessWidget {
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

class RandomWordsState extends State<RandomWords> {
   _getCustomers () => <Customer>[
    Customer("Joanna", "Biggar", [
      Recommendation("Gina Bacconi Brielle Dress, Pink", "1.jpeg"),
      Recommendation(
          "Phase Eight Emanuella Floral Printed Dress, Oyster", "2.jpeg")
    ]),
    Customer("Esther", "Jackson",
        [Recommendation("Modern Rarity Ruffle Front Dress, Pink", "3.jpeg")]),
    Customer("Daisy", "Woodward", []),
    Customer("Gabrielle", "John", []),
    Customer("Amy", "Ixer", []),
    Customer("Angela", "Worley", []),
    Customer("Rohina", "Adams", []),
    Customer("Lucy", "Tamley", [])
  ];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildCustomers() {
    final customer = _getCustomers();
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();

          final index = i ~/ 2;
          if (index < customer.length)
            return _buildRow(customer[index]);
          else
            return _buildRow(customer.last);
        },
        itemCount: customer.length * 2);
  }

  Widget _buildRow(Customer customer) {
    return ListTile(
      title: Text(
        customer.fullName(),
        style: _biggerFont,
      ),
      trailing: new Icon(Icons.arrow_forward),
      onTap: () {
        _navigateToDisplayRecommendations(customer);
      },
    );
  }

  void _navigateToDisplayRecommendations(Customer customer) {
    {
      Navigator.of(context).push(
        new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            final Iterable<ListTile> tiles = customer.recs.map(
                  (Recommendation rec) {
                return new ListTile(
                    title: new Text(
                      rec.title,
                      style: _biggerFont,
                    ),
                    trailing: Image.asset(
                      'assets/images/${rec.image}',
                      fit: BoxFit.contain,
                      height: 32,
                    ));
              },
            );
            final List<Widget> divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: Text(customer.fullName()),
              ),
              body: new ListView(children: divided),
            ); // ... to here.
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/jl.jpg',
              fit: BoxFit.contain,
              alignment: Alignment.topLeft,
              height: 32,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text('Welcome, Tom Monetto'),
            ),
          ],
        ),
      ),
      body: _buildCustomers(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
