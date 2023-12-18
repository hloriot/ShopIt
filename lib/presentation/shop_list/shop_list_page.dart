import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_it/domain/manager/permission_manager.dart';
import 'package:shop_it/domain/repository/city_repository.dart';
import 'package:shop_it/domain/repository/shop_repository.dart';
import 'package:shop_it/presentation/shop_list/shop_list_bloc.dart';
import 'package:shop_it/presentation/shop_list/shop_list_event.dart';
import 'package:shop_it/presentation/shop_list/shop_list_view.dart';

class ShopListPage extends StatelessWidget {
  const ShopListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopListBloc(
        permissionManager: context.read<PermissionManager>(),
        cityRepository: context.read<CityRepository>(),
        shopRepository: context.read<ShopRepository>(),
      )..add(ShopListStarted()),
      child: const ShopListView(),
    );
  }
}
