import 'package:flutter/material.dart';
import '../../../../domain/entities/barbershop.dart';
import '../../../../domain/repositories/barbershop_repository.dart';
import '../widgets/barbershop_card.dart';

class SearchDialog extends StatefulWidget {
  final BarbershopRepository repository;

  const SearchDialog({Key? key, required this.repository}) : super(key: key);

  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  List<Barbershop> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  Future<void> performSearch(String query) async {
    final results = await widget.repository.searchBarbershops(query);
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search barber's, haircut ser...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: performSearch,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: searchResults.isEmpty && _searchController.text.isEmpty
                  ? Center(child: Text('Start typing to search...'))
                  : searchResults.isEmpty
                  ? Center(child: Text('No results found'))
                  : ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return BarbershopCard(
                    barbershop: searchResults[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
