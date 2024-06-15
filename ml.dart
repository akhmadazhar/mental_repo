import 'dart:async' show Future;
import 'package:flutter/material.dart';
import 'package:mainmenu/csv/csv_model.dart';
import 'package:mainmenu/view/home.dart';
import 'package:mainmenu/view/riwayat.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:mainmenu/view/widget/widget.dart';

class ML extends StatefulWidget {
  const ML({super.key});

  @override
  State<ML> createState() => _MLState();
}

class _MLState extends State<ML> {
  final historyController = TextEditingController();

  // Menyimpan nilai Dropdown
  String? _valKesedihan;
  String? _valEuforia;
  String? _valLelah;
  String? _valGangguanTidur;
  String? _valAyunanMood;
  String? _valBunuhDiri;
  String? _valAnoreksia;
  String? _valRasaHormat;
  String? _valMemintaPenjelasan;
  String? _valResponAgresif;
  String? _valAcuhBeranjak;
  String? _valGugup;
  String? _valMengakuiKesalahan;
  String? _valBerpikirBerlebihan;
  String? _valAktivitasSeksual;
  String? _valKonsentrasi;
  String? _valOptimis;

  // Definisi List
  List _listKesedihan = ["Sering", "Biasanya", "Terkadang", "Jarang"];
  List _listEuforia = ["Sering", "Biasanya", "Terkadang", "Jarang"];
  List _listLelah = ["Sering", "Biasanya", "Terkadang", "Jarang"];
  List _listGangguanTidur = ["Sering", "Biasanya", "Terkadang", "Jarang"];
  List _listAyunanMood = ["Ya", "Tidak"];
  List _listBunuhDiri = ["Ya", "Tidak"];
  List _listAnoreksia = ["Ya", "Tidak"];
  List _listRasaHormat = ["Ya", "Tidak"];
  List _listMemintaPenjelasan = ["Ya", "Tidak"];
  List _listResponAgresif = ["Ya", "Tidak"];
  List _listAcuhBeranjak = ["Ya", "Tidak"];
  List _listGugup = ["Ya", "Tidak"];
  List _listMengakuiKesalahan = ["Ya", "Tidak"];
  List _listBerpikirBerlebihan = ["Ya", "Tidak"];
  List _listAktivitasSeksual = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];
  List _listKonsentrasi = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  List _listOptimis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];

  // Deklarasi List ke dalam CSV Data []
  late TextEditingController _kesedihanController;
  late TextEditingController _euforiaController;
  late TextEditingController _lelahController;
  late TextEditingController _gangguanTidurController;
  late TextEditingController _ayunanMoodController;
  late TextEditingController _bunuhDiriController;
  late TextEditingController _anoreksiaController;
  late TextEditingController _rasaHormatController;
  late TextEditingController _memintaPenjelasanController;
  late TextEditingController _responAgresifController;
  late TextEditingController _acuhBeranjakController;
  late TextEditingController _gugupController;
  late TextEditingController _mengakuiKesalahanController;
  late TextEditingController _berpikirBerlebihanController;
  late TextEditingController _aktivitasSeksualController;
  late TextEditingController _konsentrasiController;
  late TextEditingController _optimisController;

  List<CSVData> csvDataList = [];
  int classData = 120; //Definisi Jumlah Data
  int classNormal = 30; //Definisi Jumlah Kategori Normal
  int classDepresi = 31; //Definisi Jumlah Kategori Depresi
  int classBT1 = 28; //Definisi Jumlah Kategori Bipolar Tipe - 1
  int classBT2 = 31; //Definisi Jumlah Kategori Bipolar Tipe - 2

  // Deklarasi variabel untuk kategori Normal
  num? hitungKesedihanNormal;
  num? hitungEuforiaNormal;
  num? hitungLelahNormal;
  num? hitungGangguanTidurNormal;
  num? hitungAyunanMoodNormal;
  num? hitungBunuhDiriNormal;
  num? hitungAnoreksiaNormal;
  num? hitungRasaHormatNormal;
  num? hitungMemintaPenjelasanNormal;
  num? hitungResponAgresifNormal;
  num? hitungAcuhBeranjakNormal;
  num? hitungGugupNormal;
  num? hitungMengakuiKesalahanNormal;
  num? hitungBerpikirBerlebihanNormal;
  num? hitungAktivitasSeksualNormal;
  num? hitungKonsentrasiNormal;
  num? hitungOptimisNormal;
  num? hitungAkhirNormal;

  // Deklarasi variabel untuk kategori Depresi
  num? hitungKesedihanDepresi;
  num? hitungEuforiaDepresi;
  num? hitungLelahDepresi;
  num? hitungGangguanTidurDepresi;
  num? hitungAyunanMoodDepresi;
  num? hitungBunuhDiriDepresi;
  num? hitungAnoreksiaDepresi;
  num? hitungRasaHormatDepresi;
  num? hitungMemintaPenjelasanDepresi;
  num? hitungResponAgresifDepresi;
  num? hitungAcuhBeranjakDepresi;
  num? hitungGugupDepresi;
  num? hitungMengakuiKesalahanDepresi;
  num? hitungBerpikirBerlebihanDepresi;
  num? hitungAktivitasSeksualDepresi;
  num? hitungKonsentrasiDepresi;
  num? hitungOptimisDepresi;
  num? hitungAkhirDepresi;

  // Deklarasi variabel untuk kategori Bipolar Tipe - 1
  num? hitungKesedihanBT1;
  num? hitungEuforiaBT1;
  num? hitungLelahBT1;
  num? hitungGangguanTidurBT1;
  num? hitungAyunanMoodBT1;
  num? hitungBunuhDiriBT1;
  num? hitungAnoreksiaBT1;
  num? hitungRasaHormatBT1;
  num? hitungMemintaPenjelasanBT1;
  num? hitungResponAgresifBT1;
  num? hitungAcuhBeranjakBT1;
  num? hitungGugupBT1;
  num? hitungMengakuiKesalahanBT1;
  num? hitungBerpikirBerlebihanBT1;
  num? hitungAktivitasSeksualBT1;
  num? hitungKonsentrasiBT1;
  num? hitungOptimisBT1;
  num? hitungAkhirBT1;

  // Deklarasi variabel untuk kategori Bipolar Tipe - 2
  num? hitungKesedihanBT2;
  num? hitungEuforiaBT2;
  num? hitungLelahBT2;
  num? hitungGangguanTidurBT2;
  num? hitungAyunanMoodBT2;
  num? hitungBunuhDiriBT2;
  num? hitungAnoreksiaBT2;
  num? hitungRasaHormatBT2;
  num? hitungMemintaPenjelasanBT2;
  num? hitungResponAgresifBT2;
  num? hitungAcuhBeranjakBT2;
  num? hitungGugupBT2;
  num? hitungMengakuiKesalahanBT2;
  num? hitungBerpikirBerlebihanBT2;
  num? hitungAktivitasSeksualBT2;
  num? hitungKonsentrasiBT2;
  num? hitungOptimisBT2;
  num? hitungAkhirBT2;

