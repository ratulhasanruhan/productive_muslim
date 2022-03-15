import 'package:flutter/material.dart';

class QuranSearchDelegate extends SearchDelegate{
  List<String> data;
  QuranSearchDelegate({ required this.data});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: Icon(Icons.clear)
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> match = [];
    for(var dd in data){
      if(dd.toString().toLowerCase().contains(query.toLowerCase())){
        match.add(dd);
      }
    }
    return ListView.builder(
      itemCount: match.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(match[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchSuggest = [];
    for(var dd in data){
      if(dd.toString().toLowerCase().contains(query.toLowerCase())){
        matchSuggest.add(dd);
      }
    }
    return ListView.builder(
      itemCount: matchSuggest.length,
      itemBuilder: (context, index){
        return ListTile(
          title: Text(matchSuggest[index]),
        );
      },
    );
  }

}