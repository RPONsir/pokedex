class PokemonNameChecker {

  // Checks if the name has no more text after an "-" and removes it
  // For special pokemon name cases vs GIF URL - Name fas fixed to match Database
  lineChecker(pokemon) {
    final pokemonName = pokemon;
    // Special Case Mr Mime
    if (pokemonName == ('mr-mime')) {
      const pokemonFinalName = 'mr-mime';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/mr._mime.gif';
      return [pokemonFinalName, imageUrl];
    }
    // Special Case Mime Jr
    if (pokemonName == ('mime-jr')) {
      const pokemonFinalName = 'mime-jr';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/mime_jr.gif';
      return [pokemonFinalName, imageUrl];
    }
    // Special case Nidoran male
    else if (pokemonName == ('nidoran-m')) {
      const pokemonFinalName = 'nidoran-m';
      const imageUrl = 'https://professorlotus.com/Sprites/Nidoran_M.gif';
      return [pokemonFinalName, imageUrl];
    }
    // Special case Nidoran female
    else if (pokemonName == ('nidoran-f')) {
      const pokemonFinalName = 'nidoran-f';
      const imageUrl = 'https://professorlotus.com/Sprites/Nidoran_F.gif';
      return [pokemonFinalName, imageUrl];
    }
    // Special case Ho-Oh that does not need to be removed the name after the "-"
    else if (pokemonName == ('ho-oh')) {
      const pokemonFinalName = 'ho-oh';
      const imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
      return [pokemonFinalName, imageUrl];
    }
    else {
      final pokemonLine = pokemonName.indexOf("-");
      // If therese an index of "-" remove string since the character
      if (pokemonLine > 0) {
        final pokemonFinalName = pokemonName.substring(0, pokemonLine);
        //final imageUrl = 'https://professorlotus.com/Sprites/$pokemonFinalName.gif';
        final imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
        return [pokemonFinalName, imageUrl];
      }
      // No "-" was found - name remains the same
      else{
        final pokemonFinalName = pokemonName;
        //final imageUrl = 'https://professorlotus.com/Sprites/$pokemonFinalName.gif';
        final imageUrl = 'https://www.pkparaiso.com/imagenes/xy/sprites/animados/$pokemonFinalName.gif';
        return [pokemonFinalName, imageUrl];
      }
    }
  }

  pokemonListComparison(List<dynamic> allPokemonList, String pokemonName){
    bool isFound=false;
    // Search if the received name matches with the Api Pokemon List name
    for (int i = 0; i < 721; i++) {
      // Retrieve Pokemon name as String from API
      final pokemon = allPokemonList[i];
      String pokemonNameOnList= pokemon['name'].toString();
      // Check Name to match the Current Input and Displayed Name on the ListView
      final newName = lineChecker(pokemonNameOnList);
      pokemonNameOnList = newName[0];
      // Compare - if matches return True
      if(pokemonName==pokemonNameOnList){
        isFound = true;
        return isFound;
      }
      // If no match found after navigating all pokemon names on list, return False
    }return isFound;
  }
}