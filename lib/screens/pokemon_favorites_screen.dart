import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokemon_list/screens/pokemon_list_screen.dart';

import '../widgets/build_pokemon_favorite_grid.dart';
import '../widgets/pokemon_screen_loader.dart';
import '../widgets/pokemon_text_title_with_shadow.dart';

class PokemonFavoriteListScreen extends StatefulWidget {
  const PokemonFavoriteListScreen({super.key});
  @override
  PokemonFavoriteListScreenState createState() => PokemonFavoriteListScreenState();
}

class PokemonFavoriteListScreenState extends State<PokemonFavoriteListScreen> {

  late bool isDeviceConnected;
  late String isAlertSet = 'unknown';
  List favoritePokemonList = [
    {
      "name": "bulbasaur",
      "value": "1"
    },
    {
      "name": "charmander",
      "value": "4"
    }];

  @override
  void initState() {
    dataChecker();
    super.initState();
  }

  Future<String> dataChecker()async {
    isDeviceConnected = await InternetConnectionChecker().hasConnection;
    if(isDeviceConnected ==true){
      isAlertSet = 'false';
      return isAlertSet;
    }
    else{
      isAlertSet = 'true';
      return isAlertSet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          elevation: 10,
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {Navigator.pop(context);},
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleWithShadow('Favorites', 26),
            ],
          ),
          actions: [
            Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: Image.asset('images/Poke_Ball.webp', width:60, height:50,),
            ),
          ]
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 4)),
          builder: (context, snapshot){
            if(isAlertSet=='false'){
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30,),
                    BuildPokemonFavoriteGrid(favoritePokemonList),
                  ],
                ),
              );
            }
            else if(isAlertSet=='true'){
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50,),
                      Image.asset('images/loaderrorImage.gif', height: 300,),
                      const Text("No internet Connection Detected",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () async =>  {
                          setState((){
                            isAlertSet = 'unknown';
                          }),
                          isDeviceConnected = await InternetConnectionChecker().hasConnection,
                          if(isDeviceConnected == true){
                            isAlertSet = 'false',
                          }
                          else{
                            isAlertSet = 'true',
                          },
                          Future.delayed(const Duration(seconds: 4)),(){
                            setState(() {
                              isAlertSet;
                            });
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Please Try Again",
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(width: 10,),
                            //Image.asset('images/refreshIcon.jpeg', height: 50,),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100,),
                    ]
                ),
              );
            }
            else{
              return const ScreenLoader();
            }
          }
      ),
      bottomNavigationBar: BottomNavigationBar (
        currentIndex: 1,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokemon',
          ),
        ],
        onTap: (index) {
          if(index==0){
            Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(
              builder: (context) =>
              const PokemonListScreen(),
              maintainState: false,
            ),
                  (Route<dynamic> route) => false,
            );
          }
        },
      ),
    );
  }
}