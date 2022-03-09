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
      int totalSpent = 0;
      int toalEarn = 0;
      await spending
          .orderBy('date', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          String datetime =
              '${DateTime.parse(doc['date'].toDate().toString())}';
          String date = datetime.substring(0, 11);
          lists.add(
            HomeSpending(
              date: date,
              money: doc['money'],
              note: doc['note'],
              type: doc['type'],
              typeItem: doc['type_item'],
              iconPath: doc['icon_path']
            ),
          );
        }
      });

      for (var item in lists) {

        if (item.type == 'spending') {
          totalSpent += int.parse(item.money.toString());

        } else if (item.type == 'earning') {
          toalEarn += int.parse(item.money.toString());
        }
      }

      emit(HomeLoaded(
          lists: lists, totalEarn: toalEarn, totalSpent: totalSpent));
    } catch (_) {}
  }

  @override
  void onChange(Change<HomeState> change) {
    print(change);
    super.onChange(change);
  }
}
