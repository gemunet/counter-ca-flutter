import 'package:counter/components/counter/domain/entities/counter.dart';
import 'package:counter/components/counter/icounter_repository.dart';

class CounterInMemoryRepository implements ICounterRepository {
  List<Counter> counters = List();

  @override
  Future<Counter> getCounterById(int id) async {
    print('getCounterById: $id');
    return counters.firstWhere((element) => element.id == id,
        orElse: () => Counter(id: id, value: 0));
  }

  @override
  Future<void> saveCounter(Counter counter) async {
    print('saveCounter: $counter');
    counters.removeWhere((element) => element.id == counter.id);
    counters.add(counter);
  }
}
