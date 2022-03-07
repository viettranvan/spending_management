import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/UI/bottom_modal_sheet/spending/bloc/spending_bloc.dart';
import 'package:spending_management/models/spending_model.dart';
import '../../widget/widget.dart';

class SpendingView extends StatelessWidget {
  const SpendingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var bloc = context.read<SpendingBloc>();
    Widget itemBuilder(BuildContext context, int index) {
        
      return BlocBuilder<SpendingBloc,SpendingState>(
        builder:(context, state) =>  GestureDetector(
          onTap: () {
            SpendingModel model = SpendingModel(
              iconPath: (state as SpendingInitial).lists[index].iconPath,
              title: state.lists[index].title,
              spendingType: 'spending',
            );
            Navigator.of(context).pop<SpendingModel>(model);
          },
          child: TypeItem(
            iconPath:
                'https://i.pinimg.com/originals/45/87/0c/45870c609864fdded4b8869276f57314.jpg',
            title: (state as SpendingInitial).lists[index].title ?? '',
          
            // _onCategoryView(context),
          ),
        ),
      );
    }

    return BlocBuilder<SpendingBloc, SpendingState>(
      builder: (context, state) => Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          SearchBar(
            hintText: 'Search elements',
            controller: context.read<SpendingBloc>().searchController,
            onChangeText: ()=>context.read<SpendingBloc>().add(SearchSpending())
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: GridView.builder(
                scrollDirection: Axis.vertical,
                itemCount: (state as SpendingInitial).lists.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 6 / 2,
                ),
                itemBuilder: itemBuilder),
          ),
        ],
      ),
    );
  }
}
