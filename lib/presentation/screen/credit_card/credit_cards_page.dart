import 'package:card_wallet/domain/models/display_card_data/Result.dart';
import 'package:card_wallet/presentation/cubits/display_cards/displayCardsCubitState.dart';
import 'package:card_wallet/presentation/screen/credit_card/creditCardWidget.dart';
import 'package:card_wallet/presentation/screen/credit_card/input_form/credit_card_input_format_form.dart';
import 'package:card_wallet/utils/extensions/scroll_contrainer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/models/display_card_data/CardData.dart';
import '../../cubits/display_cards/displayCardsCubit.dart';

class CreditCardsPage extends HookWidget {
  final int currentPage = 1;

  const CreditCardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final displayCardsCubit = BlocProvider.of<DisplayCardsCubit>(context);
    final scrollController = useScrollController();
    useEffect(() {
      scrollController.onScrollEndsListener(() {
        displayCardsCubit.getCards();
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Credit Cards',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<DisplayCardsCubit,DisplayCardsCubitState>(
          builder: (_, state) {
            switch (state.runtimeType) {
              case DisplayCardsLoading:
                return const Center(child: CircularProgressIndicator());
              case DisplayCardsException:
                return const Center(child: Icon(Icons.refresh));
              case DisplayCardsSuccess:
                return _buildCards(
                  scrollController,
                  state.cards,
                  state.noMoreData,
                );
              default:
                return const SizedBox();
            }
          }),
    );

  }

  Widget _buildCards(
      ScrollController scrollController,
      List<Result> cards, bool noMoreData,
      ){
    return CustomScrollView(controller: scrollController, slivers: [
      SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) => CreditCardWidget(cards),
            childCount: cards.length,
          )),
       if (!noMoreData)
         const SliverToBoxAdapter(
           child: Padding(
             padding: EdgeInsets.only(top: 14, bottom: 32),
             child: CupertinoActivityIndicator(),
           ),
         )
    ]);

  }


}



