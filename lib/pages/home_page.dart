import 'package:flutter/material.dart';
import 'package:movie_finder/pages/search_results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  // funcao que le o que foi escrito pelo usuario e leva para a proxima pagina
  void _searchMovies() {
    String query = _searchController.text.trim(); // trata o que foi digitado
    if (query.isNotEmpty) { // verifica se algo foi digitado
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsPage(query: query), // context e query são levados para search_results_page
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0e17),
      appBar: AppBar(
        // nome do app
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.slow_motion_video_outlined, color: Color(0xFFfffffe),),
            Text(
              " Movie Finder",
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.normal,
                color: Color(0xFFfffffe),
              ),
            ),
          ],
        ),
        
        centerTitle: true,
        backgroundColor: const Color(0xFFf25f4c),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Busque um Filme!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFfffffe),
                ),
              ),
              const SizedBox(height: 20),
              // caixa de escrita para a busca
              Container(
                width: 500,
                decoration: BoxDecoration(
                  color: const Color(0xFFfffffe),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Digite o nome do filme...",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    prefixIcon: Icon(Icons.search, color: Color(0xFFa7a9be)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // botao de busca
              ElevatedButton(
                onPressed: _searchMovies,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFff8906),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  "Buscar",
                  style: TextStyle(
                    fontSize: 19,
                    color: Color(0xFFfffffe),
                    fontStyle: FontStyle.normal
                  ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}