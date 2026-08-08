import 'package:cine_explore/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('affiche le catalogue CineExplore', (tester) async {
    await tester.pumpWidget(CineExploreApp());
    await tester.pumpAndSettle();

    expect(find.text('CineExplore'), findsOneWidget);
    expect(find.textContaining('film(s) trouve(s)'), findsOneWidget);
  });
}
