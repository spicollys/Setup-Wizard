class GameGenreController {
  static final GameGenreController instance =
      GameGenreController._(); //singleton pattern

  GameGenreController._(); //private constructor: this class just can be instanciated here

  static final List<String> genreList = [
    "Indie",
    "Action",
    "Adventure",
    "Casual",
    "Estrategy",
    "RPG",
    "Simulation",
    "Free To Play",
    "Sports",
    "Racing",
    "Massively Multiplayer",
    "Non-game",
  ];

  filterGenre(int index) {
    switch (index) {
      case 0:
        return isIndie();
      case 1:
        return isAction();
      case 2:
        return isAdventure();
      case 3:
        return isCasual();
      case 4:
        return isEstrategy();
      case 5:
        return isRPG();
      case 6:
        return isSimulation();
      case 7:
        return isFreeToPlay();
      case 8:
        return isSports();
      case 9:
        return isRacing();
      case 10:
        return isMassivelyMultiplayer();
      case 11:
        return isNonGame();
    }
  }

  isIndie() => print("Indie"); //Return Indie Games True
  isAction() => print("Action"); //Return Action Games True
  isAdventure() => print("Adventure"); //Return Adventure Games True
  isCasual() => print("Casual"); //Return Casual Games True
  isEstrategy() => print("Estrategy"); //Return Estrategy Games True
  isRPG() => print("RPG"); //Return RPG Games True
  isSimulation() => print("Simulation"); //Return Simulation Games True
  isFreeToPlay() => print("Free To Play"); //Return Free To Play Games True
  isSports() => print("Sports"); //Return Sports Games True
  isRacing() => print("Racing"); //Return Racing Games True
  isMassivelyMultiplayer() =>
      print("Massively Multiplayer"); //Return Massively Multiplayer Games True
  isNonGame() => print("Non-game"); //Return Non-game True

}
