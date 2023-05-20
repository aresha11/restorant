import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:untitled5/meals-model.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial());

  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Meals meals=Meals();

  List<Meals> data=[];

  List id=["LDG6jqkOi55Fqcxrb5Jm","fsNKzeq0NAuv429QUH62","lpgUpm7EElebrvc1E32N","m1qFtE7xf1YMp15Zw1Ef"];

  Map<String,dynamic> map={};


getMeals()async{
emit(GetDataLoadingState());
for(int i=0;i<=3;i++){
 await firebaseFirestore.collection("meals").doc("${id[i]}").get().then((value) {
    meals=Meals.fromMap((value.data())as Map<String ,dynamic>);
    data.add(meals);
    print(data[i].name);

    if(i==3){
      emit(GetDataSuccessState());
    }
  }).catchError((onError){
    emit(GetDataFailState());
    throw onError;
  });
}



}
}
