import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Components/News_item.dart';
import '../../Cubit/Cubit.dart';
import '../../Cubit/States.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var list = NewsCubit.get(context).Science;
          return ConditionalBuilder(
            condition: list.length > 0,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => NewsItem(article: list[index]),
              itemCount: 20,
              separatorBuilder: (context, index) {
                return Container(
                  color: Colors.grey[600],
                  height: 1,
                  width: double.infinity,
                );
              },
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
