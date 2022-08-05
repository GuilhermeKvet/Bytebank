import 'package:flutter_bloc/flutter_bloc.dart';

//Estado com uma unica string, poderia ser um Perfil completo.
class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);

  void change(String name) => emit(name);
}
