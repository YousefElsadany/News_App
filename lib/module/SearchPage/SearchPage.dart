import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/NewsApp/Cubit/cubit.dart';
import 'package:news_app/layout/NewsApp/Cubit/states.dart';
import 'package:news_app/shared/componants/componants.dart';


class SearchScreen extends StatelessWidget {
  var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: customTextFeild(
                  controller: SearchController,
                  inputType: TextInputType.text,
                  title: 'Search',
                  pIcon: Icons.search,
                  change: (value) {
                    NewsCubit.get(context).getSearch(value!);
                  },
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(child: articleBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
