import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/domain/model/city.dart';
import 'package:shop_it/domain/model/day.dart';
import 'package:shop_it/domain/model/shop.dart';
import 'package:shop_it/presentation/shop_list/shop_list_bloc.dart';
import 'package:shop_it/presentation/shop_list/shop_list_event.dart';
import 'package:shop_it/presentation/shop_list/shop_list_page.dart';
import 'package:shop_it/presentation/shop_list/shop_list_state.dart';

class ShopListView extends StatelessWidget {
  const ShopListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopListBloc, ShopListState>(
      //listenWhen: (previousState, state) => previousState != state,
      listener: (context, state) {
        switch (state.runtimeType) {
          case ShopListStateFinished:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ShopListPage(),
              ),
            );
        }
      },
      child: BlocBuilder<ShopListBloc, ShopListState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context, state),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    "Le plus proche".toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Expanded(child: _list(context, state)),
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, ShopListState state) {
    final List<City> suggestions;
    if (state is ShopListStateList) {
      suggestions = state.suggestions;
    } else {
      suggestions = [];
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Je recherche mon magasin :",
              style: TextStyle(
                fontSize: 23,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 10),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return suggestions
                    .map((city) => "${city.zipcode} - ${city.name}");
              },
              fieldViewBuilder: _autoCompleteTextField,
              onSelected: (String selection) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _autoCompleteTextField(
    BuildContext context,
    TextEditingController textEditingController,
    FocusNode focusNode,
    VoidCallback onFieldSubmitted,
  ) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      onSubmitted: (String value) {
        onFieldSubmitted();
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Ex : 59000, Lille',
      ),
      onChanged: (text) {
        context.read<ShopListBloc>().add(ShopListOnQueryChanged(query: text));
      },
    );
  }

  Widget _list(BuildContext context, ShopListState state) {
    final List<Shop> shops;
    if (state is ShopListStateList) {
      shops = state.shops;
    } else {
      shops = [];
    }

    return ListView.builder(
      itemCount: shops.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            _shop(context, shops[index]),
            const Divider(),
          ],
        );
      },
    );
  }

  Widget _shop(BuildContext context, Shop shop) {
    return GestureDetector(
      child: ListTile(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return _shopDetails(context, shop);
            },
          );
        },
        title: Text(shop.name),
        subtitle: Text(shop.address),
      ),
    );
  }

  Widget _shopDetails(BuildContext context, Shop shop) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Text(shop.name, style: const TextStyle(fontSize: 22)),
                Container(
                  width: 100,
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 10),
                Text(shop.address),
                const SizedBox(height: 10),
                _phoneNumber(context, shop),
              ],
            ),
          ),
          const Divider(),
          const Text(
            "Horaires d'ouverture",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shop.openingHours.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Text(_dayToString(shop.openingHours[index].day)),
                      const Spacer(),
                      Text(shop.openingHours[index].hours),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _phoneNumber(BuildContext context, Shop shop) {
    final phoneNumber = shop.phoneNumber;
    if (phoneNumber == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.phone, color: Theme.of(context).colorScheme.primary),
        Text(
          phoneNumber,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String _dayToString(Day day) {
    switch (day) {
      case Day.monday:
        return "Lundi";
      case Day.tuesday:
        return "Mardi";
      case Day.wednesday:
        return "Mercredi";
      case Day.thursday:
        return "Jeudi";
      case Day.friday:
        return "Vendredi";
      case Day.saturday:
        return "Samedi";
      case Day.sunday:
        return "Dimanche";
    }
  }
}
