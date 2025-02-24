import 'package:flutter/material.dart';
import 'package:movie_finder/pages/movie_details_page.dart';
import '../services/api_service.dart';

class SearchResultsPage extends StatefulWidget {
  final String query;

  const SearchResultsPage({super.key, required this.query});

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  List<dynamic> _movies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState(); // inicializacao do estado
    _fetchMovies(); // busca os filmes apos carregar
  }

  // request API, armazena filmes encontrados e atualiza a tela
  void _fetchMovies() async {
    try {
      // request API com base na query (o que foi digitado)
      final movies = await ApiService().fetchMovies(widget.query);

      // ordena os filmes encontrados em ano e ordem alfabetica
      movies.sort((a, b) {
      String dateA = a['release_date'] ?? '0000-00-00';
      String dateB = b['release_date'] ?? '0000-00-00';

      int yearA = int.tryParse(dateA.split('-')[0]) ?? 0;
      int yearB = int.tryParse(dateB.split('-')[0]) ?? 0;

      // ordena os filmes em ordem decrescente
      if (yearA != yearB) {
        return yearB.compareTo(yearA);
      }
      // ordena os filmes em A-Z caso os anos sejam iguais
      return (a['title'] ?? '').compareTo(b['title'] ?? '');
    });
      // atualiza o estado com filmes na lista e confirma que todos carregaram
      setState(() {
        _movies = movies;
        _isLoading = false;
      });
    } catch (e) { // exception colocado por formalidade (aparece somente um erro no console)
      print("Erro ao buscar filmes: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0e17),
      appBar: AppBar(
        title: Text(
          "Resultados para: \"${widget.query}\"",
          style: const TextStyle(
            fontSize: 25,
            fontStyle: FontStyle.normal,
            color: Color(0xFFfffffe),

          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFf25f4c),
      ),
      // enquanto os filmes nao forem totalmente lidos, um icone de carregamento aparece
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // icone de carregamento
          : _movies.isEmpty
              ? const Center(child: Text("Nenhum filme encontrado.")) // caso nao tenha encontrado nada
                // exibe os filmes a partir do ListView
              : ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    final movie = _movies[index];
                    final String title = movie['title'] ?? 'Sem título';
                    final String releaseYear = movie['release_date'] ?.split('-')[0] ?? 'Desconhecido';
                    final String posterPath = movie['poster_path'] ?? '';

                    // caixa de decoracao que contem capa, nome e ano do filme
                    return Card(
                      color: const Color.fromARGB(255, 40, 36, 36),
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: posterPath.isNotEmpty
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/w92$posterPath", // exibe capa caso tenha
                                  width: 50,
                                  height: 75,
                                  fit: BoxFit.cover,
                                ),
                            )
                            : const Icon(Icons.movie, size: 50), // caso nao tenha capa, icone padrao de filme
                        title: Text(
                          title, 
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFfffffe),
                            ),
                          ),
                        subtitle: Text(
                          "Ano: $releaseYear",
                          style: const TextStyle(
                            color: Color(0xFFfffffe),
                          ),
                        ),
                        onTap: () {
                          // quando o filme for selecionado, context e o filme vao para o movie_details_page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsPage(movie: movie)
                            )
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
