import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDateTime(Timestamp firestoreTimestamp) {
  // Konversi Timestamp menjadi objek DateTime
  DateTime dateTime = firestoreTimestamp.toDate();

  // Membuat format tanggal dengan bahasa Indonesia
  DateFormat indonesianDateFormat = DateFormat('EEEE, d MMMM y HH:mm', 'id');

  // Memformat DateTime ke dalam string dengan format yang diinginkan
  String formattedDate = indonesianDateFormat.format(dateTime);
  return formattedDate; // Mengembalikan string dengan format tanggal yang diinginkan
}




    
  // await initializeDateFormatting(
  //     'id'); // Menjalankan inisialisasi data lokalisasi untuk Bahasa Indonesia ('id')

  // DateTime dateTime = DateTime.now(); // Mendapatkan tanggal dan waktu saat ini

  // // Membuat format tanggal dengan bahasa Indonesia
  // DateFormat indonesianDateFormat = DateFormat('EEEE, d MMMM y HH:mm', 'id');

  // String formattedDate = indonesianDateFormat.format(dateTime);
  // print({
  //   formattedDate,
  //   dateTime,
  // });
// }