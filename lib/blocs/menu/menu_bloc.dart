import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm_app/controllers/menu_controller.dart';
import 'package:crm_app/utils/constants/collections.dart';
import '../../controllers/FormController.dart';
import '../../sembast/sembast.dart';
import 'menu_events.dart';
import 'menu_states.dart';
import 'package:path_provider/path_provider.dart';

class MenuBloc extends Bloc<MenuEvents, MenuStates> {
  MenuBloc() : super(MenuStates()) {
    on<MenuEvent>((event, emit) => _mapMenuToState(event, emit));
  }

  Future<void> _mapMenuToState(
      MenuEvent event, Emitter<MenuStates> emit) async {
    emit(MenuItemsLoading(isLoading: true));
    try {
      emit(MenuItems(resources: [], types: []));
      emit(MenuItemsSuccess(resources: [], types: []));
    } catch (e) {
      print("====Error In Blocs=============");
      print(e);
      print("======Error=================");
      emit(MenuItemsFailure(errorMessage: e.toString()));
    }
  }
}
