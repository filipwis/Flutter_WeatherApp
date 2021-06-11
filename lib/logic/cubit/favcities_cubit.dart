import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favcities_state.dart';

class FavcitiesCubit extends Cubit<FavcitiesState> {
  FavcitiesCubit() : super(FavcitiesInitial());
}
