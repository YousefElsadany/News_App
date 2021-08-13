import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:news_app/layout/NewsApp/Cubit/cubit.dart';
import 'package:news_app/module/LoginPage/LoginView.dart';
import 'package:news_app/shared/Cubit/cubit.dart';
import 'package:news_app/shared/Cubit/states.dart';
import 'package:news_app/shared/network/local/CachHelper.dart';
import 'package:news_app/shared/network/remote/DioHelper.dart';


import 'shared/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  late bool? isDark = CacheHelper.getBool(key: 'isDark');
  // if (isDark != null) {
  //   runApp(MyApp(isDark));
  // }
  runApp(MyApp((isDark != null) ? isDark : false));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()..changeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return GetMaterialApp(
            theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                textTheme: TextTheme(
                  bodyText1:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                )),
            darkTheme: ThemeData(
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                primarySwatch: Colors.deepOrange,
                scaffoldBackgroundColor: Color(0xff1e272e),
                appBarTheme: AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xff1e272e),
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Color(0xff1e272e),
                  elevation: 0.0,
                  backwardsCompatibility: false,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Color(0xff1e272e),
                )),
            themeMode: AppCubit.get(context).isDarke
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
