abstract class BlocEvent {}

class SubmitForm extends BlocEvent {
  final String name;
  final String email;

  SubmitForm({required this.name, required this.email});
}

class RetrySubmit extends BlocEvent {}
