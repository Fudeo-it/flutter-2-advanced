import 'package:flutter/material.dart';
import 'package:sliver/model/shows.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          appBar(),
          ...shows(),
          footer(),
        ],
      ),
    );
  }

  Widget appBar() => SliverAppBar(
        expandedHeight: 200,
        backgroundColor: Colors.black,
        title: Text("Netflix"),
        centerTitle: true,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Colors.white10,
          ),
        ),
      );

  List<Widget> shows() => sliverShows.map((sliverShow) {
        if (sliverShow.displayMode == SliverShowDisplayMode.list) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                height: 150,
                color: Colors.white10,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      sliverShow.shows[index].label,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit turpis ac arcu placerat lobortis.",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              childCount: sliverShow.shows.length,
            ),
          );
        } else {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.white10,
                child: Center(
                    child: Text(
                  sliverShow.shows[index].label,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
              childCount: sliverShow.shows.length,
            ),
          );
        }
      }).toList();

  Widget footer() => SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 16),
        sliver: SliverToBoxAdapter(
          child: Center(
            child: Text(
              "Tutti i copyright a Netflix",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      );
}
