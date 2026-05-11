abstract class ContactEvent {}

class UpdateSubject extends ContactEvent {
  final String subject;
  UpdateSubject(this.subject);
}

class UpdateMessage extends ContactEvent {
  final String message;
  UpdateMessage(this.message);
}

class SendMessage extends ContactEvent {}