//
  @override
  void initState() {
    super.initState();
    loadData();
    _kesedihanController = TextEditingController();
    _euforiaController = TextEditingController();
    _lelahController = TextEditingController();
    _gangguanTidurController = TextEditingController();
    _ayunanMoodController = TextEditingController();
    _bunuhDiriController = TextEditingController();
    _anoreksiaController = TextEditingController();
    _rasaHormatController = TextEditingController();
    _memintaPenjelasanController = TextEditingController();
    _responAgresifController = TextEditingController();
    _acuhBeranjakController = TextEditingController();
    _gugupController = TextEditingController();
    _mengakuiKesalahanController = TextEditingController();
    _berpikirBerlebihanController = TextEditingController();
    _aktivitasSeksualController = TextEditingController();
    _konsentrasiController = TextEditingController();
    _optimisController = TextEditingController();
  }

  Future<void> loadData() async {
    csvDataList = await loadCSVData();
  }

  @override
  void dispose() {
    // super.dispose();
    _kesedihanController.dispose();
    _euforiaController.dispose();
    _lelahController.dispose();
    _gangguanTidurController.dispose();
    _ayunanMoodController.dispose();
    _bunuhDiriController.dispose();
    _anoreksiaController.dispose();
    _rasaHormatController.dispose();
    _memintaPenjelasanController.dispose();
    _responAgresifController.dispose();
    _acuhBeranjakController.dispose();
    _gugupController.dispose();
    _mengakuiKesalahanController.dispose();
    _berpikirBerlebihanController.dispose();
    _aktivitasSeksualController.dispose();
    _konsentrasiController.dispose();
    _optimisController.dispose();
  }

  void hitungPrediksi() {
    bool isFormAnswered = true; // Penanda apakah semua pertanyaan telah dijawab

    // Periksa apakah semua pertanyaan telah dijawab
    if (_kesedihanController.text.isEmpty ||
        _euforiaController.text.isEmpty ||
        _lelahController.text.isEmpty ||
        _gangguanTidurController.text.isEmpty ||
        _ayunanMoodController.text.isEmpty ||
        _bunuhDiriController.text.isEmpty ||
        _anoreksiaController.text.isEmpty ||
        _rasaHormatController.text.isEmpty ||
        _memintaPenjelasanController.text.isEmpty ||
        _responAgresifController.text.isEmpty ||
        _acuhBeranjakController.text.isEmpty ||
        _gugupController.text.isEmpty ||
        _mengakuiKesalahanController.text.isEmpty ||
        _berpikirBerlebihanController.text.isEmpty ||
        _aktivitasSeksualController.text.isEmpty ||
        _konsentrasiController.text.isEmpty ||
        _optimisController.text.isEmpty) {
      isFormAnswered = false;
      print("Silahkan Jawab Semua Pertanyaan");
    } else {
      isFormAnswered = true;
    }

    // PROSES PERHITUNGAN MACHINE LEARNING NAIVE BAYa
    // Hitung Kesedihan
    // Pilihan Sering
    if (_kesedihanController.text == 'Sering') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat kesedihan yang sering di dalam dataset
      int jumlahKesedihanNormal = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Sering" && element.diagnosa == "Normal",
          )
          .length;
      print(
          'Banyaknya Orang yang Kesedihannya Sering Diagnosa Normal = $jumlahKesedihanNormal');
      //Digunakan Untuk Mencari pasien depresi dengan tingkat kesedihan yang sering di dalam dataset
      int jumlahKesedihanDepresi = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Sering" && element.diagnosa == "Depresi",
          )
          .length;
      print(
          'Banyaknya Orang yang Kesedihannya Sering Diagnosa Depresi = $jumlahKesedihanDepresi');
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat kesedihan yang sering di dalam dataset
      int jumlahKesedihanBT1 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Sering" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      print(
          'Banyaknya Orang yang Kesedihannya Sering Diagnosa Bipolar Tipe-1 = $jumlahKesedihanBT1');
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat kesedihan yang sering di dalam dataset
      int jumlahKesedihanBT2 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Sering" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;
      print(
          'Banyaknya Orang yang Kesedihannya Sering Diagnosa Bipolar Tipe-2 = $jumlahKesedihanBT2');

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Kesedihan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahKesedihanNormal == 0) {
        hitungKesedihanNormal =
            (jumlahKesedihanNormal + 1) / (classNormal + 17);
      } else {
        hitungKesedihanNormal = jumlahKesedihanNormal / classNormal;
      }
      // Pengecekan Kesedihan Depresi
      if (jumlahKesedihanDepresi == 0) {
        hitungKesedihanDepresi =
            (jumlahKesedihanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungKesedihanDepresi = jumlahKesedihanDepresi / classDepresi;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 1
      if (jumlahKesedihanBT1 == 0) {
        hitungKesedihanBT1 = (jumlahKesedihanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungKesedihanBT1 = jumlahKesedihanBT1 / classBT1;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 2
      if (jumlahKesedihanBT2 == 0) {
        hitungKesedihanBT2 = (jumlahKesedihanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungKesedihanBT2 = jumlahKesedihanBT2 / classBT2;
      }

      print("ini hasil Kesedihan normal yang sering : $hitungKesedihanNormal");
      print(
          "ini hasil Kesedihan depresi yang sering : $hitungKesedihanDepresi");
      print(
          "ini hasil Kesedihan bipolar tipe - 1 yang sering : $hitungKesedihanBT1");
      print(
          "ini hasil Kesedihan bipolar tipe - 2 yang sering : $hitungKesedihanBT2");

      // Pilihan Biasanya
    } else if (_kesedihanController.text == 'Biasanya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat kesedihan yang Biasanya di dalam dataset
      int jumlahKesedihanNormal = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Biasanya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat kesedihan yang Biasanya di dalam dataset
      int jumlahKesedihanDepresi = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Biasanya" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat kesedihan yang Biasanya di dalam dataset
      int jumlahKesedihanBT1 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat kesedihan yang Biasanya di dalam dataset
      int jumlahKesedihanBT2 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Kesedihan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahKesedihanNormal == 0) {
        hitungKesedihanNormal =
            (jumlahKesedihanNormal + 1) / (classNormal + 17);
      } else {
        hitungKesedihanNormal = jumlahKesedihanNormal / classNormal;
      }
      // Pengecekan Kesedihan Depresi
      if (jumlahKesedihanDepresi == 0) {
        hitungKesedihanDepresi =
            (jumlahKesedihanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungKesedihanDepresi = jumlahKesedihanDepresi / classDepresi;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 1
      if (jumlahKesedihanBT1 == 0) {
        hitungKesedihanBT1 = (jumlahKesedihanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungKesedihanBT1 = jumlahKesedihanBT1 / classBT1;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 2
      if (jumlahKesedihanBT2 == 0) {
        hitungKesedihanBT2 = (jumlahKesedihanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungKesedihanBT2 = jumlahKesedihanBT2 / classBT2;
      }

      print(
          "ini hasil Kesedihan normal yang Biasanya : $hitungKesedihanNormal");
      print(
          "ini hasil Kesedihan depresi yang Biasanya : $hitungKesedihanDepresi");
      print(
          "ini hasil Kesedihan bipolar tipe - 1 yang Biasanya : $hitungKesedihanBT1");
      print(
          "ini hasil Kesedihan bipolar tipe - 2 yang Biasanya : $hitungKesedihanBT2");

      // Pilihan Terkadang
    } else if (_kesedihanController.text == 'Terkadang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat kesedihan yang Terkadang di dalam dataset
      int jumlahKesedihanNormal = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Terkadang" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat kesedihan yang Terkadang di dalam dataset
      int jumlahKesedihanDepresi = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Terkadang" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat kesedihan yang Terkadang di dalam dataset
      int jumlahKesedihanBT1 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat kesedihan yang Terkadang di dalam dataset
      int jumlahKesedihanBT2 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Kesedihan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahKesedihanNormal == 0) {
        hitungKesedihanNormal =
            (jumlahKesedihanNormal + 1) / (classNormal + 17);
      } else {
        hitungKesedihanNormal = jumlahKesedihanNormal / classNormal;
      }
      // Pengecekan Kesedihan Depresi
      if (jumlahKesedihanDepresi == 0) {
        hitungKesedihanDepresi =
            (jumlahKesedihanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungKesedihanDepresi = jumlahKesedihanDepresi / classDepresi;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 1
      if (jumlahKesedihanBT1 == 0) {
        hitungKesedihanBT1 = (jumlahKesedihanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungKesedihanBT1 = jumlahKesedihanBT1 / classBT1;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 2
      if (jumlahKesedihanBT2 == 0) {
        hitungKesedihanBT2 = (jumlahKesedihanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungKesedihanBT2 = jumlahKesedihanBT2 / classBT2;
      }

      print(
          "ini hasil Kesedihan normal yang Terkadang : $hitungKesedihanNormal");
      print(
          "ini hasil Kesedihan depresi yang Terkadang : $hitungKesedihanDepresi");
      print(
          "ini hasil Kesedihan bipolar tipe - 1 yang Terkadang : $hitungKesedihanBT1");
      print(
          "ini hasil Kesedihan bipolar tipe - 2 yang Terkadang : $hitungKesedihanBT2");

      // Pilihan Jarang
    } else if (_kesedihanController.text == 'Jarang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat kesedihan yang Jarang di dalam dataset
      int jumlahKesedihanNormal = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Jarang" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat kesedihan yang Jarang di dalam dataset
      int jumlahKesedihanDepresi = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Jarang" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat kesedihan yang Jarang di dalam dataset
      int jumlahKesedihanBT1 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat kesedihan yang Jarang di dalam dataset
      int jumlahKesedihanBT2 = csvDataList
          .where(
            (element) =>
                element.kesedihan == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Kesedihan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahKesedihanNormal == 0) {
        hitungKesedihanNormal =
            (jumlahKesedihanNormal + 1) / (classNormal + 17);
      } else {
        hitungKesedihanNormal = jumlahKesedihanNormal / classNormal;
      }
      // Pengecekan Kesedihan Depresi
      if (jumlahKesedihanDepresi == 0) {
        hitungKesedihanDepresi =
            (jumlahKesedihanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungKesedihanDepresi = jumlahKesedihanDepresi / classDepresi;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 1
      if (jumlahKesedihanBT1 == 0) {
        hitungKesedihanBT1 = (jumlahKesedihanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungKesedihanBT1 = jumlahKesedihanBT1 / classBT1;
      }
      // Pengecekan Kesedihan Bipolar Tipe - 2
      if (jumlahKesedihanBT2 == 0) {
        hitungKesedihanBT2 = (jumlahKesedihanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungKesedihanBT2 = jumlahKesedihanBT2 / classBT2;
      }

      print("ini hasil Kesedihan normal yang Jarang : $hitungKesedihanNormal");
      print(
          "ini hasil Kesedihan depresi yang Jarang : $hitungKesedihanDepresi");
      print(
          "ini hasil Kesedihan bipolar tipe - 1 yang Jarang : $hitungKesedihanBT1");
      print(
          "ini hasil Kesedihan bipolar tipe - 2 yang Jarang : $hitungKesedihanBT2");
    }

    // Hitung Euforia
    // Pilihan Sering
    if (_euforiaController.text == 'Sering') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat euforia yang sering di dalam dataset
      int jumlahEuforiaNormal = csvDataList
          .where(
            (element) =>
                element.euforia == "Sering" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat euforia yang sering di dalam dataset
      int jumlahEuforiaDepresi = csvDataList
          .where(
            (element) =>
                element.euforia == "Sering" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat euforia yang sering di dalam dataset
      int jumlahEuforiaBT1 = csvDataList
          .where(
            (element) =>
                element.euforia == "Sering" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat euforia yang sering di dalam dataset
      int jumlahEuforiaBT2 = csvDataList
          .where(
            (element) =>
                element.euforia == "Sering" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Euforia Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahEuforiaNormal == 0) {
        hitungEuforiaNormal = (jumlahEuforiaNormal + 1) / (classNormal + 17);
      } else {
        hitungEuforiaNormal = jumlahEuforiaNormal / classNormal;
      }
      // Pengecekan Euforia Depresi
      if (jumlahEuforiaDepresi == 0) {
        hitungEuforiaDepresi = (jumlahEuforiaDepresi + 1) / (classDepresi + 17);
      } else {
        hitungEuforiaDepresi = jumlahEuforiaDepresi / classDepresi;
      }
      // Pengecekan Euforia Bipolar Tipe - 1
      if (jumlahEuforiaBT1 == 0) {
        hitungEuforiaBT1 = (jumlahEuforiaBT1 + 1) / (classBT1 + 17);
      } else {
        hitungEuforiaBT1 = jumlahEuforiaBT1 / classBT1;
      }
      // Pengecekan Euforia Bipolar Tipe - 2
      if (jumlahEuforiaBT2 == 0) {
        hitungEuforiaBT2 = (jumlahEuforiaBT2 + 1) / (classBT2 + 17);
      } else {
        hitungEuforiaBT2 = jumlahEuforiaBT2 / classBT2;
      }

      print("ini hasil Euforia normal yang sering : $hitungEuforiaNormal");
      print("ini hasil Euforia depresi yang sering : $hitungEuforiaDepresi");
      print(
          "ini hasil Euforia bipolar tipe - 1 yang sering : $hitungEuforiaBT1");
      print(
          "ini hasil Euforia bipolar tipe - 2 yang sering : $hitungEuforiaBT2");

      // Pilihan Biasanya
    } else if (_euforiaController.text == 'Biasanya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat euforia yang Biasanya di dalam dataset
      int jumlahEuforiaNormal = csvDataList
          .where(
            (element) =>
                element.euforia == "Biasanya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat euforia yang Biasanya di dalam dataset
      int jumlahEuforiaDepresi = csvDataList
          .where(
            (element) =>
                element.euforia == "Biasanya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat euforia yang Biasanya di dalam dataset
      int jumlahEuforiaBT1 = csvDataList
          .where(
            (element) =>
                element.euforia == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat euforia yang Biasanya di dalam dataset
      int jumlahEuforiaBT2 = csvDataList
          .where(
            (element) =>
                element.euforia == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Euforia Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahEuforiaNormal == 0) {
        hitungEuforiaNormal = (jumlahEuforiaNormal + 1) / (classNormal + 17);
      } else {
        hitungEuforiaNormal = jumlahEuforiaNormal / classNormal;
      }
      // Pengecekan Euforia Depresi
      if (jumlahEuforiaDepresi == 0) {
        hitungEuforiaDepresi = (jumlahEuforiaDepresi + 1) / (classDepresi + 17);
      } else {
        hitungEuforiaDepresi = jumlahEuforiaDepresi / classDepresi;
      }
      // Pengecekan Euforia Bipolar Tipe - 1
      if (jumlahEuforiaBT1 == 0) {
        hitungEuforiaBT1 = (jumlahEuforiaBT1 + 1) / (classBT1 + 17);
      } else {
        hitungEuforiaBT1 = jumlahEuforiaBT1 / classBT1;
      }
      // Pengecekan Euforia Bipolar Tipe - 2
      if (jumlahEuforiaBT2 == 0) {
        hitungEuforiaBT2 = (jumlahEuforiaBT2 + 1) / (classBT2 + 17);
      } else {
        hitungEuforiaBT2 = jumlahEuforiaBT2 / classBT2;
      }

      print("ini hasil Euforia normal yang Biasanya : $hitungEuforiaNormal");
      print("ini hasil Euforia depresi yang Biasanya : $hitungEuforiaDepresi");
      print(
          "ini hasil Euforia bipolar tipe - 1 yang Biasanya : $hitungEuforiaBT1");
      print(
          "ini hasil Euforia bipolar tipe - 2 yang Biasanya : $hitungEuforiaBT2");

      // Pilihan Terkadang
    } else if (_euforiaController.text == 'Terkadang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat euforia yang Terkadang di dalam dataset
      int jumlahEuforiaNormal = csvDataList
          .where(
            (element) =>
                element.euforia == "Terkadang" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat euforia yang Terkadang di dalam dataset
      int jumlahEuforiaDepresi = csvDataList
          .where(
            (element) =>
                element.euforia == "Terkadang" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat euforia yang Terkadang di dalam dataset
      int jumlahEuforiaBT1 = csvDataList
          .where(
            (element) =>
                element.euforia == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat euforia yang Terkadang di dalam dataset
      int jumlahEuforiaBT2 = csvDataList
          .where(
            (element) =>
                element.euforia == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Euforia Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahEuforiaNormal == 0) {
        hitungEuforiaNormal = (jumlahEuforiaNormal + 1) / (classNormal + 17);
      } else {
        hitungEuforiaNormal = jumlahEuforiaNormal / classNormal;
      }
      // Pengecekan Euforia Depresi
      if (jumlahEuforiaDepresi == 0) {
        hitungEuforiaDepresi = (jumlahEuforiaDepresi + 1) / (classDepresi + 17);
      } else {
        hitungEuforiaDepresi = jumlahEuforiaDepresi / classDepresi;
      }
      // Pengecekan Euforia Bipolar Tipe - 1
      if (jumlahEuforiaBT1 == 0) {
        hitungEuforiaBT1 = (jumlahEuforiaBT1 + 1) / (classBT1 + 17);
      } else {
        hitungEuforiaBT1 = jumlahEuforiaBT1 / classBT1;
      }
      // Pengecekan Euforia Bipolar Tipe - 2
      if (jumlahEuforiaBT2 == 0) {
        hitungEuforiaBT2 = (jumlahEuforiaBT2 + 1) / (classBT2 + 17);
      } else {
        hitungEuforiaBT2 = jumlahEuforiaBT2 / classBT2;
      }

      print("ini hasil Euforia normal yang Terkadang : $hitungEuforiaNormal");
      print("ini hasil Euforia depresi yang Terkadang : $hitungEuforiaDepresi");
      print(
          "ini hasil Euforia bipolar tipe - 1 yang Terkadang : $hitungEuforiaBT1");
      print(
          "ini hasil Euforia bipolar tipe - 2 yang Terkadang : $hitungEuforiaBT2");

      // Pilihan Jarang
    } else if (_euforiaController.text == 'Jarang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat euforia yang Jarang di dalam dataset
      int jumlahEuforiaNormal = csvDataList
          .where(
            (element) =>
                element.euforia == "Jarang" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat euforia yang Jarang di dalam dataset
      int jumlahEuforiaDepresi = csvDataList
          .where(
            (element) =>
                element.euforia == "Jarang" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat euforia yang Jarang di dalam dataset
      int jumlahEuforiaBT1 = csvDataList
          .where(
            (element) =>
                element.euforia == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat euforia yang Jarang di dalam dataset
      int jumlahEuforiaBT2 = csvDataList
          .where(
            (element) =>
                element.euforia == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Euforia Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahEuforiaNormal == 0) {
        hitungEuforiaNormal = (jumlahEuforiaNormal + 1) / (classNormal + 17);
      } else {
        hitungEuforiaNormal = jumlahEuforiaNormal / classNormal;
      }
      // Pengecekan Euforia Depresi
      if (jumlahEuforiaDepresi == 0) {
        hitungEuforiaDepresi = (jumlahEuforiaDepresi + 1) / (classDepresi + 17);
      } else {
        hitungEuforiaDepresi = jumlahEuforiaDepresi / classDepresi;
      }
      // Pengecekan Euforia Bipolar Tipe - 1
      if (jumlahEuforiaBT1 == 0) {
        hitungEuforiaBT1 = (jumlahEuforiaBT1 + 1) / (classBT1 + 17);
      } else {
        hitungEuforiaBT1 = jumlahEuforiaBT1 / classBT1;
      }
      // Pengecekan Euforia Bipolar Tipe - 2
      if (jumlahEuforiaBT2 == 0) {
        hitungEuforiaBT2 = (jumlahEuforiaBT2 + 1) / (classBT2 + 17);
      } else {
        hitungEuforiaBT2 = jumlahEuforiaBT2 / classBT2;
      }

      print("ini hasil Euforia normal yang Jarang : $hitungEuforiaNormal");
      print("ini hasil Euforia depresi yang Jarang : $hitungEuforiaDepresi");
      print(
          "ini hasil Euforia bipolar tipe - 1 yang Jarang : $hitungEuforiaBT1");
      print(
          "ini hasil Euforia bipolar tipe - 2 yang Jarang : $hitungEuforiaBT2");
    }

    // Hitung Lelah
    // Pilihan Sering
    if (_lelahController.text == 'Sering') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat lelah yang sering di dalam dataset
      int jumlahLelahNormal = csvDataList
          .where(
            (element) =>
                element.lelah == "Sering" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat lelah yang sering di dalam dataset
      int jumlahLelahDepresi = csvDataList
          .where(
            (element) =>
                element.lelah == "Sering" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat lelah yang sering di dalam dataset
      int jumlahLelahBT1 = csvDataList
          .where(
            (element) =>
                element.lelah == "Sering" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat lelah yang sering di dalam dataset
      int jumlahLelahBT2 = csvDataList
          .where(
            (element) =>
                element.lelah == "Sering" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Lelah Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahLelahNormal == 0) {
        hitungLelahNormal = (jumlahLelahNormal + 1) / (classNormal + 17);
      } else {
        hitungLelahNormal = jumlahLelahNormal / classNormal;
      }
      // Pengecekan Lelah Depresi
      if (jumlahLelahDepresi == 0) {
        hitungLelahDepresi = (jumlahLelahDepresi + 1) / (classDepresi + 17);
      } else {
        hitungLelahDepresi = jumlahLelahDepresi / classDepresi;
      }
      // Pengecekan Lelah Bipolar Tipe - 1
      if (jumlahLelahBT1 == 0) {
        hitungLelahBT1 = (jumlahLelahBT1 + 1) / (classBT1 + 17);
      } else {
        hitungLelahBT1 = jumlahLelahBT1 / classBT1;
      }
      // Pengecekan Lelah Bipolar Tipe - 2
      if (jumlahLelahBT2 == 0) {
        hitungLelahBT2 = (jumlahLelahBT2 + 1) / (classBT2 + 17);
      } else {
        hitungLelahBT2 = jumlahLelahBT2 / classBT2;
      }

      print("ini hasil Lelah normal yang sering : $hitungLelahNormal");
      print("ini hasil Lelah depresi yang sering : $hitungLelahDepresi");
      print("ini hasil Lelah bipolar tipe - 1 yang sering : $hitungLelahBT1");
      print("ini hasil Lelah bipolar tipe - 2 yang sering : $hitungLelahBT2");

      // Pilihan Biasanya
    } else if (_lelahController.text == 'Biasanya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat lelah yang Biasanya di dalam dataset
      int jumlahLelahNormal = csvDataList
          .where(
            (element) =>
                element.lelah == "Biasanya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat lelah yang Biasanya di dalam dataset
      int jumlahLelahDepresi = csvDataList
          .where(
            (element) =>
                element.lelah == "Biasanya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat lelah yang Biasanya di dalam dataset
      int jumlahLelahBT1 = csvDataList
          .where(
            (element) =>
                element.lelah == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat lelah yang Biasanya di dalam dataset
      int jumlahLelahBT2 = csvDataList
          .where(
            (element) =>
                element.lelah == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Lelah Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahLelahNormal == 0) {
        hitungLelahNormal = (jumlahLelahNormal + 1) / (classNormal + 17);
      } else {
        hitungLelahNormal = jumlahLelahNormal / classNormal;
      }
      // Pengecekan Lelah Depresi
      if (jumlahLelahDepresi == 0) {
        hitungLelahDepresi = (jumlahLelahDepresi + 1) / (classDepresi + 17);
      } else {
        hitungLelahDepresi = jumlahLelahDepresi / classDepresi;
      }
      // Pengecekan Lelah Bipolar Tipe - 1
      if (jumlahLelahBT1 == 0) {
        hitungLelahBT1 = (jumlahLelahBT1 + 1) / (classBT1 + 17);
      } else {
        hitungLelahBT1 = jumlahLelahBT1 / classBT1;
      }
      // Pengecekan Lelah Bipolar Tipe - 2
      if (jumlahLelahBT2 == 0) {
        hitungLelahBT2 = (jumlahLelahBT2 + 1) / (classBT2 + 17);
      } else {
        hitungLelahBT2 = jumlahLelahBT2 / classBT2;
      }

      print("ini hasil Lelah normal yang Biasanya : $hitungLelahNormal");
      print("ini hasil Lelah depresi yang Biasanya : $hitungLelahDepresi");
      print("ini hasil Lelah bipolar tipe - 1 yang Biasanya : $hitungLelahBT1");
      print("ini hasil Lelah bipolar tipe - 2 yang Biasanya : $hitungLelahBT2");

      // Pilihan Terkadang
    } else if (_lelahController.text == 'Terkadang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat lelah yang Terkadang di dalam dataset
      int jumlahLelahNormal = csvDataList
          .where(
            (element) =>
                element.lelah == "Terkadang" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat lelah yang Terkadang di dalam dataset
      int jumlahLelahDepresi = csvDataList
          .where(
            (element) =>
                element.lelah == "Terkadang" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat lelah yang Terkadang di dalam dataset
      int jumlahLelahBT1 = csvDataList
          .where(
            (element) =>
                element.lelah == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat lelah yang Terkadang di dalam dataset
      int jumlahLelahBT2 = csvDataList
          .where(
            (element) =>
                element.lelah == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Lelah Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahLelahNormal == 0) {
        hitungLelahNormal = (jumlahLelahNormal + 1) / (classNormal + 17);
      } else {
        hitungLelahNormal = jumlahLelahNormal / classNormal;
      }
      // Pengecekan Lelah Depresi
      if (jumlahLelahDepresi == 0) {
        hitungLelahDepresi = (jumlahLelahDepresi + 1) / (classDepresi + 17);
      } else {
        hitungLelahDepresi = jumlahLelahDepresi / classDepresi;
      }
      // Pengecekan Lelah Bipolar Tipe - 1
      if (jumlahLelahBT1 == 0) {
        hitungLelahBT1 = (jumlahLelahBT1 + 1) / (classBT1 + 17);
      } else {
        hitungLelahBT1 = jumlahLelahBT1 / classBT1;
      }
      // Pengecekan Lelah Bipolar Tipe - 2
      if (jumlahLelahBT2 == 0) {
        hitungLelahBT2 = (jumlahLelahBT2 + 1) / (classBT2 + 17);
      } else {
        hitungLelahBT2 = jumlahLelahBT2 / classBT2;
      }

      print("ini hasil Lelah normal yang Terkadang : $hitungLelahNormal");
      print("ini hasil Lelah depresi yang Terkadang : $hitungLelahDepresi");
      print(
          "ini hasil Lelah bipolar tipe - 1 yang Terkadang : $hitungLelahBT1");
      print(
          "ini hasil Lelah bipolar tipe - 2 yang Terkadang : $hitungLelahBT2");

      // Pilihan Jarang
    } else if (_lelahController.text == 'Jarang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat lelah yang Jarang di dalam dataset
      int jumlahLelahNormal = csvDataList
          .where(
            (element) =>
                element.lelah == "Jarang" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat lelah yang Jarang di dalam dataset
      int jumlahLelahDepresi = csvDataList
          .where(
            (element) =>
                element.lelah == "Jarang" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat lelah yang Jarang di dalam dataset
      int jumlahLelahBT1 = csvDataList
          .where(
            (element) =>
                element.lelah == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat lelah yang Jarang di dalam dataset
      int jumlahLelahBT2 = csvDataList
          .where(
            (element) =>
                element.lelah == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Lelah Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahLelahNormal == 0) {
        hitungLelahNormal = (jumlahLelahNormal + 1) / (classNormal + 17);
      } else {
        hitungLelahNormal = jumlahLelahNormal / classNormal;
      }
      // Pengecekan Lelah Depresi
      if (jumlahLelahDepresi == 0) {
        hitungLelahDepresi = (jumlahLelahDepresi + 1) / (classDepresi + 17);
      } else {
        hitungLelahDepresi = jumlahLelahDepresi / classDepresi;
      }
      // Pengecekan Lelah Bipolar Tipe - 1
      if (jumlahLelahBT1 == 0) {
        hitungLelahBT1 = (jumlahLelahBT1 + 1) / (classBT1 + 17);
      } else {
        hitungLelahBT1 = jumlahLelahBT1 / classBT1;
      }
      // Pengecekan Lelah Bipolar Tipe - 2
      if (jumlahLelahBT2 == 0) {
        hitungLelahBT2 = (jumlahLelahBT2 + 1) / (classBT2 + 17);
      } else {
        hitungLelahBT2 = jumlahLelahBT2 / classBT2;
      }

      print("ini hasil Lelah normal yang Jarang : $hitungLelahNormal");
      print("ini hasil Lelah depresi yang Jarang : $hitungLelahDepresi");
      print("ini hasil Lelah bipolar tipe - 1 yang Jarang : $hitungLelahBT1");
      print("ini hasil Lelah bipolar tipe - 2 yang Jarang : $hitungLelahBT2");
    }

    // Hitung Gangguan Tidur
    // Pilihan Sering
    if (_gangguanTidurController.text == 'Sering') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat gangguanTidur yang sering di dalam dataset
      int jumlahGangguanTidurNormal = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Sering" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat gangguanTidur yang sering di dalam dataset
      int jumlahGangguanTidurDepresi = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Sering" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat gangguanTidur yang sering di dalam dataset
      int jumlahGangguanTidurBT1 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Sering" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat gangguanTidur yang sering di dalam dataset
      int jumlahGangguanTidurBT2 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Sering" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Gangguan Tidur Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahGangguanTidurNormal == 0) {
        hitungGangguanTidurNormal =
            (jumlahGangguanTidurNormal + 1) / (classNormal + 17);
      } else {
        hitungGangguanTidurNormal = jumlahGangguanTidurNormal / classNormal;
      }
      // Pengecekan Gangguan Tidur Depresi
      if (jumlahGangguanTidurDepresi == 0) {
        hitungGangguanTidurDepresi =
            (jumlahGangguanTidurDepresi + 1) / (classDepresi + 17);
      } else {
        hitungGangguanTidurDepresi = jumlahGangguanTidurDepresi / classDepresi;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 1
      if (jumlahGangguanTidurBT1 == 0) {
        hitungGangguanTidurBT1 = (jumlahGangguanTidurBT1 + 1) / (classBT1 + 17);
      } else {
        hitungGangguanTidurBT1 = jumlahGangguanTidurBT1 / classBT1;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 2
      if (jumlahGangguanTidurBT2 == 0) {
        hitungGangguanTidurBT2 = (jumlahGangguanTidurBT2 + 1) / (classBT2 + 17);
      } else {
        hitungGangguanTidurBT2 = jumlahGangguanTidurBT2 / classBT2;
      }

      print(
          "ini hasil Gangguan Tidur normal yang sering : $hitungGangguanTidurNormal");
      print(
          "ini hasil Gangguan Tidur depresi yang sering : $hitungGangguanTidurDepresi");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 1 yang sering : $hitungGangguanTidurBT1");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 2 yang sering : $hitungGangguanTidurBT2");

      // Pilihan Biasanya
    } else if (_gangguanTidurController.text == 'Biasanya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat gangguanTidur yang Biasanya di dalam dataset
      int jumlahGangguanTidurNormal = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Biasanya" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat gangguanTidur yang Biasanya di dalam dataset
      int jumlahGangguanTidurDepresi = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Biasanya" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat gangguanTidur yang Biasanya di dalam dataset
      int jumlahGangguanTidurBT1 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat gangguanTidur yang Biasanya di dalam dataset
      int jumlahGangguanTidurBT2 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Biasanya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Gangguan Tidur Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahGangguanTidurNormal == 0) {
        hitungGangguanTidurNormal =
            (jumlahGangguanTidurNormal + 1) / (classNormal + 17);
      } else {
        hitungGangguanTidurNormal = jumlahGangguanTidurNormal / classNormal;
      }
      // Pengecekan Gangguan Tidur Depresi
      if (jumlahGangguanTidurDepresi == 0) {
        hitungGangguanTidurDepresi =
            (jumlahGangguanTidurDepresi + 1) / (classDepresi + 17);
      } else {
        hitungGangguanTidurDepresi = jumlahGangguanTidurDepresi / classDepresi;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 1
      if (jumlahGangguanTidurBT1 == 0) {
        hitungGangguanTidurBT1 = (jumlahGangguanTidurBT1 + 1) / (classBT1 + 17);
      } else {
        hitungGangguanTidurBT1 = jumlahGangguanTidurBT1 / classBT1;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 2
      if (jumlahGangguanTidurBT2 == 0) {
        hitungGangguanTidurBT2 = (jumlahGangguanTidurBT2 + 1) / (classBT2 + 17);
      } else {
        hitungGangguanTidurBT2 = jumlahGangguanTidurBT2 / classBT2;
      }

      print(
          "ini hasil Gangguan Tidur normal yang Biasanya : $hitungGangguanTidurNormal");
      print(
          "ini hasil Gangguan Tidur depresi yang Biasanya : $hitungGangguanTidurDepresi");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 1 yang Biasanya : $hitungGangguanTidurBT1");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 2 yang Biasanya : $hitungGangguanTidurBT2");

      // Pilihan Terkadang
    } else if (_gangguanTidurController.text == 'Terkadang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat gangguanTidur yang Terkadang di dalam dataset
      int jumlahGangguanTidurNormal = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Terkadang" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat gangguanTidur yang Terkadang di dalam dataset
      int jumlahGangguanTidurDepresi = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Terkadang" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat gangguanTidur yang Terkadang di dalam dataset
      int jumlahGangguanTidurBT1 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat gangguanTidur yang Terkadang di dalam dataset
      int jumlahGangguanTidurBT2 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Terkadang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Gangguan Tidur Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahGangguanTidurNormal == 0) {
        hitungGangguanTidurNormal =
            (jumlahGangguanTidurNormal + 1) / (classNormal + 17);
      } else {
        hitungGangguanTidurNormal = jumlahGangguanTidurNormal / classNormal;
      }
      // Pengecekan Gangguan Tidur Depresi
      if (jumlahGangguanTidurDepresi == 0) {
        hitungGangguanTidurDepresi =
            (jumlahGangguanTidurDepresi + 1) / (classDepresi + 17);
      } else {
        hitungGangguanTidurDepresi = jumlahGangguanTidurDepresi / classDepresi;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 1
      if (jumlahGangguanTidurBT1 == 0) {
        hitungGangguanTidurBT1 = (jumlahGangguanTidurBT1 + 1) / (classBT1 + 17);
      } else {
        hitungGangguanTidurBT1 = jumlahGangguanTidurBT1 / classBT1;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 2
      if (jumlahGangguanTidurBT2 == 0) {
        hitungGangguanTidurBT2 = (jumlahGangguanTidurBT2 + 1) / (classBT2 + 17);
      } else {
        hitungGangguanTidurBT2 = jumlahGangguanTidurBT2 / classBT2;
      }

      print(
          "ini hasil Gangguan Tidur normal yang Terkadang : $hitungGangguanTidurNormal");
      print(
          "ini hasil Gangguan Tidur depresi yang Terkadang : $hitungGangguanTidurDepresi");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 1 yang Terkadang : $hitungGangguanTidurBT1");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 2 yang Terkadang : $hitungGangguanTidurBT2");

      // Pilihan Jarang
    } else if (_gangguanTidurController.text == 'Jarang') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat gangguanTidur yang Jarang di dalam dataset
      int jumlahGangguanTidurNormal = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Jarang" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat gangguanTidur yang Jarang di dalam dataset
      int jumlahGangguanTidurDepresi = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Jarang" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat gangguanTidur yang Jarang di dalam dataset
      int jumlahGangguanTidurBT1 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat gangguanTidur yang Jarang di dalam dataset
      int jumlahGangguanTidurBT2 = csvDataList
          .where(
            (element) =>
                element.gangguanTidur == "Jarang" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Gangguan Tidur Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahGangguanTidurNormal == 0) {
        hitungGangguanTidurNormal =
            (jumlahGangguanTidurNormal + 1) / (classNormal + 17);
      } else {
        hitungGangguanTidurNormal = jumlahGangguanTidurNormal / classNormal;
      }
      // Pengecekan Gangguan Tidur Depresi
      if (jumlahGangguanTidurDepresi == 0) {
        hitungGangguanTidurDepresi =
            (jumlahGangguanTidurDepresi + 1) / (classDepresi + 17);
      } else {
        hitungGangguanTidurDepresi = jumlahGangguanTidurDepresi / classDepresi;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 1
      if (jumlahGangguanTidurBT1 == 0) {
        hitungGangguanTidurBT1 = (jumlahGangguanTidurBT1 + 1) / (classBT1 + 17);
      } else {
        hitungGangguanTidurBT1 = jumlahGangguanTidurBT1 / classBT1;
      }
      // Pengecekan Gangguan Tidur Bipolar Tipe - 2
      if (jumlahGangguanTidurBT2 == 0) {
        hitungGangguanTidurBT2 = (jumlahGangguanTidurBT2 + 1) / (classBT2 + 17);
      } else {
        hitungGangguanTidurBT2 = jumlahGangguanTidurBT2 / classBT2;
      }

      print(
          "ini hasil Gangguan Tidur normal yang Jarang : $hitungGangguanTidurNormal");
      print(
          "ini hasil Gangguan Tidur depresi yang Jarang : $hitungGangguanTidurDepresi");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 1 yang Jarang : $hitungGangguanTidurBT1");
      print(
          "ini hasil Gangguan Tidur bipolar tipe - 2 yang Jarang : $hitungGangguanTidurBT2");
    }

    // Hitung Ayunan Mood
    // Pilihan Ya
    if (_ayunanMoodController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat ayunanMood yang Ya di dalam dataset
      int jumlahAyunanMoodNormal = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat ayunanMood yang Ya di dalam dataset
      int jumlahAyunanMoodDepresi = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat ayunanMood yang Ya di dalam dataset
      int jumlahAyunanMoodBT1 = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat ayunanMood yang Ya di dalam dataset
      int jumlahAyunanMoodBT2 = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Ayunan Mood Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAyunanMoodNormal == 0) {
        hitungAyunanMoodNormal =
            (jumlahAyunanMoodNormal + 1) / (classNormal + 17);
      } else {
        hitungAyunanMoodNormal = jumlahAyunanMoodNormal / classNormal;
      }
      // Pengecekan Ayunan Mood Depresi
      if (jumlahAyunanMoodDepresi == 0) {
        hitungAyunanMoodDepresi =
            (jumlahAyunanMoodDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAyunanMoodDepresi = jumlahAyunanMoodDepresi / classDepresi;
      }
      // Pengecekan Ayunan Mood Bipolar Tipe - 1
      if (jumlahAyunanMoodBT1 == 0) {
        hitungAyunanMoodBT1 = (jumlahAyunanMoodBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAyunanMoodBT1 = jumlahAyunanMoodBT1 / classBT1;
      }
      // Pengecekan Ayunan Mood Bipolar Tipe - 2
      if (jumlahAyunanMoodBT2 == 0) {
        hitungAyunanMoodBT2 = (jumlahAyunanMoodBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAyunanMoodBT2 = jumlahAyunanMoodBT2 / classBT2;
      }

      print("ini hasil Ayunan Mood normal yang Ya : $hitungAyunanMoodNormal");
      print("ini hasil Ayunan Mood depresi yang Ya : $hitungAyunanMoodDepresi");
      print(
          "ini hasil Ayunan Mood bipolar tipe - 1 yang Ya : $hitungAyunanMoodBT1");
      print(
          "ini hasil Ayunan Mood bipolar tipe - 2 yang Ya : $hitungAyunanMoodBT2");

      // Pilihan Tidak
    } else if (_ayunanMoodController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat ayunanMood yang Tidak di dalam dataset
      int jumlahAyunanMoodNormal = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Tidak" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat ayunanMood yang Tidak di dalam dataset
      int jumlahAyunanMoodDepresi = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Tidak" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat ayunanMood yang Tidak di dalam dataset
      int jumlahAyunanMoodBT1 = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat ayunanMood yang Tidak di dalam dataset
      int jumlahAyunanMoodBT2 = csvDataList
          .where(
            (element) =>
                element.ayunanMood == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Ayunan Mood Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAyunanMoodNormal == 0) {
        hitungAyunanMoodNormal =
            (jumlahAyunanMoodNormal + 1) / (classNormal + 17);
      } else {
        hitungAyunanMoodNormal = jumlahAyunanMoodNormal / classNormal;
      }
      // Pengecekan Ayunan Mood Depresi
      if (jumlahAyunanMoodDepresi == 0) {
        hitungAyunanMoodDepresi =
            (jumlahAyunanMoodDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAyunanMoodDepresi = jumlahAyunanMoodDepresi / classDepresi;
      }
      // Pengecekan Ayunan Mood Bipolar Tipe - 1
      if (jumlahAyunanMoodBT1 == 0) {
        hitungAyunanMoodBT1 = (jumlahAyunanMoodBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAyunanMoodBT1 = jumlahAyunanMoodBT1 / classBT1;
      }
      // Pengecekan Ayunan Mood Bipolar Tipe - 2
      if (jumlahAyunanMoodBT2 == 0) {
        hitungAyunanMoodBT2 = (jumlahAyunanMoodBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAyunanMoodBT2 = jumlahAyunanMoodBT2 / classBT2;
      }
      print(
          "ini hasil Ayunan Mood normal yang Tidak : $hitungAyunanMoodNormal");
      print(
          "ini hasil Ayunan Mood depresi yang Tidak : $hitungAyunanMoodDepresi");
      print(
          "ini hasil Ayunan Mood bipolar tipe - 1 yang Tidak : $hitungAyunanMoodBT1");
      print(
          "ini hasil Ayunan Mood bipolar tipe - 2 yang Tidak : $hitungAyunanMoodBT2");
    }

    // Hitung Pikiran Untuk Bunuh Diri
    // Pilihan Ya
    if (_bunuhDiriController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat bunuhDiri yang Ya di dalam dataset
      int jumlahBunuhDiriNormal = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat bunuhDiri yang Ya di dalam dataset
      int jumlahBunuhDiriDepresi = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat bunuhDiri yang Ya di dalam dataset
      int jumlahBunuhDiriBT1 = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat bunuhDiri yang Ya di dalam dataset
      int jumlahBunuhDiriBT2 = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Bunuh Diri Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahBunuhDiriNormal == 0) {
        hitungBunuhDiriNormal =
            (jumlahBunuhDiriNormal + 1) / (classNormal + 17);
      } else {
        hitungBunuhDiriNormal = jumlahBunuhDiriNormal / classNormal;
      }
      // Pengecekan Bunuh Diri Depresi
      if (jumlahBunuhDiriDepresi == 0) {
        hitungBunuhDiriDepresi =
            (jumlahBunuhDiriDepresi + 1) / (classDepresi + 17);
      } else {
        hitungBunuhDiriDepresi = jumlahBunuhDiriDepresi / classDepresi;
      }
      // Pengecekan Bunuh Diri Bipolar Tipe - 1
      if (jumlahBunuhDiriBT1 == 0) {
        hitungBunuhDiriBT1 = (jumlahBunuhDiriBT1 + 1) / (classBT1 + 17);
      } else {
        hitungBunuhDiriBT1 = jumlahBunuhDiriBT1 / classBT1;
      }
      // Pengecekan Bunuh Diri Bipolar Tipe - 2
      if (jumlahBunuhDiriBT2 == 0) {
        hitungBunuhDiriBT2 = (jumlahBunuhDiriBT2 + 1) / (classBT2 + 17);
      } else {
        hitungBunuhDiriBT2 = jumlahBunuhDiriBT2 / classBT2;
      }

      print("ini hasil Bunuh Diri normal yang Ya : $hitungBunuhDiriNormal");
      print("ini hasil Bunuh Diri depresi yang Ya : $hitungBunuhDiriDepresi");
      print(
          "ini hasil Bunuh Diri bipolar tipe - 1 yang Ya : $hitungBunuhDiriBT1");
      print(
          "ini hasil Bunuh Diri bipolar tipe - 2 yang Ya : $hitungBunuhDiriBT2");

      // Pilihan Tidak
    } else if (_bunuhDiriController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat bunuhDiri yang Tidak di dalam dataset
      int jumlahBunuhDiriNormal = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Tidak" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat bunuhDiri yang Tidak di dalam dataset
      int jumlahBunuhDiriDepresi = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Tidak" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat bunuhDiri yang Tidak di dalam dataset
      int jumlahBunuhDiriBT1 = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat bunuhDiri yang Tidak di dalam dataset
      int jumlahBunuhDiriBT2 = csvDataList
          .where(
            (element) =>
                element.bunuhDiri == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Bunuh Diri Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahBunuhDiriNormal == 0) {
        hitungBunuhDiriNormal =
            (jumlahBunuhDiriNormal + 1) / (classNormal + 17);
      } else {
        hitungBunuhDiriNormal = jumlahBunuhDiriNormal / classNormal;
      }
      // Pengecekan Bunuh Diri Depresi
      if (jumlahBunuhDiriDepresi == 0) {
        hitungBunuhDiriDepresi =
            (jumlahBunuhDiriDepresi + 1) / (classDepresi + 17);
      } else {
        hitungBunuhDiriDepresi = jumlahBunuhDiriDepresi / classDepresi;
      }
      // Pengecekan Bunuh Diri Bipolar Tipe - 1
      if (jumlahBunuhDiriBT1 == 0) {
        hitungBunuhDiriBT1 = (jumlahBunuhDiriBT1 + 1) / (classBT1 + 17);
      } else {
        hitungBunuhDiriBT1 = jumlahBunuhDiriBT1 / classBT1;
      }
      // Pengecekan Bunuh Diri Bipolar Tipe - 2
      if (jumlahBunuhDiriBT2 == 0) {
        hitungBunuhDiriBT2 = (jumlahBunuhDiriBT2 + 1) / (classBT2 + 17);
      } else {
        hitungBunuhDiriBT2 = jumlahBunuhDiriBT2 / classBT2;
      }
      print("ini hasil Bunuh Diri normal yang Tidak : $hitungBunuhDiriNormal");
      print(
          "ini hasil Bunuh Diri depresi yang Tidak : $hitungBunuhDiriDepresi");
      print(
          "ini hasil Bunuh Diri bipolar tipe - 1 yang Tidak : $hitungBunuhDiriBT1");
      print(
          "ini hasil Bunuh Diri bipolar tipe - 2 yang Tidak : $hitungBunuhDiriBT2");
    }

    // Hitung Anoreksia
    // Pilihan Ya
    if (_anoreksiaController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat anoreksia yang Ya di dalam dataset
      int jumlahAnoreksiaNormal = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat anoreksia yang Ya di dalam dataset
      int jumlahAnoreksiaDepresi = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat anoreksia yang Ya di dalam dataset
      int jumlahAnoreksiaBT1 = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat anoreksia yang Ya di dalam dataset
      int jumlahAnoreksiaBT2 = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Anoreksia Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAnoreksiaNormal == 0) {
        hitungAnoreksiaNormal =
            (jumlahAnoreksiaNormal + 1) / (classNormal + 17);
      } else {
        hitungAnoreksiaNormal = jumlahAnoreksiaNormal / classNormal;
      }
      // Pengecekan Anoreksia Depresi
      if (jumlahAnoreksiaDepresi == 0) {
        hitungAnoreksiaDepresi =
            (jumlahAnoreksiaDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAnoreksiaDepresi = jumlahAnoreksiaDepresi / classDepresi;
      }
      // Pengecekan Anoreksia Bipolar Tipe - 1
      if (jumlahAnoreksiaBT1 == 0) {
        hitungAnoreksiaBT1 = (jumlahAnoreksiaBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAnoreksiaBT1 = jumlahAnoreksiaBT1 / classBT1;
      }
      // Pengecekan Anoreksia Bipolar Tipe - 2
      if (jumlahAnoreksiaBT2 == 0) {
        hitungAnoreksiaBT2 = (jumlahAnoreksiaBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAnoreksiaBT2 = jumlahAnoreksiaBT2 / classBT2;
      }

      print("ini hasil Anoreksia normal yang Ya : $hitungAnoreksiaNormal");
      print("ini hasil Anoreksia depresi yang Ya : $hitungAnoreksiaDepresi");
      print(
          "ini hasil Anoreksia bipolar tipe - 1 yang Ya : $hitungAnoreksiaBT1");
      print(
          "ini hasil Anoreksia bipolar tipe - 2 yang Ya : $hitungAnoreksiaBT2");

      // Pilihan Tidak
    } else if (_anoreksiaController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat anoreksia yang Tidak di dalam dataset
      int jumlahAnoreksiaNormal = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Tidak" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat anoreksia yang Tidak di dalam dataset
      int jumlahAnoreksiaDepresi = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Tidak" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat anoreksia yang Tidak di dalam dataset
      int jumlahAnoreksiaBT1 = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat anoreksia yang Tidak di dalam dataset
      int jumlahAnoreksiaBT2 = csvDataList
          .where(
            (element) =>
                element.anoreksia == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Anoreksia Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAnoreksiaNormal == 0) {
        hitungAnoreksiaNormal =
            (jumlahAnoreksiaNormal + 1) / (classNormal + 17);
      } else {
        hitungAnoreksiaNormal = jumlahAnoreksiaNormal / classNormal;
      }
      // Pengecekan Anoreksia Depresi
      if (jumlahAnoreksiaDepresi == 0) {
        hitungAnoreksiaDepresi =
            (jumlahAnoreksiaDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAnoreksiaDepresi = jumlahAnoreksiaDepresi / classDepresi;
      }
      // Pengecekan Anoreksia Bipolar Tipe - 1
      if (jumlahAnoreksiaBT1 == 0) {
        hitungAnoreksiaBT1 = (jumlahAnoreksiaBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAnoreksiaBT1 = jumlahAnoreksiaBT1 / classBT1;
      }
      // Pengecekan Anoreksia Bipolar Tipe - 2
      if (jumlahAnoreksiaBT2 == 0) {
        hitungAnoreksiaBT2 = (jumlahAnoreksiaBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAnoreksiaBT2 = jumlahAnoreksiaBT2 / classBT2;
      }
      print("ini hasil Anoreksia normal yang Tidak : $hitungAnoreksiaNormal");
      print("ini hasil Anoreksia depresi yang Tidak : $hitungAnoreksiaDepresi");
      print(
          "ini hasil Anoreksia bipolar tipe - 1 yang Tidak : $hitungAnoreksiaBT1");
      print(
          "ini hasil Anoreksia bipolar tipe - 2 yang Tidak : $hitungAnoreksiaBT2");
    }

    // Hitung Rasa Hormat
    // Pilihan Ya
    if (_rasaHormatController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat rasaHormat yang Ya di dalam dataset
      int jumlahRasaHormatNormal = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat rasaHormat yang Ya di dalam dataset
      int jumlahRasaHormatDepresi = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat rasaHormat yang Ya di dalam dataset
      int jumlahRasaHormatBT1 = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat rasaHormat yang Ya di dalam dataset
      int jumlahRasaHormatBT2 = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Rasa Hormat Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahRasaHormatNormal == 0) {
        hitungRasaHormatNormal =
            (jumlahRasaHormatNormal + 1) / (classNormal + 17);
      } else {
        hitungRasaHormatNormal = jumlahRasaHormatNormal / classNormal;
      }
      // Pengecekan Rasa Hormat Depresi
      if (jumlahRasaHormatDepresi == 0) {
        hitungRasaHormatDepresi =
            (jumlahRasaHormatDepresi + 1) / (classDepresi + 17);
      } else {
        hitungRasaHormatDepresi = jumlahRasaHormatDepresi / classDepresi;
      }
      // Pengecekan Rasa Hormat Bipolar Tipe - 1
      if (jumlahRasaHormatBT1 == 0) {
        hitungRasaHormatBT1 = (jumlahRasaHormatBT1 + 1) / (classBT1 + 17);
      } else {
        hitungRasaHormatBT1 = jumlahRasaHormatBT1 / classBT1;
      }
      // Pengecekan Rasa Hormat Bipolar Tipe - 2
      if (jumlahRasaHormatBT2 == 0) {
        hitungRasaHormatBT2 = (jumlahRasaHormatBT2 + 1) / (classBT2 + 17);
      } else {
        hitungRasaHormatBT2 = jumlahRasaHormatBT2 / classBT2;
      }

      print("ini hasil Rasa Hormat normal yang Ya : $hitungRasaHormatNormal");
      print("ini hasil Rasa Hormat depresi yang Ya : $hitungRasaHormatDepresi");
      print(
          "ini hasil Rasa Hormat bipolar tipe - 1 yang Ya : $hitungRasaHormatBT1");
      print(
          "ini hasil Rasa Hormat bipolar tipe - 2 yang Ya : $hitungRasaHormatBT2");

      // Pilihan Tidak
    } else if (_rasaHormatController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat rasaHormat yang Tidak di dalam dataset
      int jumlahRasaHormatNormal = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Tidak" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat rasaHormat yang Tidak di dalam dataset
      int jumlahRasaHormatDepresi = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Tidak" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat rasaHormat yang Tidak di dalam dataset
      int jumlahRasaHormatBT1 = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat rasaHormat yang Tidak di dalam dataset
      int jumlahRasaHormatBT2 = csvDataList
          .where(
            (element) =>
                element.rasaHormat == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Rasa Hormat Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahRasaHormatNormal == 0) {
        hitungRasaHormatNormal =
            (jumlahRasaHormatNormal + 1) / (classNormal + 17);
      } else {
        hitungRasaHormatNormal = jumlahRasaHormatNormal / classNormal;
      }
      // Pengecekan Rasa Hormat Depresi
      if (jumlahRasaHormatDepresi == 0) {
        hitungRasaHormatDepresi =
            (jumlahRasaHormatDepresi + 1) / (classDepresi + 17);
      } else {
        hitungRasaHormatDepresi = jumlahRasaHormatDepresi / classDepresi;
      }
      // Pengecekan Rasa Hormat Bipolar Tipe - 1
      if (jumlahRasaHormatBT1 == 0) {
        hitungRasaHormatBT1 = (jumlahRasaHormatBT1 + 1) / (classBT1 + 17);
      } else {
        hitungRasaHormatBT1 = jumlahRasaHormatBT1 / classBT1;
      }
      // Pengecekan Rasa Hormat Bipolar Tipe - 2
      if (jumlahRasaHormatBT2 == 0) {
        hitungRasaHormatBT2 = (jumlahRasaHormatBT2 + 1) / (classBT2 + 17);
      } else {
        hitungRasaHormatBT2 = jumlahRasaHormatBT2 / classBT2;
      }
      print(
          "ini hasil Rasa Hormat normal yang Tidak : $hitungRasaHormatNormal");
      print(
          "ini hasil Rasa Hormat depresi yang Tidak : $hitungRasaHormatDepresi");
      print(
          "ini hasil Rasa Hormat bipolar tipe - 1 yang Tidak : $hitungRasaHormatBT1");
      print(
          "ini hasil Rasa Hormat bipolar tipe - 2 yang Tidak : $hitungRasaHormatBT2");
    }

    // Hitung Meminta Penjelasan
    // Pilihan Ya
    if (_memintaPenjelasanController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat memintaPenjelasan yang Ya di dalam dataset
      int jumlahMemintaPenjelasanNormal = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Ya" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat memintaPenjelasan yang Ya di dalam dataset
      int jumlahMemintaPenjelasanDepresi = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Ya" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat memintaPenjelasan yang Ya di dalam dataset
      int jumlahMemintaPenjelasanBT1 = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat memintaPenjelasan yang Ya di dalam dataset
      int jumlahMemintaPenjelasanBT2 = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Meminta Penjelasan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahMemintaPenjelasanNormal == 0) {
        hitungMemintaPenjelasanNormal =
            (jumlahMemintaPenjelasanNormal + 1) / (classNormal + 17);
      } else {
        hitungMemintaPenjelasanNormal =
            jumlahMemintaPenjelasanNormal / classNormal;
      }
      // Pengecekan Meminta Penjelasan Depresi
      if (jumlahMemintaPenjelasanDepresi == 0) {
        hitungMemintaPenjelasanDepresi =
            (jumlahMemintaPenjelasanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungMemintaPenjelasanDepresi =
            jumlahMemintaPenjelasanDepresi / classDepresi;
      }
      // Pengecekan Meminta Penjelasan Bipolar Tipe - 1
      if (jumlahMemintaPenjelasanBT1 == 0) {
        hitungMemintaPenjelasanBT1 =
            (jumlahMemintaPenjelasanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungMemintaPenjelasanBT1 = jumlahMemintaPenjelasanBT1 / classBT1;
      }
      // Pengecekan Meminta Penjelasan Bipolar Tipe - 2
      if (jumlahMemintaPenjelasanBT2 == 0) {
        hitungMemintaPenjelasanBT2 =
            (jumlahMemintaPenjelasanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungMemintaPenjelasanBT2 = jumlahMemintaPenjelasanBT2 / classBT2;
      }

      print(
          "ini hasil Meminta Penjelasan normal yang Ya : $hitungMemintaPenjelasanNormal");
      print(
          "ini hasil Meminta Penjelasan depresi yang Ya : $hitungMemintaPenjelasanDepresi");
      print(
          "ini hasil Meminta Penjelasan bipolar tipe - 1 yang Ya : $hitungMemintaPenjelasanBT1");
      print(
          "ini hasil Meminta Penjelasan bipolar tipe - 2 yang Ya : $hitungMemintaPenjelasanBT2");

      // Pilihan Tidak
    } else if (_memintaPenjelasanController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat memintaPenjelasan yang Tidak di dalam dataset
      int jumlahMemintaPenjelasanNormal = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Tidak" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat memintaPenjelasan yang Tidak di dalam dataset
      int jumlahMemintaPenjelasanDepresi = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Tidak" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat memintaPenjelasan yang Tidak di dalam dataset
      int jumlahMemintaPenjelasanBT1 = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat memintaPenjelasan yang Tidak di dalam dataset
      int jumlahMemintaPenjelasanBT2 = csvDataList
          .where(
            (element) =>
                element.memintaPenjelasan == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Meminta Penjelasan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahMemintaPenjelasanNormal == 0) {
        hitungMemintaPenjelasanNormal =
            (jumlahMemintaPenjelasanNormal + 1) / (classNormal + 17);
      } else {
        hitungMemintaPenjelasanNormal =
            jumlahMemintaPenjelasanNormal / classNormal;
      }
      // Pengecekan Meminta Penjelasan Depresi
      if (jumlahMemintaPenjelasanDepresi == 0) {
        hitungMemintaPenjelasanDepresi =
            (jumlahMemintaPenjelasanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungMemintaPenjelasanDepresi =
            jumlahMemintaPenjelasanDepresi / classDepresi;
      }
      // Pengecekan Meminta Penjelasan Bipolar Tipe - 1
      if (jumlahMemintaPenjelasanBT1 == 0) {
        hitungMemintaPenjelasanBT1 =
            (jumlahMemintaPenjelasanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungMemintaPenjelasanBT1 = jumlahMemintaPenjelasanBT1 / classBT1;
      }
      // Pengecekan Meminta Penjelasan Bipolar Tipe - 2
      if (jumlahMemintaPenjelasanBT2 == 0) {
        hitungMemintaPenjelasanBT2 =
            (jumlahMemintaPenjelasanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungMemintaPenjelasanBT2 = jumlahMemintaPenjelasanBT2 / classBT2;
      }
      print(
          "ini hasil Meminta Penjelasan normal yang Tidak : $hitungMemintaPenjelasanNormal");
      print(
          "ini hasil Meminta Penjelasan depresi yang Tidak : $hitungMemintaPenjelasanDepresi");
      print(
          "ini hasil Meminta Penjelasan bipolar tipe - 1 yang Tidak : $hitungMemintaPenjelasanBT1");
      print(
          "ini hasil Meminta Penjelasan bipolar tipe - 2 yang Tidak : $hitungMemintaPenjelasanBT2");
    }

    // Hitung Respon Agresif
    // Pilihan Ya
    if (_responAgresifController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat responAgresif yang Ya di dalam dataset
      int jumlahResponAgresifNormal = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat responAgresif yang Ya di dalam dataset
      int jumlahResponAgresifDepresi = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat responAgresif yang Ya di dalam dataset
      int jumlahResponAgresifBT1 = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat responAgresif yang Ya di dalam dataset
      int jumlahResponAgresifBT2 = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Respon Agresif Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahResponAgresifNormal == 0) {
        hitungResponAgresifNormal =
            (jumlahResponAgresifNormal + 1) / (classNormal + 17);
      } else {
        hitungResponAgresifNormal = jumlahResponAgresifNormal / classNormal;
      }
      // Pengecekan Respon Agresif Depresi
      if (jumlahResponAgresifDepresi == 0) {
        hitungResponAgresifDepresi =
            (jumlahResponAgresifDepresi + 1) / (classDepresi + 17);
      } else {
        hitungResponAgresifDepresi = jumlahResponAgresifDepresi / classDepresi;
      }
      // Pengecekan Respon Agresif Bipolar Tipe - 1
      if (jumlahResponAgresifBT1 == 0) {
        hitungResponAgresifBT1 = (jumlahResponAgresifBT1 + 1) / (classBT1 + 17);
      } else {
        hitungResponAgresifBT1 = jumlahResponAgresifBT1 / classBT1;
      }
      // Pengecekan Respon Agresif Bipolar Tipe - 2
      if (jumlahResponAgresifBT2 == 0) {
        hitungResponAgresifBT2 = (jumlahResponAgresifBT2 + 1) / (classBT2 + 17);
      } else {
        hitungResponAgresifBT2 = jumlahResponAgresifBT2 / classBT2;
      }

      print(
          "ini hasil Respon Agresif normal yang Ya : $hitungResponAgresifNormal");
      print(
          "ini hasil Respon Agresif depresi yang Ya : $hitungResponAgresifDepresi");
      print(
          "ini hasil Respon Agresif bipolar tipe - 1 yang Ya : $hitungResponAgresifBT1");
      print(
          "ini hasil Respon Agresif bipolar tipe - 2 yang Ya : $hitungResponAgresifBT2");

      // Pilihan Tidak
    } else if (_responAgresifController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat responAgresif yang Tidak di dalam dataset
      int jumlahResponAgresifNormal = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Tidak" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat responAgresif yang Tidak di dalam dataset
      int jumlahResponAgresifDepresi = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Tidak" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat responAgresif yang Tidak di dalam dataset
      int jumlahResponAgresifBT1 = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat responAgresif yang Tidak di dalam dataset
      int jumlahResponAgresifBT2 = csvDataList
          .where(
            (element) =>
                element.responAgresif == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Respon Agresif Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahResponAgresifNormal == 0) {
        hitungResponAgresifNormal =
            (jumlahResponAgresifNormal + 1) / (classNormal + 17);
      } else {
        hitungResponAgresifNormal = jumlahResponAgresifNormal / classNormal;
      }
      // Pengecekan Respon Agresif Depresi
      if (jumlahResponAgresifDepresi == 0) {
        hitungResponAgresifDepresi =
            (jumlahResponAgresifDepresi + 1) / (classDepresi + 17);
      } else {
        hitungResponAgresifDepresi = jumlahResponAgresifDepresi / classDepresi;
      }
      // Pengecekan Respon Agresif Bipolar Tipe - 1
      if (jumlahResponAgresifBT1 == 0) {
        hitungResponAgresifBT1 = (jumlahResponAgresifBT1 + 1) / (classBT1 + 17);
      } else {
        hitungResponAgresifBT1 = jumlahResponAgresifBT1 / classBT1;
      }
      // Pengecekan Respon Agresif Bipolar Tipe - 2
      if (jumlahResponAgresifBT2 == 0) {
        hitungResponAgresifBT2 = (jumlahResponAgresifBT2 + 1) / (classBT2 + 17);
      } else {
        hitungResponAgresifBT2 = jumlahResponAgresifBT2 / classBT2;
      }
      print(
          "ini hasil Respon Agresif normal yang Tidak : $hitungResponAgresifNormal");
      print(
          "ini hasil Respon Agresif depresi yang Tidak : $hitungResponAgresifDepresi");
      print(
          "ini hasil Respon Agresif bipolar tipe - 1 yang Tidak : $hitungResponAgresifBT1");
      print(
          "ini hasil Respon Agresif bipolar tipe - 2 yang Tidak : $hitungResponAgresifBT2");
    }

    // Hitung Acuh Beranjak
    // Pilihan Ya
    if (_acuhBeranjakController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat acuhBeranjak yang Ya di dalam dataset
      int jumlahAcuhBeranjakNormal = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat acuhBeranjak yang Ya di dalam dataset
      int jumlahAcuhBeranjakDepresi = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat acuhBeranjak yang Ya di dalam dataset
      int jumlahAcuhBeranjakBT1 = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat acuhBeranjak yang Ya di dalam dataset
      int jumlahAcuhBeranjakBT2 = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Acuh Beranjak Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAcuhBeranjakNormal == 0) {
        hitungAcuhBeranjakNormal =
            (jumlahAcuhBeranjakNormal + 1) / (classNormal + 17);
      } else {
        hitungAcuhBeranjakNormal = jumlahAcuhBeranjakNormal / classNormal;
      }
      // Pengecekan Acuh Beranjak Depresi
      if (jumlahAcuhBeranjakDepresi == 0) {
        hitungAcuhBeranjakDepresi =
            (jumlahAcuhBeranjakDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAcuhBeranjakDepresi = jumlahAcuhBeranjakDepresi / classDepresi;
      }
      // Pengecekan Acuh Beranjak Bipolar Tipe - 1
      if (jumlahAcuhBeranjakBT1 == 0) {
        hitungAcuhBeranjakBT1 = (jumlahAcuhBeranjakBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAcuhBeranjakBT1 = jumlahAcuhBeranjakBT1 / classBT1;
      }
      // Pengecekan Acuh Beranjak Bipolar Tipe - 2
      if (jumlahAcuhBeranjakBT2 == 0) {
        hitungAcuhBeranjakBT2 = (jumlahAcuhBeranjakBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAcuhBeranjakBT2 = jumlahAcuhBeranjakBT2 / classBT2;
      }

      print(
          "ini hasil Acuh Beranjak normal yang Ya : $hitungAcuhBeranjakNormal");
      print(
          "ini hasil Acuh Beranjak depresi yang Ya : $hitungAcuhBeranjakDepresi");
      print(
          "ini hasil Acuh Beranjak bipolar tipe - 1 yang Ya : $hitungAcuhBeranjakBT1");
      print(
          "ini hasil Acuh Beranjak bipolar tipe - 2 yang Ya : $hitungAcuhBeranjakBT2");

      // Pilihan Tidak
    } else if (_acuhBeranjakController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat acuhBeranjak yang Tidak di dalam dataset
      int jumlahAcuhBeranjakNormal = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Tidak" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat acuhBeranjak yang Tidak di dalam dataset
      int jumlahAcuhBeranjakDepresi = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Tidak" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat acuhBeranjak yang Tidak di dalam dataset
      int jumlahAcuhBeranjakBT1 = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat acuhBeranjak yang Tidak di dalam dataset
      int jumlahAcuhBeranjakBT2 = csvDataList
          .where(
            (element) =>
                element.acuhBeranjak == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Acuh Beranjak Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAcuhBeranjakNormal == 0) {
        hitungAcuhBeranjakNormal =
            (jumlahAcuhBeranjakNormal + 1) / (classNormal + 17);
      } else {
        hitungAcuhBeranjakNormal = jumlahAcuhBeranjakNormal / classNormal;
      }
      // Pengecekan Acuh Beranjak Depresi
      if (jumlahAcuhBeranjakDepresi == 0) {
        hitungAcuhBeranjakDepresi =
            (jumlahAcuhBeranjakDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAcuhBeranjakDepresi = jumlahAcuhBeranjakDepresi / classDepresi;
      }
      // Pengecekan Acuh Beranjak Bipolar Tipe - 1
      if (jumlahAcuhBeranjakBT1 == 0) {
        hitungAcuhBeranjakBT1 = (jumlahAcuhBeranjakBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAcuhBeranjakBT1 = jumlahAcuhBeranjakBT1 / classBT1;
      }
      // Pengecekan Acuh Beranjak Bipolar Tipe - 2
      if (jumlahAcuhBeranjakBT2 == 0) {
        hitungAcuhBeranjakBT2 = (jumlahAcuhBeranjakBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAcuhBeranjakBT2 = jumlahAcuhBeranjakBT2 / classBT2;
      }
      print(
          "ini hasil Acuh Beranjak normal yang Tidak : $hitungAcuhBeranjakNormal");
      print(
          "ini hasil Acuh Beranjak depresi yang Tidak : $hitungAcuhBeranjakDepresi");
      print(
          "ini hasil Acuh Beranjak bipolar tipe - 1 yang Tidak : $hitungAcuhBeranjakBT1");
      print(
          "ini hasil Acuh Beranjak bipolar tipe - 2 yang Tidak : $hitungAcuhBeranjakBT2");
    }

    // Hitung Gugup
    // Pilihan Ya
    if (_gugupController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat gugup yang Ya di dalam dataset
      int jumlahGugupNormal = csvDataList
          .where(
            (element) => element.gugup == "Ya" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat gugup yang Ya di dalam dataset
      int jumlahGugupDepresi = csvDataList
          .where(
            (element) => element.gugup == "Ya" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat gugup yang Ya di dalam dataset
      int jumlahGugupBT1 = csvDataList
          .where(
            (element) =>
                element.gugup == "Ya" && element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat gugup yang Ya di dalam dataset
      int jumlahGugupBT2 = csvDataList
          .where(
            (element) =>
                element.gugup == "Ya" && element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Gugup Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahGugupNormal == 0) {
        hitungGugupNormal = (jumlahGugupNormal + 1) / (classNormal + 17);
      } else {
        hitungGugupNormal = jumlahGugupNormal / classNormal;
      }
      // Pengecekan Gugup Depresi
      if (jumlahGugupDepresi == 0) {
        hitungGugupDepresi = (jumlahGugupDepresi + 1) / (classDepresi + 17);
      } else {
        hitungGugupDepresi = jumlahGugupDepresi / classDepresi;
      }
      // Pengecekan Gugup Bipolar Tipe - 1
      if (jumlahGugupBT1 == 0) {
        hitungGugupBT1 = (jumlahGugupBT1 + 1) / (classBT1 + 17);
      } else {
        hitungGugupBT1 = jumlahGugupBT1 / classBT1;
      }
      // Pengecekan Gugup Bipolar Tipe - 2
      if (jumlahGugupBT2 == 0) {
        hitungGugupBT2 = (jumlahGugupBT2 + 1) / (classBT2 + 17);
      } else {
        hitungGugupBT2 = jumlahGugupBT2 / classBT2;
      }

      print("ini hasil Gugup normal yang Ya : $hitungGugupNormal");
      print("ini hasil Gugup depresi yang Ya : $hitungGugupDepresi");
      print("ini hasil Gugup bipolar tipe - 1 yang Ya : $hitungGugupBT1");
      print("ini hasil Gugup bipolar tipe - 2 yang Ya : $hitungGugupBT2");

      // Pilihan Tidak
    } else if (_gugupController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat gugup yang Tidak di dalam dataset
      int jumlahGugupNormal = csvDataList
          .where(
            (element) =>
                element.gugup == "Tidak" && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat gugup yang Tidak di dalam dataset
      int jumlahGugupDepresi = csvDataList
          .where(
            (element) =>
                element.gugup == "Tidak" && element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat gugup yang Tidak di dalam dataset
      int jumlahGugupBT1 = csvDataList
          .where(
            (element) =>
                element.gugup == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat gugup yang Tidak di dalam dataset
      int jumlahGugupBT2 = csvDataList
          .where(
            (element) =>
                element.gugup == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Gugup Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahGugupNormal == 0) {
        hitungGugupNormal = (jumlahGugupNormal + 1) / (classNormal + 17);
      } else {
        hitungGugupNormal = jumlahGugupNormal / classNormal;
      }
      // Pengecekan Gugup Depresi
      if (jumlahGugupDepresi == 0) {
        hitungGugupDepresi = (jumlahGugupDepresi + 1) / (classDepresi + 17);
      } else {
        hitungGugupDepresi = jumlahGugupDepresi / classDepresi;
      }
      // Pengecekan Gugup Bipolar Tipe - 1
      if (jumlahGugupBT1 == 0) {
        hitungGugupBT1 = (jumlahGugupBT1 + 1) / (classBT1 + 17);
      } else {
        hitungGugupBT1 = jumlahGugupBT1 / classBT1;
      }
      // Pengecekan Gugup Bipolar Tipe - 2
      if (jumlahGugupBT2 == 0) {
        hitungGugupBT2 = (jumlahGugupBT2 + 1) / (classBT2 + 17);
      } else {
        hitungGugupBT2 = jumlahGugupBT2 / classBT2;
      }
      print("ini hasil Gugup normal yang Tidak : $hitungGugupNormal");
      print("ini hasil Gugup depresi yang Tidak : $hitungGugupDepresi");
      print("ini hasil Gugup bipolar tipe - 1 yang Tidak : $hitungGugupBT1");
      print("ini hasil Gugup bipolar tipe - 2 yang Tidak : $hitungGugupBT2");
    }

    // Hitung Mengakui Kesalahan
    // Pilihan Ya
    if (_mengakuiKesalahanController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat mengakuiKesalahan yang Ya di dalam dataset
      int jumlahMengakuiKesalahanNormal = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Ya" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat mengakuiKesalahan yang Ya di dalam dataset
      int jumlahMengakuiKesalahanDepresi = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Ya" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat mengakuiKesalahan yang Ya di dalam dataset
      int jumlahMengakuiKesalahanBT1 = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat mengakuiKesalahan yang Ya di dalam dataset
      int jumlahMengakuiKesalahanBT2 = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Mengakui Kesalahan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahMengakuiKesalahanNormal == 0) {
        hitungMengakuiKesalahanNormal =
            (jumlahMengakuiKesalahanNormal + 1) / (classNormal + 17);
      } else {
        hitungMengakuiKesalahanNormal =
            jumlahMengakuiKesalahanNormal / classNormal;
      }
      // Pengecekan Mengakui Kesalahan Depresi
      if (jumlahMengakuiKesalahanDepresi == 0) {
        hitungMengakuiKesalahanDepresi =
            (jumlahMengakuiKesalahanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungMengakuiKesalahanDepresi =
            jumlahMengakuiKesalahanDepresi / classDepresi;
      }
      // Pengecekan Mengakui Kesalahan Bipolar Tipe - 1
      if (jumlahMengakuiKesalahanBT1 == 0) {
        hitungMengakuiKesalahanBT1 =
            (jumlahMengakuiKesalahanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungMengakuiKesalahanBT1 = jumlahMengakuiKesalahanBT1 / classBT1;
      }
      // Pengecekan Mengakui Kesalahan Bipolar Tipe - 2
      if (jumlahMengakuiKesalahanBT2 == 0) {
        hitungMengakuiKesalahanBT2 =
            (jumlahMengakuiKesalahanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungMengakuiKesalahanBT2 = jumlahMengakuiKesalahanBT2 / classBT2;
      }

      print(
          "ini hasil Mengakui Kesalahan normal yang Ya : $hitungMengakuiKesalahanNormal");
      print(
          "ini hasil Mengakui Kesalahan depresi yang Ya : $hitungMengakuiKesalahanDepresi");
      print(
          "ini hasil Mengakui Kesalahan bipolar tipe - 1 yang Ya : $hitungMengakuiKesalahanBT1");
      print(
          "ini hasil Mengakui Kesalahan bipolar tipe - 2 yang Ya : $hitungMengakuiKesalahanBT2");

      // Pilihan Tidak
    } else if (_mengakuiKesalahanController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat mengakuiKesalahan yang Tidak di dalam dataset
      int jumlahMengakuiKesalahanNormal = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Tidak" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat mengakuiKesalahan yang Tidak di dalam dataset
      int jumlahMengakuiKesalahanDepresi = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Tidak" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat mengakuiKesalahan yang Tidak di dalam dataset
      int jumlahMengakuiKesalahanBT1 = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat mengakuiKesalahan yang Tidak di dalam dataset
      int jumlahMengakuiKesalahanBT2 = csvDataList
          .where(
            (element) =>
                element.mengakuiKesalahan == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Mengakui Kesalahan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahMengakuiKesalahanNormal == 0) {
        hitungMengakuiKesalahanNormal =
            (jumlahMengakuiKesalahanNormal + 1) / (classNormal + 17);
      } else {
        hitungMengakuiKesalahanNormal =
            jumlahMengakuiKesalahanNormal / classNormal;
      }
      // Pengecekan Mengakui Kesalahan Depresi
      if (jumlahMengakuiKesalahanDepresi == 0) {
        hitungMengakuiKesalahanDepresi =
            (jumlahMengakuiKesalahanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungMengakuiKesalahanDepresi =
            jumlahMengakuiKesalahanDepresi / classDepresi;
      }
      // Pengecekan Mengakui Kesalahan Bipolar Tipe - 1
      if (jumlahMengakuiKesalahanBT1 == 0) {
        hitungMengakuiKesalahanBT1 =
            (jumlahMengakuiKesalahanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungMengakuiKesalahanBT1 = jumlahMengakuiKesalahanBT1 / classBT1;
      }
      // Pengecekan Mengakui Kesalahan Bipolar Tipe - 2
      if (jumlahMengakuiKesalahanBT2 == 0) {
        hitungMengakuiKesalahanBT2 =
            (jumlahMengakuiKesalahanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungMengakuiKesalahanBT2 = jumlahMengakuiKesalahanBT2 / classBT2;
      }
      print(
          "ini hasil Mengakui Kesalahan normal yang Tidak : $hitungMengakuiKesalahanNormal");
      print(
          "ini hasil Mengakui Kesalahan depresi yang Tidak : $hitungMengakuiKesalahanDepresi");
      print(
          "ini hasil Mengakui Kesalahan bipolar tipe - 1 yang Tidak : $hitungMengakuiKesalahanBT1");
      print(
          "ini hasil Mengakui Kesalahan bipolar tipe - 2 yang Tidak : $hitungMengakuiKesalahanBT2");
    }

    // Hitung Berpikir Berlebihan
    // Pilihan Ya
    if (_berpikirBerlebihanController.text == 'Ya') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat berpikirBerlebihan yang Ya di dalam dataset
      int jumlahBerpikirBerlebihanNormal = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Ya" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat berpikirBerlebihan yang Ya di dalam dataset
      int jumlahBerpikirBerlebihanDepresi = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Ya" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat berpikirBerlebihan yang Ya di dalam dataset
      int jumlahBerpikirBerlebihanBT1 = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Ya" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat berpikirBerlebihan yang Ya di dalam dataset
      int jumlahBerpikirBerlebihanBT2 = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Ya" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Berpikir Berlebihan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahBerpikirBerlebihanNormal == 0) {
        hitungBerpikirBerlebihanNormal =
            (jumlahBerpikirBerlebihanNormal + 1) / (classNormal + 17);
      } else {
        hitungBerpikirBerlebihanNormal =
            jumlahBerpikirBerlebihanNormal / classNormal;
      }
      // Pengecekan Berpikir Berlebihan Depresi
      if (jumlahBerpikirBerlebihanDepresi == 0) {
        hitungBerpikirBerlebihanDepresi =
            (jumlahBerpikirBerlebihanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungBerpikirBerlebihanDepresi =
            jumlahBerpikirBerlebihanDepresi / classDepresi;
      }
      // Pengecekan Berpikir Berlebihan Bipolar Tipe - 1
      if (jumlahBerpikirBerlebihanBT1 == 0) {
        hitungBerpikirBerlebihanBT1 =
            (jumlahBerpikirBerlebihanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungBerpikirBerlebihanBT1 = jumlahBerpikirBerlebihanBT1 / classBT1;
      }
      // Pengecekan Berpikir Berlebihan Bipolar Tipe - 2
      if (jumlahBerpikirBerlebihanBT2 == 0) {
        hitungBerpikirBerlebihanBT2 =
            (jumlahBerpikirBerlebihanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungBerpikirBerlebihanBT2 = jumlahBerpikirBerlebihanBT2 / classBT2;
      }

      print(
          "ini hasil Berpikir Berlebihan normal yang Ya : $hitungBerpikirBerlebihanNormal");
      print(
          "ini hasil Berpikir Berlebihan depresi yang Ya : $hitungBerpikirBerlebihanDepresi");
      print(
          "ini hasil Berpikir Berlebihan bipolar tipe - 1 yang Ya : $hitungBerpikirBerlebihanBT1");
      print(
          "ini hasil Berpikir Berlebihan bipolar tipe - 2 yang Ya : $hitungBerpikirBerlebihanBT2");

      // Pilihan Tidak
    } else if (_berpikirBerlebihanController.text == 'Tidak') {
      //Digunakan Untuk Mencari pasien normal dengan tingkat berpikirBerlebihan yang Tidak di dalam dataset
      int jumlahBerpikirBerlebihanNormal = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Tidak" &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat berpikirBerlebihan yang Tidak di dalam dataset
      int jumlahBerpikirBerlebihanDepresi = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Tidak" &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat berpikirBerlebihan yang Tidak di dalam dataset
      int jumlahBerpikirBerlebihanBT1 = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat berpikirBerlebihan yang Tidak di dalam dataset
      int jumlahBerpikirBerlebihanBT2 = csvDataList
          .where(
            (element) =>
                element.berpikirBerlebihan == "Tidak" &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Berpikir Berlebihan Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahBerpikirBerlebihanNormal == 0) {
        hitungBerpikirBerlebihanNormal =
            (jumlahBerpikirBerlebihanNormal + 1) / (classNormal + 17);
      } else {
        hitungBerpikirBerlebihanNormal =
            jumlahBerpikirBerlebihanNormal / classNormal;
      }
      // Pengecekan Berpikir Berlebihan Depresi
      if (jumlahBerpikirBerlebihanDepresi == 0) {
        hitungBerpikirBerlebihanDepresi =
            (jumlahBerpikirBerlebihanDepresi + 1) / (classDepresi + 17);
      } else {
        hitungBerpikirBerlebihanDepresi =
            jumlahBerpikirBerlebihanDepresi / classDepresi;
      }
      // Pengecekan Berpikir Berlebihan Bipolar Tipe - 1
      if (jumlahBerpikirBerlebihanBT1 == 0) {
        hitungBerpikirBerlebihanBT1 =
            (jumlahBerpikirBerlebihanBT1 + 1) / (classBT1 + 17);
      } else {
        hitungBerpikirBerlebihanBT1 = jumlahBerpikirBerlebihanBT1 / classBT1;
      }
      // Pengecekan Berpikir Berlebihan Bipolar Tipe - 2
      if (jumlahBerpikirBerlebihanBT2 == 0) {
        hitungBerpikirBerlebihanBT2 =
            (jumlahBerpikirBerlebihanBT2 + 1) / (classBT2 + 17);
      } else {
        hitungBerpikirBerlebihanBT2 = jumlahBerpikirBerlebihanBT2 / classBT2;
      }
      print(
          "ini hasil Berpikir Berlebihan normal yang Tidak : $hitungBerpikirBerlebihanNormal");
      print(
          "ini hasil Berpikir Berlebihan depresi yang Tidak : $hitungBerpikirBerlebihanDepresi");
      print(
          "ini hasil Berpikir Berlebihan bipolar tipe - 1 yang Tidak : $hitungBerpikirBerlebihanBT1");
      print(
          "ini hasil Berpikir Berlebihan bipolar tipe - 2 yang Tidak : $hitungBerpikirBerlebihanBT2");
    }

    // Hitung Aktivitas Seksual
    int aktivitasSeksualLevel =
        int.tryParse(_aktivitasSeksualController.text) ?? 0;
    if (aktivitasSeksualLevel >= 1 && aktivitasSeksualLevel <= 10) {
      //Digunakan Untuk Mencari pasien normal dengan tingkat aktivitasSeksual yang di dalam dataset
      int jumlahAktivitasSeksualNormal = csvDataList
          .where(
            (element) =>
                element.aktivitasSeksual == aktivitasSeksualLevel &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat aktivitasSeksual yang di dalam dataset
      int jumlahAktivitasSeksualDepresi = csvDataList
          .where(
            (element) =>
                element.aktivitasSeksual == aktivitasSeksualLevel &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat aktivitasSeksual yang di dalam dataset
      int jumlahAktivitasSeksualBT1 = csvDataList
          .where(
            (element) =>
                element.aktivitasSeksual == aktivitasSeksualLevel &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat aktivitasSeksual yang di dalam dataset
      int jumlahAktivitasSeksualBT2 = csvDataList
          .where(
            (element) =>
                element.aktivitasSeksual == aktivitasSeksualLevel &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Aktivitas Seksual Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahAktivitasSeksualNormal == 0) {
        hitungAktivitasSeksualNormal =
            (jumlahAktivitasSeksualNormal + 1) / (classNormal + 17);
      } else {
        hitungAktivitasSeksualNormal =
            jumlahAktivitasSeksualNormal / classNormal;
      }
      // Pengecekan Aktivitas Seksual Depresi
      if (jumlahAktivitasSeksualDepresi == 0) {
        hitungAktivitasSeksualDepresi =
            (jumlahAktivitasSeksualDepresi + 1) / (classDepresi + 17);
      } else {
        hitungAktivitasSeksualDepresi =
            jumlahAktivitasSeksualDepresi / classDepresi;
      }
      // Pengecekan Aktivitas Seksual Bipolar Tipe - 1
      if (jumlahAktivitasSeksualBT1 == 0) {
        hitungAktivitasSeksualBT1 =
            (jumlahAktivitasSeksualBT1 + 1) / (classBT1 + 17);
      } else {
        hitungAktivitasSeksualBT1 = jumlahAktivitasSeksualBT1 / classBT1;
      }
      // Pengecekan Aktivitas Seksual Bipolar Tipe - 2
      if (jumlahAktivitasSeksualBT2 == 0) {
        hitungAktivitasSeksualBT2 =
            (jumlahAktivitasSeksualBT2 + 1) / (classBT2 + 17);
      } else {
        hitungAktivitasSeksualBT2 = jumlahAktivitasSeksualBT2 / classBT2;
      }

      print(
          "ini hasil Aktivitas Seksual normal yang Ya : $hitungAktivitasSeksualNormal");
      print(
          "ini hasil Aktivitas Seksual depresi yang Ya : $hitungAktivitasSeksualDepresi");
      print(
          "ini hasil Aktivitas Seksual bipolar tipe - 1 yang Ya : $hitungAktivitasSeksualBT1");
      print(
          "ini hasil Aktivitas Seksual bipolar tipe - 2 yang Ya : $hitungAktivitasSeksualBT2");
    }

    // Hitung Konsentrasi
    int konsentrasiLevel = int.tryParse(_konsentrasiController.text) ?? 0;
    if (konsentrasiLevel >= 1 && konsentrasiLevel <= 10) {
      //Digunakan Untuk Mencari pasien normal dengan tingkat konsentrasi yang di dalam dataset
      int jumlahKonsentrasiNormal = csvDataList
          .where(
            (element) =>
                element.konsentrasi == konsentrasiLevel &&
                element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat konsentrasi yang di dalam dataset
      int jumlahKonsentrasiDepresi = csvDataList
          .where(
            (element) =>
                element.konsentrasi == konsentrasiLevel &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat konsentrasi yang di dalam dataset
      int jumlahKonsentrasiBT1 = csvDataList
          .where(
            (element) =>
                element.konsentrasi == konsentrasiLevel &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat konsentrasi yang di dalam dataset
      int jumlahKonsentrasiBT2 = csvDataList
          .where(
            (element) =>
                element.konsentrasi == konsentrasiLevel &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Konsentrasi Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahKonsentrasiNormal == 0) {
        hitungKonsentrasiNormal =
            (jumlahKonsentrasiNormal + 1) / (classNormal + 17);
      } else {
        hitungKonsentrasiNormal = jumlahKonsentrasiNormal / classNormal;
      }
      // Pengecekan Konsentrasi Depresi
      if (jumlahKonsentrasiDepresi == 0) {
        hitungKonsentrasiDepresi =
            (jumlahKonsentrasiDepresi + 1) / (classDepresi + 17);
      } else {
        hitungKonsentrasiDepresi = jumlahKonsentrasiDepresi / classDepresi;
      }
      // Pengecekan Konsentrasi Bipolar Tipe - 1
      if (jumlahKonsentrasiBT1 == 0) {
        hitungKonsentrasiBT1 = (jumlahKonsentrasiBT1 + 1) / (classBT1 + 17);
      } else {
        hitungKonsentrasiBT1 = jumlahKonsentrasiBT1 / classBT1;
      }
      // Pengecekan Konsentrasi Bipolar Tipe - 2
      if (jumlahKonsentrasiBT2 == 0) {
        hitungKonsentrasiBT2 = (jumlahKonsentrasiBT2 + 1) / (classBT2 + 17);
      } else {
        hitungKonsentrasiBT2 = jumlahKonsentrasiBT2 / classBT2;
      }

      print("ini hasil Konsentrasi normal yang Ya : $hitungKonsentrasiNormal");
      print(
          "ini hasil Konsentrasi depresi yang Ya : $hitungKonsentrasiDepresi");
      print(
          "ini hasil Konsentrasi bipolar tipe - 1 yang Ya : $hitungKonsentrasiBT1");
      print(
          "ini hasil Konsentrasi bipolar tipe - 2 yang Ya : $hitungKonsentrasiBT2");
    }

    // Hitung Optimis
    int optimisLevel = int.tryParse(_optimisController.text) ?? 0;
    if (optimisLevel >= 1 && optimisLevel <= 10) {
      //Digunakan Untuk Mencari pasien normal dengan tingkat optimis yang di dalam dataset
      int jumlahOptimisNormal = csvDataList
          .where(
            (element) =>
                element.optimis == optimisLevel && element.diagnosa == "Normal",
          )
          .length;
      //Digunakan Untuk Mencari pasien depresi dengan tingkat optimis yang di dalam dataset
      int jumlahOptimisDepresi = csvDataList
          .where(
            (element) =>
                element.optimis == optimisLevel &&
                element.diagnosa == "Depresi",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 1 dengan tingkat optimis yang di dalam dataset
      int jumlahOptimisBT1 = csvDataList
          .where(
            (element) =>
                element.optimis == optimisLevel &&
                element.diagnosa == "Bipolar Tipe-1",
          )
          .length;
      //Digunakan Untuk Mencari pasien Bipolar Tipe - 2 dengan tingkat optimis yang di dalam dataset
      int jumlahOptimisBT2 = csvDataList
          .where(
            (element) =>
                element.optimis == optimisLevel &&
                element.diagnosa == "Bipolar Tipe-2",
          )
          .length;

      // Pengecekan Laplace Correction apabila ada output yang nol
      // Pengecekan apakah Jumlah Optimis Kategori Normal bernilai 0, jika iya masukkan laplace correction
      if (jumlahOptimisNormal == 0) {
        hitungOptimisNormal = (jumlahOptimisNormal + 1) / (classNormal + 17);
      } else {
        hitungOptimisNormal = jumlahOptimisNormal / classNormal;
      }
      // Pengecekan Optimis Depresi
      if (jumlahOptimisDepresi == 0) {
        hitungOptimisDepresi = (jumlahOptimisDepresi + 1) / (classDepresi + 17);
      } else {
        hitungOptimisDepresi = jumlahOptimisDepresi / classDepresi;
      }
      // Pengecekan Optimis Bipolar Tipe - 1
      if (jumlahOptimisBT1 == 0) {
        hitungOptimisBT1 = (jumlahOptimisBT1 + 1) / (classBT1 + 17);
      } else {
        hitungOptimisBT1 = jumlahOptimisBT1 / classBT1;
      }
      // Pengecekan Optimis Bipolar Tipe - 2
      if (jumlahOptimisBT2 == 0) {
        hitungOptimisBT2 = (jumlahOptimisBT2 + 1) / (classBT2 + 17);
      } else {
        hitungOptimisBT2 = jumlahOptimisBT2 / classBT2;
      }

      print("ini hasil Optimis normal yang Ya : $hitungOptimisNormal");
      print("ini hasil Optimis depresi yang Ya : $hitungOptimisDepresi");
      print("ini hasil Optimis bipolar tipe - 1 yang Ya : $hitungOptimisBT1");
      print("ini hasil Optimis bipolar tipe - 2 yang Ya : $hitungOptimisBT2");
    }

    // Periksa setiap variabel dan cari tahu apakah ada yang null
    if (hitungKesedihanNormal == null) print('hitungKesedihanNormal is null');
    if (hitungEuforiaNormal == null) print('hitungEuforiaNormal is null');
    if (hitungLelahNormal == null) print('hitungLelahNormal is null');
    if (hitungGangguanTidurNormal == null)
      print('hitungGangguanTidurNormal is null');
    if (hitungAyunanMoodNormal == null) print('hitungAyunanMoodNormal is null');
    if (hitungBunuhDiriNormal == null) print('hitungBunuhDiriNormal is null');
    if (hitungAnoreksiaNormal == null) print('hitungAnoreksiaNormal is null');
    if (hitungRasaHormatNormal == null) print('hitungRasaHormatNormal is null');
    if (hitungMemintaPenjelasanNormal == null)
      print('hitungMemintaPenjelasanNormal is null');
    if (hitungResponAgresifNormal == null)
      print('hitungResponAgresifNormal is null');
    if (hitungAcuhBeranjakNormal == null)
      print('hitungAcuhBeranjakNormal is null');
    if (hitungGugupNormal == null) print('hitungGugupNormal is null');
    if (hitungMengakuiKesalahanNormal == null)
      print('hitungMengakuiKesalahanNormal is null');
    if (hitungBerpikirBerlebihanNormal == null)
      print('hitungBerpikirBerlebihanNormal is null');
    if (hitungAktivitasSeksualNormal == null)
      print('hitungAktivitasSeksualNormal is null');
    if (hitungKonsentrasiNormal == null)
      print('hitungKonsentrasiNormal is null');
    if (hitungOptimisNormal == null) print('hitungOptimisNormal is null');
    if (classNormal == null) print('classNormal is null');

    // Hitung Akhir
    final hitungAkhirNormal = (hitungKesedihanNormal! *
        hitungEuforiaNormal! *
        hitungLelahNormal! *
        hitungGangguanTidurNormal! *
        hitungAyunanMoodNormal! *
        hitungBunuhDiriNormal! *
        hitungAnoreksiaNormal! *
        hitungRasaHormatNormal! *
        hitungMemintaPenjelasanNormal! *
        hitungResponAgresifNormal! *
        hitungAcuhBeranjakNormal! *
        hitungGugupNormal! *
        hitungMengakuiKesalahanNormal! *
        hitungBerpikirBerlebihanNormal! *
        hitungAktivitasSeksualNormal! *
        hitungKonsentrasiNormal! *
        hitungOptimisNormal! *
        classNormal);

    final hitungAkhirDepresi = (hitungKesedihanDepresi! *
        hitungEuforiaDepresi! *
        hitungLelahDepresi! *
        hitungGangguanTidurDepresi! *
        hitungAyunanMoodDepresi! *
        hitungBunuhDiriDepresi! *
        hitungAnoreksiaDepresi! *
        hitungRasaHormatDepresi! *
        hitungMemintaPenjelasanDepresi! *
        hitungResponAgresifDepresi! *
        hitungAcuhBeranjakDepresi! *
        hitungGugupDepresi! *
        hitungMengakuiKesalahanDepresi! *
        hitungBerpikirBerlebihanDepresi! *
        hitungAktivitasSeksualDepresi! *
        hitungKonsentrasiDepresi! *
        hitungOptimisDepresi! *
        classDepresi);

    final hitungAkhirBT1 = (hitungKesedihanBT1! *
        hitungEuforiaBT1! *
        hitungLelahBT1! *
        hitungGangguanTidurBT1! *
        hitungAyunanMoodBT1! *
        hitungBunuhDiriBT1! *
        hitungAnoreksiaBT1! *
        hitungRasaHormatBT1! *
        hitungMemintaPenjelasanBT1! *
        hitungResponAgresifBT1! *
        hitungAcuhBeranjakBT1! *
        hitungGugupBT1! *
        hitungMengakuiKesalahanBT1! *
        hitungBerpikirBerlebihanBT1! *
        hitungAktivitasSeksualBT1! *
        hitungKonsentrasiBT1! *
        hitungOptimisBT1! *
        classBT1);

    final hitungAkhirBT2 = (hitungKesedihanBT2! *
        hitungEuforiaBT2! *
        hitungLelahBT2! *
        hitungGangguanTidurBT2! *
        hitungAyunanMoodBT2! *
        hitungBunuhDiriBT2! *
        hitungAnoreksiaBT2! *
        hitungRasaHormatBT2! *
        hitungMemintaPenjelasanBT2! *
        hitungResponAgresifBT2! *
        hitungAcuhBeranjakBT2! *
        hitungGugupBT2! *
        hitungMengakuiKesalahanBT2! *
        hitungBerpikirBerlebihanBT2! *
        hitungAktivitasSeksualBT2! *
        hitungKonsentrasiBT2! *
        hitungOptimisBT2! *
        classBT2);

    print("ini hasil hitung Normal : $hitungAkhirNormal");
    print("ini hasil hitung Depresi : $hitungAkhirDepresi");
    print("ini hasil hitung Bipolar Tipe-1 : $hitungAkhirBT1");
    print("ini hasil hitung Bipolar Tipe-2 : $hitungAkhirBT2");

    String diagnosa = '';

    // Pencarian Kemungkinan Paling Besar
    if (hitungAkhirNormal > hitungAkhirDepresi &&
        hitungAkhirNormal > hitungAkhirBT1 &&
        hitungAkhirNormal > hitungAkhirBT2) {
      diagnosa = 'Normal';
      print('Anda di diagnosa "Normal"');
    } else if (hitungAkhirDepresi > hitungAkhirNormal &&
        hitungAkhirDepresi > hitungAkhirBT1 &&
        hitungAkhirDepresi > hitungAkhirBT2) {
      diagnosa = 'Depresi';
      print('Anda di diagnosa "Depresi"');
    } else if (hitungAkhirBT1 > hitungAkhirNormal &&
        hitungAkhirBT1 > hitungAkhirDepresi &&
        hitungAkhirBT1 > hitungAkhirBT2) {
      diagnosa = 'Bipolar Tipe-1';
      print('Anda di diagnosa "Bipolar Tipe-1"');
    } else if (hitungAkhirBT2 > hitungAkhirNormal &&
        hitungAkhirBT2 > hitungAkhirDepresi &&
        hitungAkhirBT2 > hitungAkhirBT1) {
      diagnosa = 'Bipolar Tipe-2';
      print('Anda di diagnosa "Bipolar Tipe-2"');
    }

    String message = 'Anda di diagnosa $diagnosa';
    Future<void> saveHistory(String name, String diagnose) async {
      final riwayat = ParseObject('riwayat')
        ..set('name', name)
        ..set('diagnose', '$diagnosa');
      await riwayat.save();
    }

    void addHistory() {
      final String name = historyController.text.trim();
      if (name.isEmpty) {
        SnackBar(
          content: Text("Nama Tidak Boleh Kosong"),
          duration: Duration(seconds: 2),
        );
        return;
      }

      final String diagnose = "$diagnosa";
      saveHistory(name, diagnose);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hasil Prediksi'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                }));
              },
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () {
                addHistory();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => History(),
                    ));
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils("Konsultasi"),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 24,
              ),
              question("Masukkan Nama Anda"),
              TextField(
                autocorrect: true,
                controller: historyController,
                decoration: InputDecoration(contentPadding: EdgeInsets.all(12)),
              ),
              SizedBox(
                height: 10,
              ),
              question(
                  "1. Seberapa sering anda merasa kesedihan belakangan ini?"),
              const SizedBox(
                height: 2,
              ),
              DropdownButton<String?>(
                  hint: const Text("Jawaban Anda"),
                  value: _valKesedihan,
                  onChanged: (value) {
                    setState(() {
                      _valKesedihan = value;
                      _kesedihanController.text = value!;
                    });
                  },
                  isExpanded: true,
                  items: _listKesedihan
                      .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                            child: Text(e.toString()),
                            value: e,
                          ))
                      .toList()),
              SizedBox(
                height: 12,
              ),
              const Text(
                '2. Seberapa sering anda merasakan euphoria belakangan ini',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: const Text("Jawaban Anda"),
                    value: _valEuforia,
                    onChanged: (value) {
                      setState(() {
                        _valEuforia = value;
                        _euforiaController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listEuforia
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '3. Seberapa sering anda merasa lelah belakangan ini',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valLelah,
                    onChanged: (value) {
                      setState(() {
                        _valLelah = value;
                        _lelahController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listLelah
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '4. Seberapa sering anda mengalami gangguan tidur belakangan ini?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valGangguanTidur,
                    onChanged: (value) {
                      setState(() {
                        _valGangguanTidur = value;
                        _gangguanTidurController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listGangguanTidur
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '5. Apakah belakangan ini anda merasa perubahan suasana hati yang cepat atau ayunan mood?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valAyunanMood,
                    onChanged: (value) {
                      setState(() {
                        _valAyunanMood = value;
                        _ayunanMoodController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listAyunanMood
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '6. Apakah belakangan ini anda memiliki pikiran untuk melakukan tindakan yang berbahaya terhadap diri sendiri atau bunuh diri?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valBunuhDiri,
                    onChanged: (value) {
                      setState(() {
                        _valBunuhDiri = value;
                        _bunuhDiriController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listBunuhDiri
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '7. Apakah anda merasa khawatir tentang berat badan atau makanan belakangan ini atau anoreksia?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valAnoreksia,
                    onChanged: (value) {
                      setState(() {
                        _valAnoreksia = value;
                        _anoreksiaController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listAnoreksia
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '8. Apakah anda merasa bahwa rasa hormat terhadap diri sendiri atau orang lain penting bagi anda dalam interaksi sehari-hari?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valRasaHormat,
                    onChanged: (value) {
                      setState(() {
                        _valRasaHormat = value;
                        _rasaHormatController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listRasaHormat
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '9. Apakah anda sering merasa perlu meminta penjelasan tambahan tentang suatu hal untuk memahaminya lebih baik?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valMemintaPenjelasan,
                    onChanged: (value) {
                      setState(() {
                        _valMemintaPenjelasan = value;
                        _memintaPenjelasanController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listMemintaPenjelasan
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '10. Apakah anda sering merespons situasi dengan reaksi agresif dalam interaksi sehari-hari?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valResponAgresif,
                    onChanged: (value) {
                      setState(() {
                        _valResponAgresif = value;
                        _responAgresifController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listResponAgresif
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '11. Apakah anda sering merasa acuh dan cenderung untuk meninggalkan situasi atau peristiwa tanpa banyak perhatian?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valAcuhBeranjak,
                    onChanged: (value) {
                      setState(() {
                        _valAcuhBeranjak = value;
                        _acuhBeranjakController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listAcuhBeranjak
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '12. Apakah anda sering merasa gugup atau cemas dalam situasi sosial atau di sekitar orang lain?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valGugup,
                    onChanged: (value) {
                      setState(() {
                        _valGugup = value;
                        _gugupController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listGugup
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '13. Apakah anda merasa penting untuk mengakui kesalahan anda kepada orang lain dan mengambil tanggung jawab atas tindakan anda?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valMengakuiKesalahan,
                    onChanged: (value) {
                      setState(() {
                        _valMengakuiKesalahan = value;
                        _mengakuiKesalahanController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listMengakuiKesalahan
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '14. Apakah anda sering merasa cemas atau khawatir karena terlalu banyak memikirkan atau memperbesar suatu masalah?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valBerpikirBerlebihan,
                    onChanged: (value) {
                      setState(() {
                        _valBerpikirBerlebihan = value;
                        _berpikirBerlebihanController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listBerpikirBerlebihan
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '15. Pada skala 1 hingga 10, seberapa sering anda melakukan aktivitas seksual dalam periode waktu tertentu?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valAktivitasSeksual,
                    onChanged: (value) {
                      setState(() {
                        _valAktivitasSeksual = value;
                        _aktivitasSeksualController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listAktivitasSeksual
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '16. Pada skala 1 hingga 10, seberapa tinggi tingkat konsentrasi anda ketika melakukan tugas atau aktivitas yang membutuhkan fokus?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valKonsentrasi,
                    onChanged: (value) {
                      setState(() {
                        _valKonsentrasi = value;
                        _konsentrasiController.text = value!;
                      });
                    },
                    isExpanded: true,
                    items: _listKonsentrasi
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              SizedBox(
                height: 12,
              ),
              const Text(
                '17. Pada skala 1 hingga 10, seberapa sering anda merasa optimis tentang kemungkinan hasil yang baik dalam situasi tertentu?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  // Ubah nilai radius sesuai kebutuhan
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1,
                  // ),
                ),
                child: DropdownButton<String?>(
                    hint: Text("Jawaban Anda"),
                    value: _valOptimis,
                    onChanged: (value) {
                      setState(() {
                        _valOptimis = value;
                        _optimisController.text = value!;
                        print(
                            "Isi dari _optimisController.text: ${_optimisController.text}");
                      });
                    },
                    isExpanded: true,
                    items: _listOptimis
                        .map<DropdownMenuItem<String?>>((e) => DropdownMenuItem(
                              child: Text(e.toString()),
                              value: e,
                            ))
                        .toList()),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _cekPertanyaan(context);
                },
                child: const Text('Lanjutkan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cekPertanyaan(BuildContext context) {
    if (_valKesedihan == null ||
        _valEuforia == null ||
        _valLelah == null ||
        _valGangguanTidur == null ||
        _valAyunanMood == null ||
        _valBunuhDiri == null ||
        _valAnoreksia == null ||
        _valRasaHormat == null ||
        _valMemintaPenjelasan == null ||
        _valResponAgresif == null ||
        _valAcuhBeranjak == null ||
        _valGugup == null ||
        _valMengakuiKesalahan == null ||
        _valBerpikirBerlebihan == null ||
        _valAktivitasSeksual == null ||
        _valKonsentrasi == null ||
        _valOptimis == null) {
      _showPeringatan(context);
    } else {
      hitungPrediksi();
    }
  }

  void _showPeringatan(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: const Text('Tolong isi semua pertanyaan terlebih dahulu.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showUserInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Inputan Pengguna'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1.  Kesedihan: $_valKesedihan'),
              Text('2.  Euforia: $_valEuforia'),
              Text('3.  Lelah: $_valLelah'),
              Text('4.  Gangguan Tidur: $_valGangguanTidur'),
              Text('5.  Ayunan Mood: $_valAyunanMood'),
              Text('6.  Pikiran Untuk Bunuh Diri: $_valBunuhDiri'),
              Text('7.  Anoreksia: $_valAnoreksia'),
              Text('8.  Rasa Hormat: $_valRasaHormat'),
              Text('9.  Meminta Penjelasan: $_valMemintaPenjelasan'),
              Text('10. Respon Agresif: $_valResponAgresif'),
              Text('11. Acuh dan Beranjak: $_valAcuhBeranjak'),
              Text('12. Gugup: $_valGugup'),
              Text('13. Mengakui Kesalahan: $_valMengakuiKesalahan'),
              Text('14. Berpikir Secara Berlebihan: $_valBerpikirBerlebihan'),
              Text('15. Aktivitas Seksual: $_valAktivitasSeksual'),
              Text('16. Konsentrasi: $_valKonsentrasi'),
              Text('17. Optimis: $_valOptimis'),
              Text(
                  "Nilai dari optimis adalah ${_optimisController.text.toString()}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}

Future<void> saveHistory(String name, String diagnose) async {
  final riwayat = ParseObject('riwayat')
    ..set('name', name)
    ..set('diagnose', 'Normal');
  await riwayat.save();
}
