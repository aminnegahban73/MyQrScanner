import 'package:rxdart/rxdart.dart';

class ButtonMessagebus {
  BehaviorSubject<int> _buttonIdSubject = BehaviorSubject<int>.seeded(-1);
  Stream<int> get idStream => _buttonIdSubject.stream;
  void broadcastId(int id) {
    _buttonIdSubject.add(id);
  }
}
