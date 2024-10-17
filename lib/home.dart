import 'package:flutter/material.dart';
import 'package:is_prime_number/is_prime_number.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  final List<int> _fruits = [0];

  void _incrementCounter() {
    setState(() {
      _fruits.add(_counter);
      _counter++;
    });
  }

  String _getType(int n) {
    if (isPrime(n)) return 'Nombre premier';
    if (n.isEven) return 'Pair';
    return 'Impair';
  }

  Color _getColor(int n) {
    if (n.isEven) return Colors.blue;
    return Colors.green;
  }

  AssetImage _getAssetImage(int n) {
    if(isPrime(n)) return const AssetImage('img/ananas.png');
    if(n.isEven) return const AssetImage('img/poire.png');
    return const AssetImage('img/pomme.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('$_counter : ${_getType(_counter)}'),
      ),
      body: Center(
        child:
          ListView(
            children: [
              for (int i = 0; i < _fruits.length; i++)
                ListTile(
                  title: Text('$i'),
                  leading: CircleAvatar(
                    backgroundImage: _getAssetImage(i)
                  ),
                  textColor: Colors.white,
                  tileColor: _getColor(i),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(_getType(i)),
                          backgroundColor: _getColor(i),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                isPrime(_counter)
                                  ? 'img/ananas.png'
                                  : i.isEven
                                    ? 'img/poire.png'
                                    : 'img/pomme.png',
                                width: 200,
                                height: 200
                              ),
                              const Text('Voulez-vous supprimer ce fruit ?'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Oui', style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                setState(() {
                                  _fruits.removeAt(i);
                                });
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text('Non', style: TextStyle(color: Colors.white)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      }
                    );
                  }
                ),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: _counter == 0 ? Colors.red : _getColor(_counter),
        child: const Icon(Icons.add),
      ),
    );
  }
}
