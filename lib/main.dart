import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/firebase_options.dart';
import 'package:social/layout/cubit/cubit.dart';
import 'package:social/layout/social_layout_screen.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/cubit.dart';
import 'package:social/shared/cubit/states.dart';
import 'package:social/shared/network/remote/bloc_observer.dart';

import 'shared/network/local/CacheHelper.dart';
import 'shared/styles/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();

  await CacheHelper.init();

  // bool? isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;


  uId = CacheHelper.getData(key: 'uId');


  if(uId != null)
  {
    widget = SocialLayout();
  } else
  {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    // isDark: isDark,
    startWidget: widget,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget
{
  // constructor
  // build
  // final bool isDark;
  final Widget startWidget;

  MyApp({
    // required this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (BuildContext context) => AppCubit()
            // ..changeAppMode(
            //   fromShared: isDark,
            // ),
        ),

        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            // AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

// ./gradlew signingReport