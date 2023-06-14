
import 'package:equatable/equatable.dart';

class Task extends Equatable{
  final String id;
  final String title;
  final String description;
  final String date;
  bool isFavourite = false;
  bool? isDone;
  bool? isDeleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isFavourite = false,
    this.isDone,
    this.isDeleted}) {
    isDone = isFavourite ?? false;
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    bool? isFavourite,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: title ?? this.description,
      date: title ?? this.date,
      isFavourite: isFavourite ?? this.isFavourite,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap(){
    return {
      "id":id,
      "title":title,
      "description":description,
      "date":date,
      "isDone":isDone,
      "isFavourite":isFavourite,
      "isDeleted":isDeleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic>map){
    return Task(
      id: map["id"] ?? "empty",
      title: map["title"] ?? "empty",
      description: map["description"] ?? "empty",
      date: map["date"] ?? "empty",
      isFavourite: map["isFavourite"],
      isDone: map["isDone"],
      isDeleted: map["isDeleted"],
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    isFavourite,
    isDone,
    isDeleted,
  ];
}
