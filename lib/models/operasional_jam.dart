class OperasionalJam {
    int id_operasional;
    String jam_buka;
    String jam_tutup;

    OperasionalJam({
        this.id_operasional,
        this.jam_buka,
        this.jam_tutup,
    });

    bool validate() {
        if (this.id_operasional != null && this.jam_buka != null && this.jam_tutup != null) {
            return true;
        } else {
            return false;
        }
    }
}