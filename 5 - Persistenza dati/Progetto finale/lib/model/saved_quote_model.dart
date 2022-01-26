class SavedQuoteModel {
  final int id;
  final String text;

  const SavedQuoteModel({
    required this.id,
    required this.text,
  });

  factory SavedQuoteModel.fromRecord(Map<String, dynamic> data) {
    final id = data["id"];
    final text = data["text"];

    return SavedQuoteModel(
      id: id,
      text: text,
    );
  }
}
