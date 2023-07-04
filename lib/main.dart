import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp_flutter/CacheHelper.dart';
import 'package:newsapp_flutter/doi_helper.dart';

import 'Cubit/Cubit.dart';
import 'Cubit/States.dart';
import 'ThemeData.dart';
import 'bloc_observer.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initial();
  isDark = await CacheHelper.getBoolean(key: "isDark") ?? false;
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..changeAppTheme(frontMode: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: isDark ? lightMode : darkMode,
                home: Scaffold(
                  appBar: AppBar(
                    actions: [
                      IconButton(
                          onPressed: () {
                            NewsCubit.get(context).changeAppTheme();
                          },
                          icon: const Icon(Icons.brightness_4_rounded))
                    ],
                    title: const Text("NewsApp"),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: NewsCubit.get(context).currentIndex,
                    items: NewsCubit.get(context).buttomItems,
                    onTap: (value) {
                      NewsCubit.get(context).changeButtomNavBar(value);
                    },
                  ),
                  body: NewsCubit.get(context)
                      .screens[NewsCubit.get(context).currentIndex],
                ),
              )),
    );
  }
}
