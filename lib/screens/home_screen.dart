import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peticiones/infrastructure/models/pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Pokemon? pokemon;
  int pokemonId = 0;
  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    pokemonId++;
    final response = await Dio().get('https://pokeapi.co/api/v2/pokemon/$pokemonId');
    // * Llamamos al constructor "fromJson" => Retorna la instancia
    pokemon = Pokemon.fromJson(response.data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petición Http'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(pokemon?.name ?? 'No data'),
            if (pokemon != null) ...[
              Image.network(
                pokemon!.sprites.frontDefault,
                height: 200,
                width: 200,
              ),
              Image.network(
                pokemon!.sprites.backDefault,
                height: 200,
                width: 200,
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          // * También se puede enviar solo la refetencia de la función
          getPokemon();
        },
      ),
    );
  }
}
