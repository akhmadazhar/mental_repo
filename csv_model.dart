import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class CSVData {
  final String pasien;
  final String kesedihan;
  final String euforia;
  final String lelah;
  final String gangguanTidur;
  final String ayunanMood;
  final String bunuhDiri;
  final String anoreksia;
  final String rasaHormat;
  final String memintaPenjelasan;
  final String responAgresif;
  final String acuhBeranjak;
  final String gugup;
  final String mengakuiKesalahan;
  final String berpikirBerlebihan;
  final int aktivitasSeksual;
  final int konsentrasi;
  final int optimis;
  final String diagnosa;

  CSVData({
    required this.pasien,
    required this.kesedihan,
    required this.euforia,
    required this.lelah,
    required this.gangguanTidur,
    required this.ayunanMood,
    required this.bunuhDiri,
    required this.anoreksia,
    required this.rasaHormat,
    required this.memintaPenjelasan,
    required this.responAgresif,
    required this.acuhBeranjak,
    required this.gugup,
    required this.mengakuiKesalahan,
    required this.berpikirBerlebihan,
    required this.aktivitasSeksual,
    required this.konsentrasi,
    required this.optimis,
    required this.diagnosa,
  });

  factory CSVData.fromList(List<dynamic> row) {
    return CSVData(
      pasien: row[0] as String,
      kesedihan: row[1] as String,
      euforia: row[2] as String,
      lelah: row[3] as String,
      gangguanTidur: row[4] as String,
      ayunanMood: row[5] as String,
      bunuhDiri: row[6] as String,
      anoreksia: row[7] as String,
      rasaHormat: row[8] as String,
      memintaPenjelasan: row[9] as String,
      responAgresif: row[10] as String,
      acuhBeranjak: row[11] as String,
      gugup: row[12] as String,
      mengakuiKesalahan: row[13] as String,
      berpikirBerlebihan: row[14] as String,
      aktivitasSeksual: row[15] as int,
      konsentrasi: row[16] as int,
      optimis: row[17] as int,
      diagnosa: row[18] as String,
    );
  }
}

Future<List<CSVData>> loadCSVData() async {
  final csvString = await rootBundle.loadString('assets/ds_mental.csv');
  List<List<dynamic>> csvList = const CsvToListConverter().convert(csvString);

  // Skip header row
  csvList = csvList.sublist(1);

  List<CSVData> csvDataList =
      csvList.map((row) => CSVData.fromList(row)).toList();
  return csvDataList;
}
