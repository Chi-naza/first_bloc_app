
import 'package:bloc/bloc.dart';
import 'package:first_bloc_app/bloc_signin_example/bloc/actions.dart';
import 'package:first_bloc_app/bloc_signin_example/bloc/app_state.dart';
import 'package:first_bloc_app/bloc_signin_example/login_api.dart';
import 'package:first_bloc_app/bloc_signin_example/models.dart';
import 'package:first_bloc_app/bloc_signin_example/notes_api.dart';

class AppBloc extends Bloc<AppActions, AppStates> {
  final LoginApiProtocol loginAPI;
  final NotesAPIprotocol notesAPI;

  // stating our initial AppState: through the super constructor
  AppBloc({required this.loginAPI, required this.notesAPI}): super(const AppStates.empty()){
    // FOR LOGIN ACTION (1st Action/Event We are Sending)
    on<LoginAction>((event, emit) async{
      // start loading
      emit(const AppStates(isLoading: true, loginError: null, loginHandler: null, fetchedNotes: null));

      // Log the user in
      final loginHandle = await loginAPI.login(email: event.email, password: event.password);
      emit(
        AppStates(
          isLoading: false, 
          loginError: loginHandle == null? LoginErrors.invalidHandle : null, 
          loginHandler: loginHandle, 
          fetchedNotes: null
        ),
      );

      // LOAD NOTES ACTION (2nd Event/Action We are sending)
      on<LoadNotesActions>((event, emit) async{
        // start loading again and retaining our login event.
        emit(AppStates(isLoading: true, loginError: null, loginHandler: state.loginHandler, fetchedNotes: null));

        // Get the login handle
        final loginHandle = state.loginHandler;

        if(loginHandle != const LoginHandler.loginMagic()){
          // invalid login handle
          emit(AppStates(isLoading: false, loginError: LoginErrors.invalidHandle, loginHandler: loginHandle, fetchedNotes: null));
          return;
        }

        // Having a valid login handle
        final notes = await notesAPI.getNotes(loginHandler: loginHandle!);
        emit(AppStates(isLoading: false, loginError: null, loginHandler: loginHandle, fetchedNotes: notes));
      });

    });
  } 
  

}


// NB: Events/Actions are INPUTS to the Bloc  && States are the OUTPUTS