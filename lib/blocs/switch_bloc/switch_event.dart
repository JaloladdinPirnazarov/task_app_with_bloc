part of 'switch_bloc.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();

  List<Object> get props => [];
}

class SwitchOnEvent extends SwitchEvent {
  final bool switchValue;
  const SwitchOnEvent({
    required this.switchValue,
  });
}

class SwitchOffEvent extends SwitchEvent {
  final bool switchValue;

  const SwitchOffEvent({
    required this.switchValue,
  });
}
