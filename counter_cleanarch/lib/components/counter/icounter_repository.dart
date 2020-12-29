import 'domain/entities/counter.dart';

abstract class ICounterRepository {
  Future<Counter> getCounterById(int id) {
    throw StateError('Not implemented!');
  }

  Future<void> saveCounter(Counter counter) {
    throw StateError('Not implemented!');
  }
}
