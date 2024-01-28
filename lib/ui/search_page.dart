import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController(text: "");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cari Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1),
                  borderRadius:
                      BorderRadius.circular(16)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1),
                  borderRadius:
                      BorderRadius.circular(16)),
                hintText: "Cari Restaurant Favorite",
                hintStyle: const TextStyle(
                  color: Colors.grey
                )
              ),
              controller: searchController,
            ),
            const SizedBox(height: 16,),
            Expanded(
              child: Center()
            )
          ],
        ),
      ),
    );
  }
}