abstract class FormEvent {}

class SubmitForm extends FormEvent {
  final String name;
  final String email;

  SubmitForm({required this.name, required this.email});
}
