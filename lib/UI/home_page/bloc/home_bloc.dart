import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:spending_management/models/home_spending.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onFetchData);
  }

  _onFetchData(HomeStarted event, Emitter<HomeState> emit) async {
    try {
      var currentUser = FirebaseAuth.instance.currentUser;
      var spending = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('spending');
      List<HomeSpending> lists = [];
      await spending
          .orderBy('date', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          String date = '${DateTime.parse(doc['date'].toDate().toString())}';
          lists.add(HomeSpending(
            date: date,
            money: doc['money'],
            note: doc['note'],
            type: doc['type'],
            typeItem: doc['type_item'],

          ),);
        }
      });
      emit(HomeLoaded(lists: lists));
    } catch (_) {}
  }
}
