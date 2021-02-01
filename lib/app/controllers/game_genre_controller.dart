import 'package:setup_wizard/app/interfaces/general_controller_interface.dart';

class GameGenreController implements IFilterCategoryController {
  static final GameGenreController instance =
      GameGenreController._(); //singleton pattern

  GameGenreController._(); //private constructor: this class just can be instanciated here

  final List<String> _optionList = [
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

  @override
  List<String> getOptionList() => _optionList;

  @override
  filterOption(int index) {
    switch (index) {
      case 0:
        return isIndie(index);
      case 1:
        return isAction(index);
      case 2:
        return isAdventure(index);
      case 3:
        return isCasual(index);
      case 4:
        return isEstrategy(index);
      case 5:
        return isRPG(index);
      case 6:
        return isSimulation(index);
      case 7:
        return isFreeToPlay(index);
      case 8:
        return isSports(index);
      case 9:
        return isRacing(index);
      case 10:
        return isMassivelyMultiplayer(index);
      case 11:
        return isNonGame(index);
    }
  }

  isIndie(int index) => [_optionList[index], 'genreIsIndie'];
  isAction(int index) => [_optionList[index], 'genreIsAction'];
  isAdventure(int index) => [_optionList[index], 'genreIsAdventure'];
  isCasual(int index) => [_optionList[index], 'genreIsCasual'];
  isEstrategy(int index) => [_optionList[index], 'genreIsEstrategy'];
  isRPG(int index) => [_optionList[index], 'genreIsRPG'];
  isSimulation(int index) => [_optionList[index], 'genreIsSimulation'];
  isFreeToPlay(int index) => [_optionList[index], 'genreIsFreeToPlay'];
  isSports(int index) => [_optionList[index], 'genreIsSports'];
  isRacing(int index) => [_optionList[index], 'genreIsRacing'];
  isMassivelyMultiplayer(int index) =>
      [_optionList[index], 'genreIsMassivelyMultiplayer'];
  isNonGame(int index) => [_optionList[index], 'genreIsNonGame'];
}
