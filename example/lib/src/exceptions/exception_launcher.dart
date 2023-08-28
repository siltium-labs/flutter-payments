class ExceptionLauncher {
  static final ExceptionLauncher _instance = ExceptionLauncher._constructor();

  factory ExceptionLauncher() {
    return _instance;
  }

  ExceptionLauncher._constructor();

  bool _mustThrowException = false;
  int _amountOfLaunches = 0;
  int _amountOfLaunchesIndex = 0;

  void enableThrowException({int amountOfLaunches = 1}) async {
    _mustThrowException = true;
    _amountOfLaunches = amountOfLaunches;
    _amountOfLaunchesIndex = 0;
  }

  explode() {
    if(_mustThrowException || _amountOfLaunchesIndex < _amountOfLaunches) {
      _mustThrowException = false;
      _amountOfLaunchesIndex ++;
      throw Exception("A Test Exception");
    }
  }
}
