
import 'package:flutter/material.dart';
import 'package:social/modules/on_boarding/on_boarding_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // Bloc.observer = MyBlocObserver();
  // DioHelper.init();
  // await CacheHelper.init();
  //
  // bool isDark = CacheHelper.getData(key: 'isDark');
  //
  // Widget widget;
  //
  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token');

  // if(onBoarding != null)
  // {
  //   if(token != null) widget = ShopLayout();
  //   else widget = ShopLoginScreen();
  // } else
  // {
  //   widget = OnBoardingScreen();
  // }

  // runApp(MyApp(
  //   isDark: isDark,
  //   startWidget: widget,
  // ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  // // constructor
  // // build
  // final bool isDark;
  // final Widget startWidget;
  //
  // MyApp({
  //   this.isDark,
  //   this.startWidget,
  // });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: lightTheme,
      // darkTheme: darkTheme,
      themeMode:ThemeMode.light,
      // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
      home: OnBoardingScreen(),
    );
    // return MultiBlocProvider(
    //   providers: [
    //
    //     BlocProvider(
    //       create: (BuildContext context) => AppCubit()
    //         ..changeAppMode(
    //           fromShared: isDark,
    //         ),
    //     ),
    //     BlocProvider(
    //       create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
    //     ),
    //   ],
    //   child: BlocConsumer<AppCubit, AppStates>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: lightTheme,
    //         darkTheme: darkTheme,
    //         themeMode:ThemeMode.light,
    //         // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
    //         home: startWidget,
    //       );
    //     },
    //   ),
    // );
  }
}