import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../mockdata/spending_data.dart';
import '../model/spending.dart';

part 'spending_event.dart';
part 'spending_state.dart';

class SpendingBloc extends Bloc<SpendingEvent, SpendingState> {
  final TextEditingController searchController = TextEditingController();
  SpendingBloc() : super(SpendingInitial(lists: listSpending)) {
    on<SearchSpending>(_onSearch);
  }

  _onSearch(SearchSpending event, Emitter<SpendingState> emit) {
    try {
      var listResult = listSpending
          .where((item) => item.title!
              .toLowerCase()
              .contains(searchController.text.trim().toLowerCase()))
          .toList();
      var currentState = state;
      if (currentState is SpendingInitial) {
        if (searchController.text.isEmpty) {
          emit(currentState.update(lists: listSpending));
        } else {
          if (listResult.isEmpty) {
            emit(currentState.update(lists: [listSpending.last]));
          } else {
            emit(currentState.update(lists: listResult));
          }
        }
      }
    } catch (e) {
      debugPrint('error: $e');
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
