import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pummel_the_fish/data/models/pet.dart';
import 'package:pummel_the_fish/data/repositories/firestore_pet_repository.dart';
import 'package:pummel_the_fish/logic/cubit/manage_pets_cubit.dart';

class MockFirestorePetRepository extends Mock
    implements FirestorePetRepository {}

void main() {
  late ManagePetsCubit cubit;
  late MockFirestorePetRepository mockFirestorePetRepository;
  late List<Pet> tPetList;
  setUp(() {
    mockFirestorePetRepository = MockFirestorePetRepository();
    cubit = ManagePetsCubit(mockFirestorePetRepository);

    tPetList = [
      const Pet(
        id: "1",
        name: "Kira",
        species: Species.dog,
        age: 10,
        weight: 250.0,
        height: 20.0,
      ),
      const Pet(
        id: "2",
        name: "Space",
        species: Species.fish,
        age: 3,
        weight: 10.0,
        height: 10.0,
      ),
    ];
  });
  group('getAllPets()', () {
    blocTest<ManagePetsCubit, ManagePetsState>(
      "emits [ManagePetsStatus.loading, ManagePetsStatus.success] when getAllPets() is called successfully.",
      setUp: () {
        when(() => mockFirestorePetRepository.getAllPets())
            .thenAnswer((_) async => tPetList);
      },
      build: () => cubit,
      act: (cubit) => cubit.getAllPets(),
      expect: () => <ManagePetsState>[
        const ManagePetsState(
          status: ManagePetsStatus.loading,
        ),
        ManagePetsState(
          status: ManagePetsStatus.success,
          pets: tPetList,
        ),
      ],
      verify: (_) =>
          verify(() => mockFirestorePetRepository.getAllPets()).called(1),
    );
  });
}
