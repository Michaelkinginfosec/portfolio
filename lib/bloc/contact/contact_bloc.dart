import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/contact/contact_event.dart';
import 'package:portfolio/bloc/contact/contact_state.dart';
import 'package:portfolio/datasource/repository/respository.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final LoginRepository repository;
  ContactBloc(this.repository) : super(ContactInitial()) {
    on<ContactMeEvent>((event, emit) async {
      emit(ContactLoading());
      try {
        final result = await repository.sendMessage(event.contactModel);
        emit(ContactSuccess(result));
      } catch (e) {
        emit(ContactFailure(e.toString()));
      }
    });
  }
}
