class PersonsFetchedAction {
  final List<String> persons;
  PersonsFetchedAction(this.persons);
}

class FetchErrorAction {
  final String error;
  FetchErrorAction(this.error);
}
