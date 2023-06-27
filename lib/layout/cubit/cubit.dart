import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/cubit/states.dart';
import 'package:social/models/social_user_model.dart';
import 'package:social/shared/components/constants.dart';


class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
      print(uId);
      print("d9**9****");
      print(value.data());
      model = SocialUserModel.fromJson(value.data() ?? {});
      // if (value.data() != null) {
      //   model = SocialUserModel.fromJson(value.data()!);
      // }

      emit(SocialGetUserSuccessState());
    })
        .catchError((error) {
      print("S1***"+error.toString());
      emit(SocialGetUserErrorState(error.toString()));

    });
  }
}