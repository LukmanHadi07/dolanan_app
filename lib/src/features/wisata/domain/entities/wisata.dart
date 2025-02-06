import 'package:equatable/equatable.dart';

class Wisata extends Equatable {
  final int? id;
  final String? nameWisata;
  final String? alamatWisata;
  final String? deskripsiWisata;
  final String? hargaWisata;
  final String? gambarWisata;
  final int? adminId;
  final int? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Wisata({
    this.id,
    this.nameWisata,
    this.alamatWisata,
    this.deskripsiWisata,
    this.hargaWisata,
    this.gambarWisata,
    this.adminId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Wisata.fromJson(Map<String, dynamic> json) => Wisata(
        id: json["id"],
        nameWisata: json["name_wisata"],
        alamatWisata: json["alamat_wisata"],
        deskripsiWisata: json["deskripsi_wisata"],
        hargaWisata: json["harga_wisata"],
        gambarWisata: json["gambar_wisata"],
        adminId: json["admin_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_wisata": nameWisata,
        "alamat_wisata": alamatWisata,
        "deskripsi_wisata": deskripsiWisata,
        "harga_wisata": hargaWisata,
        "gambar_wisata": gambarWisata,
        "admin_id": adminId,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        nameWisata,
        alamatWisata,
        deskripsiWisata,
        hargaWisata,
        gambarWisata,
        adminId,
        categoryId,
        createdAt,
        updatedAt,
      ];
}
