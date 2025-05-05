import 'package:portfolio/datasource/models/contact_model.dart';

abstract class ContactEvent {}

class ContactMeEvent extends ContactEvent {
  final ContactModel contactModel;
  ContactMeEvent(this.contactModel);
}
