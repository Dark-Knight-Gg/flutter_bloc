import 'package:flutter_bloc/flutter_bloc.dart';

class PassWordVisibleCubit extends Cubit<bool>{
  PassWordVisibleCubit():super(true);
  void onClickIconEye()=> emit(!state);
}