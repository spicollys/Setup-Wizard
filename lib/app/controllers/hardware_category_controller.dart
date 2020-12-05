import 'package:setup_wizard/app/interfaces/general_controller_interface.dart';

class HardwareCategoryController implements IGeneralPageController {
  static final HardwareCategoryController instance =
      HardwareCategoryController._(); //singleton pattern

  HardwareCategoryController._(); //private constructor: this class just can be instanciated here

  final List<String> _optionList = [
    "Processors",
    "Random Access Memories",
    "Graphic Boards",
  ];

  @override
  List<String> getOptionList() => _optionList;

  @override
  filterOption(int index) {
    switch (index) {
      case 0:
        return isCPU(index);
      case 1:
        return isRAM(index);
      case 2:
        return isGPU(index);
    }
  }

  isCPU(int index) => [_optionList[index], "CPU"];
  isRAM(int index) => [_optionList[index], "RAM"];
  isGPU(int index) => [_optionList[index], "GPU"];
}
