import 'package:flutter_test/flutter_test.dart';
import 'package:schematic_diagrams/schematic_diagrams.dart';
import 'package:schematic_diagrams/src/internal/models/models.dart';
import 'package:schematic_diagrams/src/internal/rendering/linking/standard/standard_section_area.dart';

void main() {
  group('addLine', () {
    test('only adds straight lines', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = JumpLine(
        from: const Position(0, 10),
        to: const Position(20, 10),
        overlapHeight: 10,
      );

      area.addLine(line);

      expect(area.lines.isEmpty, isTrue);
    });

    test('replaces line if IDs are a match', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = StraightLine(
        from: const Position(0, 10),
        to: const Position(20, 10),
      );

      area.addLine(line);

      final lineCopy = line.copyWith(from: const Position(10, 20));

      area.addLine(lineCopy);

      expect(area.lines.length, 1);
      expect(area.lines.first.from, const Position(10, 20));
    });

    test(
      'adds a line to the area if IDs do not match and is straight line',
      () {
        final area = StandardSectionArea(
          from: const Position(0, 0),
          to: const Position(100, 100),
        );

        final line1 = StraightLine(
          from: const Position(0, 10),
          to: const Position(20, 10),
        );

        area.addLine(line1);

        final line2 = StraightLine(
          from: const Position(0, 10),
          to: const Position(20, 10),
        );

        area.addLine(line2);

        expect(area.lines.length, 2);
      },
    );
  });

  group('shouldContainLine', () {
    test('non-straight line returns false', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = JumpLine(
        from: const Position(0, 10),
        to: const Position(20, 10),
        overlapHeight: 10,
      );

      expect(area.shouldContainLine(line), isFalse);
    });

    test('returns false if area should not contain line', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = StraightLine(
        from: const Position(200, 200),
        to: const Position(300, 200),
      );

      expect(area.shouldContainLine(line), isFalse);
    });

    test('returns true if area should contain horizontal line', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = StraightLine(
        from: const Position(40, 40),
        to: const Position(200, 40),
      );

      expect(area.shouldContainLine(line), isTrue);
    });

    test('returns true if area should contain vertical line', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = StraightLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
      );

      expect(area.shouldContainLine(line), isTrue);
    });
  });

  group('lineIntersectsAt', () {
    test('returns empty list if non-straight line', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = JumpLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
        overlapHeight: 10,
      );

      expect(area.lineIntersectsAt(line).isEmpty, isTrue);
    });

    test('returns empty list if no intersects found', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line1 = StraightLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
      );

      final line2 = StraightLine(
        from: const Position(50, 50),
        to: const Position(50, 200),
      );

      area.addLine(line1);

      expect(area.lineIntersectsAt(line2).isEmpty, isTrue);
    });

    test('returns intersection points if intersects found', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line1 = StraightLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
      );

      final line2 = StraightLine(
        from: const Position(20, 60),
        to: const Position(100, 60),
      );

      area.addLine(line1);

      expect(area.lineIntersectsAt(line2).length, 1);
    });
  });

  group('linesCoincideWith', () {
    test('returns empty set if non-straight line', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line = JumpLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
        overlapHeight: 10,
      );

      expect(area.linesCoincideWith(line).isEmpty, isTrue);
    });

    test('returns empty line set if no coincidences found', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line1 = StraightLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
      );

      final line2 = StraightLine(
        from: const Position(50, 50),
        to: const Position(50, 200),
      );

      area.addLine(line1);

      expect(area.linesCoincideWith(line2).isEmpty, isTrue);
    });

    test('returns line set if coincidences found', () {
      final area = StandardSectionArea(
        from: const Position(0, 0),
        to: const Position(100, 100),
      );

      final line1 = StraightLine(
        from: const Position(40, 40),
        to: const Position(40, 200),
      );

      final line2 = StraightLine(
        from: const Position(40, 20),
        to: const Position(40, 60),
      );

      area.addLine(line1);

      expect(area.linesCoincideWith(line2).length, 1);
    });
  });
}
