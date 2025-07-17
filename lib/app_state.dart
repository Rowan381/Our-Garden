import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = FlutterSecureStorage();
    await _safeInitAsync(() async {
      _canChangeWeather = await secureStorage.getBool('ff_canChangeWeather') ??
          _canChangeWeather;
    });
    await _safeInitAsync(() async {
      _updateWeatherTime =
          await secureStorage.read(key: 'ff_updateWeatherTime') != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (await secureStorage.getInt('ff_updateWeatherTime'))!)
              : _updateWeatherTime;
    });
    await _safeInitAsync(() async {
      _weather = await secureStorage.getString('ff_weather') ?? _weather;
    });
    await _safeInitAsync(() async {
      _lastTaskResetDate =
          await secureStorage.read(key: 'ff_lastTaskResetDate') != null
              ? DateTime.fromMillisecondsSinceEpoch(
                  (await secureStorage.getInt('ff_lastTaskResetDate'))!)
              : _lastTaskResetDate;
    });
    await _safeInitAsync(() async {
      _prevWeatherSet =
          await secureStorage.getBool('ff_prevWeatherSet') ?? _prevWeatherSet;
    });
    await _safeInitAsync(() async {
      _prevLocationSet =
          await secureStorage.getBool('ff_prevLocationSet') ?? _prevLocationSet;
    });
    await _safeInitAsync(() async {
      _AIScrollingChatHeight =
          await secureStorage.getInt('ff_AIScrollingChatHeight') ??
              _AIScrollingChatHeight;
    });
    await _safeInitAsync(() async {
      _postListingFilters =
          await secureStorage.getStringList('ff_postListingFilters') ??
              _postListingFilters;
    });
    await _safeInitAsync(() async {
      _kindwiseapikey =
          await secureStorage.getString('ff_kindwiseapikey') ?? _kindwiseapikey;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  List<String> _listOfPageValues = ['gardens', 'plants'];
  List<String> get listOfPageValues => _listOfPageValues;
  set listOfPageValues(List<String> value) {
    _listOfPageValues = value;
  }

  void addToListOfPageValues(String value) {
    listOfPageValues.add(value);
  }

  void removeFromListOfPageValues(String value) {
    listOfPageValues.remove(value);
  }

  void removeAtIndexFromListOfPageValues(int index) {
    listOfPageValues.removeAt(index);
  }

  void updateListOfPageValuesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    listOfPageValues[index] = updateFn(_listOfPageValues[index]);
  }

  void insertAtIndexInListOfPageValues(int index, String value) {
    listOfPageValues.insert(index, value);
  }

  String _currentPageSelection = 'plants';
  String get currentPageSelection => _currentPageSelection;
  set currentPageSelection(String value) {
    _currentPageSelection = value;
  }

  bool _gardenCreateBool = false;
  bool get gardenCreateBool => _gardenCreateBool;
  set gardenCreateBool(bool value) {
    _gardenCreateBool = value;
  }

  String _widthSelection = '';
  String get widthSelection => _widthSelection;
  set widthSelection(String value) {
    _widthSelection = value;
  }

  String _heightSelection = '';
  String get heightSelection => _heightSelection;
  set heightSelection(String value) {
    _heightSelection = value;
  }

  bool _isOptionsOpen = false;
  bool get isOptionsOpen => _isOptionsOpen;
  set isOptionsOpen(bool value) {
    _isOptionsOpen = value;
  }

  String _createPlantIMGURL = '';
  String get createPlantIMGURL => _createPlantIMGURL;
  set createPlantIMGURL(String value) {
    _createPlantIMGURL = value;
  }

  String _editPlantURL = '';
  String get editPlantURL => _editPlantURL;
  set editPlantURL(String value) {
    _editPlantURL = value;
  }

  String _openaiapikey =
      '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';
  String get openaiapikey => _openaiapikey;
  set openaiapikey(String value) {
    _openaiapikey = value;
  }

  bool _gptIsEmpty = true;
  bool get gptIsEmpty => _gptIsEmpty;
  set gptIsEmpty(bool value) {
    _gptIsEmpty = value;
  }

  String _editListingURL = '';
  String get editListingURL => _editListingURL;
  set editListingURL(String value) {
    _editListingURL = value;
  }

  String _createListingURL = '';
  String get createListingURL => _createListingURL;
  set createListingURL(String value) {
    _createListingURL = value;
  }

  bool _canChangeWeather = false;
  bool get canChangeWeather => _canChangeWeather;
  set canChangeWeather(bool value) {
    _canChangeWeather = value;
    secureStorage.setBool('ff_canChangeWeather', value);
  }

  void deleteCanChangeWeather() {
    secureStorage.delete(key: 'ff_canChangeWeather');
  }

  DateTime? _updateWeatherTime;
  DateTime? get updateWeatherTime => _updateWeatherTime;
  set updateWeatherTime(DateTime? value) {
    _updateWeatherTime = value;
    value != null
        ? secureStorage.setInt(
            'ff_updateWeatherTime', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_updateWeatherTime');
  }

  void deleteUpdateWeatherTime() {
    secureStorage.delete(key: 'ff_updateWeatherTime');
  }

  String _weather = '';
  String get weather => _weather;
  set weather(String value) {
    _weather = value;
    secureStorage.setString('ff_weather', value);
  }

  void deleteWeather() {
    secureStorage.delete(key: 'ff_weather');
  }

  DateTime? _lastTaskResetDate =
      DateTime.fromMillisecondsSinceEpoch(1723253220000);
  DateTime? get lastTaskResetDate => _lastTaskResetDate;
  set lastTaskResetDate(DateTime? value) {
    _lastTaskResetDate = value;
    value != null
        ? secureStorage.setInt(
            'ff_lastTaskResetDate', value.millisecondsSinceEpoch)
        : secureStorage.remove('ff_lastTaskResetDate');
  }

  void deleteLastTaskResetDate() {
    secureStorage.delete(key: 'ff_lastTaskResetDate');
  }

  bool _prevWeatherSet = true;
  bool get prevWeatherSet => _prevWeatherSet;
  set prevWeatherSet(bool value) {
    _prevWeatherSet = value;
    secureStorage.setBool('ff_prevWeatherSet', value);
  }

  void deletePrevWeatherSet() {
    secureStorage.delete(key: 'ff_prevWeatherSet');
  }

  bool _prevLocationSet = true;
  bool get prevLocationSet => _prevLocationSet;
  set prevLocationSet(bool value) {
    _prevLocationSet = value;
    secureStorage.setBool('ff_prevLocationSet', value);
  }

  void deletePrevLocationSet() {
    secureStorage.delete(key: 'ff_prevLocationSet');
  }

  String _waste = '';
  String get waste => _waste;
  set waste(String value) {
    _waste = value;
  }

  bool _DisplaySuggestedQuestions = true;
  bool get DisplaySuggestedQuestions => _DisplaySuggestedQuestions;
  set DisplaySuggestedQuestions(bool value) {
    _DisplaySuggestedQuestions = value;
  }

  int _AIScrollingChatHeight = 65;
  int get AIScrollingChatHeight => _AIScrollingChatHeight;
  set AIScrollingChatHeight(int value) {
    _AIScrollingChatHeight = value;
    secureStorage.setInt('ff_AIScrollingChatHeight', value);
  }

  void deleteAIScrollingChatHeight() {
    secureStorage.delete(key: 'ff_AIScrollingChatHeight');
  }

  List<String> _selectedFilters = [];
  List<String> get selectedFilters => _selectedFilters;
  set selectedFilters(List<String> value) {
    _selectedFilters = value;
  }

  void addToSelectedFilters(String value) {
    selectedFilters.add(value);
  }

  void removeFromSelectedFilters(String value) {
    selectedFilters.remove(value);
  }

  void removeAtIndexFromSelectedFilters(int index) {
    selectedFilters.removeAt(index);
  }

  void updateSelectedFiltersAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedFilters[index] = updateFn(_selectedFilters[index]);
  }

  void insertAtIndexInSelectedFilters(int index, String value) {
    selectedFilters.insert(index, value);
  }

  bool _isProduce = false;
  bool get isProduce => _isProduce;
  set isProduce(bool value) {
    _isProduce = value;
  }

  List<String> _postListingFilters = [];
  List<String> get postListingFilters => _postListingFilters;
  set postListingFilters(List<String> value) {
    _postListingFilters = value;
    secureStorage.setStringList('ff_postListingFilters', value);
  }

  void deletePostListingFilters() {
    secureStorage.delete(key: 'ff_postListingFilters');
  }

  void addToPostListingFilters(String value) {
    postListingFilters.add(value);
    secureStorage.setStringList('ff_postListingFilters', _postListingFilters);
  }

  void removeFromPostListingFilters(String value) {
    postListingFilters.remove(value);
    secureStorage.setStringList('ff_postListingFilters', _postListingFilters);
  }

  void removeAtIndexFromPostListingFilters(int index) {
    postListingFilters.removeAt(index);
    secureStorage.setStringList('ff_postListingFilters', _postListingFilters);
  }

  void updatePostListingFiltersAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    postListingFilters[index] = updateFn(_postListingFilters[index]);
    secureStorage.setStringList('ff_postListingFilters', _postListingFilters);
  }

  void insertAtIndexInPostListingFilters(int index, String value) {
    postListingFilters.insert(index, value);
    secureStorage.setStringList('ff_postListingFilters', _postListingFilters);
  }

  List<DocumentReference> _queriedProducts = [];
  List<DocumentReference> get queriedProducts => _queriedProducts;
  set queriedProducts(List<DocumentReference> value) {
    _queriedProducts = value;
  }

  void addToQueriedProducts(DocumentReference value) {
    queriedProducts.add(value);
  }

  void removeFromQueriedProducts(DocumentReference value) {
    queriedProducts.remove(value);
  }

  void removeAtIndexFromQueriedProducts(int index) {
    queriedProducts.removeAt(index);
  }

  void updateQueriedProductsAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    queriedProducts[index] = updateFn(_queriedProducts[index]);
  }

  void insertAtIndexInQueriedProducts(int index, DocumentReference value) {
    queriedProducts.insert(index, value);
  }

  String _kindwiseapikey = 'hBxrU4wfkIeQK5oR3ngI4gs5p6eh1AQhl04rX4LjwhN7c47tYs';
  String get kindwiseapikey => _kindwiseapikey;
  set kindwiseapikey(String value) {
    _kindwiseapikey = value;
    secureStorage.setString('ff_kindwiseapikey', value);
  }

  void deleteKindwiseapikey() {
    secureStorage.delete(key: 'ff_kindwiseapikey');
  }

  String _sortType = '';
  String get sortType => _sortType;
  set sortType(String value) {
    _sortType = value;
  }

  String _sortOn = '';
  String get sortOn => _sortOn;
  set sortOn(String value) {
    _sortOn = value;
  }

  int _maxPrice = 9999999999;
  int get maxPrice => _maxPrice;
  set maxPrice(int value) {
    _maxPrice = value;
  }

  int _minPrice = -10;
  int get minPrice => _minPrice;
  set minPrice(int value) {
    _minPrice = value;
  }

  String _runID = '';
  String get runID => _runID;
  set runID(String value) {
    _runID = value;
  }

  String _userMessage = '';
  String get userMessage => _userMessage;
  set userMessage(String value) {
    _userMessage = value;
  }

  String _assistantReply = '';
  String get assistantReply => _assistantReply;
  set assistantReply(String value) {
    _assistantReply = value;
  }

  String _aithreadid = '';
  String get aithreadid => _aithreadid;
  set aithreadid(String value) {
    _aithreadid = value;
  }

  String _threadId = 'thread_RRb3Ds5PdTT9F6amhPnaK4Lr';
  String get threadId => _threadId;
  set threadId(String value) {
    _threadId = value;
  }

  final _userDocQueryManager = FutureRequestManager<UsersRecord>();
  Future<UsersRecord> userDocQuery({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<UsersRecord> Function() requestFn,
  }) =>
      _userDocQueryManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearUserDocQueryCache() => _userDocQueryManager.clear();
  void clearUserDocQueryCacheKey(String? uniqueKey) =>
      _userDocQueryManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: ListToCsvConverter().convert([value]));
}
