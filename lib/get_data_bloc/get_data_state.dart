part of 'get_data_cubit.dart';

@immutable
abstract class GetDataState {}

class GetDataInitial extends GetDataState {}
class GetDataLoadingState extends GetDataState {}
class GetDataSuccessState extends GetDataState {}
class GetDataFailState extends GetDataState {}
