import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/screens/pokemon_favourites_screen.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';
import 'package:pokemon_list/widgets/pokemon_vertical_slider.dart';

import '../obtainData/pokemon_api_service.dart';
import '../widgets/pokemon_screen_loader.dart';
import '../widgets/pokemon_text_title_with_shadow.dart';
import '../widgets/pokemon_weak_connection.dart';
import '../widgets/pokemon_weak_connection_retry.dart';

class PokemonEvolutions extends StatefulWidget {
  final List<dynamic> pokemonList;
  final String pokemonChainURL;

  const PokemonEvolutions(this.pokemonList, this.pokemonChainURL, {super.key});

  @override
  State<PokemonEvolutions> createState() => _PokemonEvolutions();
}

class _PokemonEvolutions extends State<PokemonEvolutions> {
  final PokemonApiService apiService = PokemonApiService();

  late bool isDeviceConnected = false;
  late String isAlertSet = 'unknown';

  Future<void> fetchPokemonData() async {
    try {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (isDeviceConnected == true) {
        //final pokemonData = await apiService.fetchPokemonData(url: 'https://pokeapi.co/api/v2/pokemon?limit=721', characteristics: 'results',);
        setState(() {
          // Obtain Entire Pokemon List and Divide Per Region
          isAlertSet = 'false';
        });
        return;
      } else {
        setState(() => isAlertSet = 'true');
      }
    } catch (e) {
      // Handle error
      //print('Failed to fetch Pokemon list: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.redAccent,
        elevation: 10,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleWithShadow('Evolution Chain', 26),
          ],
        ),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: Image.asset(
              'images/Poke_Ball.webp',
              width: 60,
              height: 50,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 4)),
          builder: (context, snapshot) {
            if ((snapshot.connectionState == ConnectionState.done) &&
                (isAlertSet == 'false')) {
              return SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        widget.pokemonList.toString(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        widget.pokemonChainURL,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PokemonVerticalSlider(widget.pokemonList, 0),
                      const SizedBox(
                        height: 30,
                      ),
                      PokemonVerticalSlider(widget.pokemonList, 1),
                      const SizedBox(
                        height: 30,
                      ),
                      Builder(builder: (BuildContext context) {
                        if (widget.pokemonList.length > 2) {
                          return PokemonVerticalSlider(widget.pokemonList, 2);
                        } else {
                          return const SizedBox(
                            height: 5,
                          );
                        }
                      }),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              );
            } else if (isAlertSet == 'true') {
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const PokemonWeakConnectionImage(),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            isAlertSet = 'unknown';
                          }),
                          fetchPokemonData(),
                        },
                        child: const PokemonWeakConnectionRetry(),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ]),
              );
            } else {
              return const ScreenLoader();
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Favourite',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const PokemonListScreen(),
                maintainState: false,
              ),
              (Route<dynamic> route) => false,
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PokemonFavouriteListScreen(),
                maintainState: false,
              ),
            );
          }
        },
      ),
    );
  }
}
