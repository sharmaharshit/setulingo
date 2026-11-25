import '../models/real_space.dart';
import 'spaces_part_1.dart';
import 'spaces_part_2.dart';

class RealSpacesData {
  RealSpacesData._();

  static const List<RealSpace> spaces = [
    ...realSpacesPart1,
    ...realSpacesPart2,
  ];

  static List<Scenario> get allScenarios =>
      spaces.expand((space) => space.scenarios).toList(growable: false);

  static RealSpace? findSpaceById(String id) {
    for (final space in spaces) {
      if (space.id == id) return space;
    }
    return null;
  }

  static Scenario? findScenarioById(String id) {
    for (final space in spaces) {
      for (final scenario in space.scenarios) {
        if (scenario.id == id) return scenario;
      }
    }
    return null;
  }

  /// Deterministically picks Today's 2-Minute Scenario based on the calendar day.
  static Scenario todaysTwoMinuteScenario([DateTime? now]) {
    final all = allScenarios;
    final date = now ?? DateTime.now();
    final dayOfYear = date.difference(DateTime(date.year, 1, 1)).inDays;
    return all[dayOfYear % all.length];
  }
}
