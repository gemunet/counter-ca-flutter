import 'package:counter/components/counter/domain/model/increment_request.dart';
import 'package:counter/components/counter/domain/usecases/increment_counter_usecase.dart';
import 'package:counter/components/counter/icounter_repository.dart';
import 'package:flutter/material.dart';

import '../../service_locator.dart';

class CounterViewModel {
  final repository = getIt.get<ICounterRepository>();
  IncrementCounterUseCase _incrementCounterUseCase;

  int _counterId = 0;
  ValueNotifier<int> counterValue = ValueNotifier(0);

  CounterViewModel() {
    this._incrementCounterUseCase = IncrementCounterUseCase(repository);
  }

  void incrementCounter() async {
    var request = IncrementRequest(_counterId);
    var response = await this._incrementCounterUseCase.execute(request);
    this.counterValue.value = response.value;
  }
}
