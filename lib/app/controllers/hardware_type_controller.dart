class HardwareTypeController{

    static final HardwareTypeController instance =
      HardwareTypeController._(); //singleton pattern

  HardwareTypeController._(); //private constructor: this class just can be instanciated here

  static final List<String> typeList = [
    "Processor",
    "MemoryRam",
    "GraphicsCard",
  ];

  filterType(int index) {
    switch (index) {
      case 0:
        return isProcessor();
      case 1:
        return isMemoryRam();
      case 2:
        return isGraphicsCard();
    }
  }

  isProcessor() => print("Processor"); //Return Processor True
  isMemoryRam() => print("MemoryRam"); //Return MemoryRam True
  isGraphicsCard() => print("GraphicsCard"); //Return GraphicsCard True

}