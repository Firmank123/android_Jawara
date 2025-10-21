import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jawara_pintar/screens/warga/section/tambah/warga_tambah.dart';

void main() {
  group('WargaTambah Form Validation Tests', () {
    testWidgets('Should show error when trying to proceed with empty required fields',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Verify we're on the first step
      expect(find.text('Data Pribadi'), findsOneWidget);

      // Find and tap the "Lanjut" button without filling any fields
      final lanjutButton = find.text('Lanjut');
      expect(lanjutButton, findsOneWidget);
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(
        find.text('Mohon lengkapi semua data yang diperlukan (Nama Lengkap, NIK, dan Jenis Kelamin)'),
        findsOneWidget,
      );

      // Verify we're still on the first step (not moved to second step)
      expect(find.text('Data Pribadi'), findsOneWidget);
    });

    testWidgets('Should show error when Nama Lengkap is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Fill NIK but leave Nama Lengkap empty
      final nikFields = find.byType(TextFormField);
      // NIK is the second TextFormField (after Nama Lengkap)
      await tester.enterText(nikFields.at(1), '1234567890123456');

      // Try to proceed
      final lanjutButton = find.text('Lanjut');
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(
        find.text('Mohon lengkapi semua data yang diperlukan (Nama Lengkap, NIK, dan Jenis Kelamin)'),
        findsOneWidget,
      );

      // Verify validation error for Nama Lengkap field
      expect(find.text('Nama tidak boleh kosong'), findsOneWidget);
    });

    testWidgets('Should show error when NIK is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Fill only Nama Lengkap
      final nameField = find.byType(TextFormField).first;
      await tester.enterText(nameField, 'John Doe');

      // Try to proceed
      final lanjutButton = find.text('Lanjut');
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(
        find.text('Mohon lengkapi semua data yang diperlukan (Nama Lengkap, NIK, dan Jenis Kelamin)'),
        findsOneWidget,
      );

      // Verify validation error for NIK field
      expect(find.text('NIK tidak boleh kosong'), findsOneWidget);
    });

    testWidgets('Should show error when NIK is not 16 digits',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Fill fields but with invalid NIK (less than 16 digits)
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'John Doe'); // Nama Lengkap
      await tester.enterText(textFields.at(1), '12345'); // NIK - Only 5 digits

      // Try to proceed
      final lanjutButton = find.text('Lanjut');
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(
        find.text('Mohon lengkapi semua data yang diperlukan (Nama Lengkap, NIK, dan Jenis Kelamin)'),
        findsOneWidget,
      );
    });

    testWidgets('Should show error when Jenis Kelamin is not selected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Fill Nama Lengkap and NIK but don't select Jenis Kelamin
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'John Doe'); // Nama Lengkap
      await tester.enterText(textFields.at(1), '1234567890123456'); // NIK

      // Try to proceed
      final lanjutButton = find.text('Lanjut');
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(
        find.text('Mohon lengkapi semua data yang diperlukan (Nama Lengkap, NIK, dan Jenis Kelamin)'),
        findsOneWidget,
      );

      // Verify validation error for Jenis Kelamin field
      expect(find.text('Jenis kelamin harus dipilih'), findsOneWidget);
    });

    testWidgets('Should proceed to step 2 when all required fields are filled',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Fill all required fields
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'John Doe'); // Nama Lengkap
      await tester.enterText(textFields.at(1), '1234567890123456'); // NIK

      // Select Jenis Kelamin
      final genderDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(genderDropdown);
      await tester.pumpAndSettle();
      
      // Select 'Laki-laki' from dropdown
      final lakiLaki = find.text('Laki-laki').last;
      await tester.tap(lakiLaki);
      await tester.pumpAndSettle();

      // Try to proceed
      final lanjutButton = find.text('Lanjut');
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify we've moved to the second step
      expect(find.text('Data Tambahan'), findsOneWidget);
      
      // Verify the button text changed from "Lanjut" to "Simpan"
      expect(find.text('Simpan'), findsOneWidget);
      expect(find.text('Lanjut'), findsNothing);
    });

    testWidgets('Should be able to go back from step 2 to step 1',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WargaTambah(),
        ),
      );

      // Fill all required fields and proceed to step 2
      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'John Doe'); // Nama Lengkap
      await tester.enterText(textFields.at(1), '1234567890123456'); // NIK

      // Select Jenis Kelamin
      final genderDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(genderDropdown);
      await tester.pumpAndSettle();
      
      final lakiLaki = find.text('Laki-laki').last;
      await tester.tap(lakiLaki);
      await tester.pumpAndSettle();

      // Proceed to step 2
      final lanjutButton = find.text('Lanjut');
      await tester.tap(lanjutButton);
      await tester.pumpAndSettle();

      // Verify we're on step 2
      expect(find.text('Data Tambahan'), findsOneWidget);

      // Tap the "Kembali" button
      final kembaliButton = find.text('Kembali');
      await tester.tap(kembaliButton);
      await tester.pumpAndSettle();

      // Verify we're back on step 1
      expect(find.text('Data Pribadi'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);
    });
  });
}
