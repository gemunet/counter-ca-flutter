import 'package:counter/components/counter/domain/entities/counter.dart';
import 'package:counter/components/counter/domain/model/increment_request.dart';
import 'package:counter/components/counter/domain/model/increment_response.dart';
import 'package:counter/components/counter/icounter_repository.dart';

class IncrementCounterUseCase {
  final ICounterRepository _repository;

  IncrementCounterUseCase(this._repository);

  Future<IncrementResponse> execute(IncrementRequest request) async {
    print('IncrementCounterUseCase: $request');
    var counter = await _repository.getCounterById(request.id);

    var incCounter = Counter(id: counter.id, value: counter.value + 1);
    await _repository.saveCounter(incCounter);

    return IncrementResponse(id: incCounter.id, value: incCounter.value);
  }
}
