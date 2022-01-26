import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:persistenza_dati/model/saved_quote_model.dart';
import 'package:persistenza_dati/model/saved_quotes_list.dart';
import 'package:persistenza_dati/repository/quotes_repository.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<String> mainQuote;
  late SavedQuotesList savedQuotes;

  @override
  void initState() {
    super.initState();

    setState(() {
      mainQuote = QuotesRepository.get();
      savedQuotes = SavedQuotesList()
        ..initialize().then(
          (_) => setState(() {}),
        );
    });
  }

  void reloadMainQuote() {
    setState(() {
      mainQuote = QuotesRepository.get();
    });
  }

  void createQuote(String text) {
    savedQuotes.create(text).then((_) => setState(() {}));
  }

  void deleteQuote(SavedQuoteModel savedQuoteModel) {
    savedQuotes.delete(savedQuoteModel).then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          sectionMainQuote(),
          sectionListSavedQuotes(),
        ],
      ),
    );
  }

  Widget sectionMainQuote() => SliverToBoxAdapter(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(20),
          child: FutureBuilder<String>(
            future: mainQuote,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        snapshot.data!,
                        maxLines: 10,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => reloadMainQuote(),
                            icon: Icon(
                              Icons.replay,
                              size: 40,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          SizedBox(width: 8),
                          IconButton(
                            onPressed: () => createQuote(snapshot.data!),
                            icon: Icon(
                              savedQuotes.containsQuote(snapshot.data!) ? Icons.favorite : Icons.favorite_border,
                              size: 40,
                              color: savedQuotes.containsQuote(snapshot.data!) ? Colors.red : Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );

  Widget sectionListSavedQuotes() => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => GestureDetector(
            onDoubleTap: () => deleteQuote(savedQuotes.quotes[index]),
            child: Container(
              height: 250,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors[index % colors.length],
              ),
              child: AutoSizeText(
                savedQuotes.quotes[index].text,
                maxLines: 7,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          childCount: savedQuotes.quotes.length,
        ),
      );
}

final colors = [
  Color(0xFF66ffbe),
  Color(0xFFfff267),
  Color(0xFFffb968),
  Color(0xFF80e0ff),
  Color(0xFF9980ff),
  Color(0xFFd680ff),
  Color(0xFFff7fb5),
];
