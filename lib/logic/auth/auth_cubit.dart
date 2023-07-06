import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task/db/hive_helper.dart';
import 'package:task/db/hive_model/hive_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  register(
      {required name,
      required lastname,
      required gender,
      required nationality,
      required email,
      required mobile}) async {
    try {
      emit(AuthLoading());
      if (gender == null) {
        emit(const AuthLoadError(error: "Please select a gender !!"));
      } else if (nationality == null) {
        emit(const AuthLoadError(error: "Please select a nation !!"));
      } else {
        CredentialModel cred = CredentialModel(
            name: name,
            lastname: lastname,
            gender: gender,
            nation: nationality,
            email: email,
            mobile: mobile);

        await HiveHelpers().registerUser(credentialModel: cred);
        emit(AuthRegisterSucess(cred: cred));
      }
    } catch (e) {
      emit(AuthLoadError(error: e.toString()));
    }
  }


  login({required name,required mobile})async{
    try {
       emit(AuthLoading());
       var res =await HiveHelpers().loginUser(mobile: mobile, name: name);
       if (res) {
         var cred = HiveHelpers().getUser(mobile: mobile);
         emit(AuthLoginSucess(cred: cred));
       }else{
        emit(const AuthLoadError(error: "Please Enter the valid Credentials..."));
       }
    } catch (e) {
      emit(AuthLoadError(error: e.toString()));
    }
  }
}
