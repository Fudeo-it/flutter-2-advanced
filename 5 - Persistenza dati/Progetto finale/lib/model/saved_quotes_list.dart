import 'package:get_it/get_it.dart';
import 'package:persistenza_dati/model/saved_quote_model.dart';
import 'package:persistenza_dati/repository/savedQuotesRepository.dart';

class SavedQuotesList {
  List<SavedQuoteModel> quotes = [];

  Future<void> initialize() async {
    quotes = await GetIt.I.get<SavedQuotesRepository>().all();
  }

  Future<void> create(String text) async {
    final quote = await GetIt.I.get<SavedQuotesRepository>().create(text);
    quotes.insert(0, quote);
  }

  Future<void> delete(SavedQuoteModel savedQuoteModel) async {
    await GetIt.I.get<SavedQuotesRepository>().delete(savedQuoteModel);
    quotes.removeWhere((it) => it.id == savedQuoteModel.id);
  }

  bool containsQuote(String text) {
    return quotes.any((it) => it.text == text);
  }
}
