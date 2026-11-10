
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas4/main.dart';

void main() {
  group('Pengujian Validasi Form Mahasiswa', () {
    test('Nama wajib diisi', () {
      expect(validasiNama(''), 'Nama wajib diisi');
    });

    test('Nama minimal 3 huruf', () {
      expect(validasiNama('AB'), 'Nama minimal 3 huruf');
    });

    test('Nama valid', () {
      expect(validasiNama('Sahri'), isNull);
    });

    test('NIM wajib diisi', () {
      expect(validasiNim(''), 'NIM wajib diisi');
    });

    test('NIM hanya boleh angka', () {
      expect(
        validasiNim('2023a01'),
        'NIM hanya boleh berisi angka',
      );
    });

    test('NIM minimal 7 digit', () {
      expect(validasiNim('12345'), 'NIM minimal 7 digit');
    });

    test('NIM valid', () {
      expect(validasiNim('2023001'), isNull);
    });

    test('Email tidak valid', () {
      expect(
        validasiEmail('rina@'),
        contains('Format email tidak valid'),
      );
    });

    test('Email valid', () {
      expect(validasiEmail('rina@kampus.ac.id'), isNull);
    });

    test('Semester harus angka', () {
      expect(
        validasiSemester('abc'),
        'Semester harus berupa angka',
      );
    });

    test('Semester harus antara 1 dan 14', () {
      expect(
        validasiSemester('15'),
        'Semester harus antara 1 dan 14',
      );
    });

    test('Semester valid', () {
      expect(validasiSemester('5'), isNull);
    });
  });

  group('Pengujian Tampilan Form', () {
    testWidgets('Dashboard menampilkan daftar mahasiswa',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('Dashboard Akademik'), findsOneWidget);
      expect(find.text('Daftar Mahasiswa'), findsOneWidget);
      expect(find.text('Rina Amelia'), findsOneWidget);
    });

    testWidgets('Form kosong menampilkan pesan galat',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Tambah'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Simpan'));
      await tester.pump();

      expect(find.text('Nama wajib diisi'), findsOneWidget);
      expect(find.text('NIM wajib diisi'), findsOneWidget);
      expect(find.text('Email wajib diisi'), findsOneWidget);
      expect(find.text('Semester wajib diisi'), findsOneWidget);
    });

    testWidgets('Data valid menampilkan pratinjau',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Tambah'));
      await tester.pumpAndSettle();

      final kolom = find.byType(TextFormField);

      await tester.enterText(kolom.at(0), 'Sahri Ramadani');
      await tester.enterText(kolom.at(1), '2023004');
      await tester.enterText(kolom.at(2), 'sahri@kampus.ac.id');
      await tester.enterText(kolom.at(3), '5');

      await tester.tap(find.text('Simpan'));
      await tester.pumpAndSettle();

expect(find.text('Sahri Ramadani'), findsNWidgets(2));
expect(find.text('2023004'), findsNWidgets(2));
expect(find.text('sahri@kampus.ac.id'), findsNWidgets(2));
expect(find.text('5'), findsNWidgets(2));
    });
  });
}
