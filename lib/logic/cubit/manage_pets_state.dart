part of 'manage_pets_cubit.dart';

enum ManagePetsStatus { initial, loading, success, error }

class ManagePetsState extends Equatable {
  final ManagePetsStatus status;
  final List<Pet> pets;
  final String? errorMessage;

  const ManagePetsState({
    this.status = ManagePetsStatus.initial,
    this.pets = const [],
    this.errorMessage,
  });

  ManagePetsState copyWith(
      {ManagePetsStatus? status, List<Pet>? pets, String? errorMessage}) {
    return ManagePetsState(
        status: status ?? this.status,
        pets: pets ?? this.pets,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [
        status,
        pets,
        errorMessage,
      ];
}
