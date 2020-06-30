import 'package:intl/intl.dart';

class Operasional {
    int id;
    int id_hari;

    Operasional({this.id,this.id_hari});

	factory Operasional.fromJson(Map<String, dynamic> parsedJson) {
        return Operasional(
            id: parsedJson['id'],
            id_hari: parsedJson['id_hari']
        );
    }

    String getHari() {
        if (this.id_hari.toString() == '1') {
            return 'Senin';
        } else if (this.id_hari.toString() == '2') {
            return 'Selasa';
        } else if (this.id_hari.toString() == '3') {
            return 'Rabu';
        } else if (this.id_hari.toString() == '4') {
            return 'Kamis';
        } else if (this.id_hari.toString() == '5') {
            return 'Jumat';
        } else if (this.id_hari.toString() == '6') {
            return 'Sabtu';
        } else if (this.id_hari.toString() == '7') {
            return 'Minggu';
        } else {
            return null;
        }
    }
}