class Todo {
  late String title;
  late String? date;
  late String description;

  Todo.init();

  Todo({required this.title, required this.description, this.date});
}