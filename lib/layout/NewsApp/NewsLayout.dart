import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/layout/NewsApp/Cubit/cubit.dart';
import 'package:news_app/layout/NewsApp/Cubit/states.dart';
import 'package:news_app/module/SearchPage/SearchPage.dart';
import 'package:news_app/shared/Cubit/cubit.dart';


class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.get(context).changeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
