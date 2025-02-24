import 'package:flutter/material.dart';

class MovieDetailsPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0f0e17),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf25f4c),
        // título
        title: Text(
          movie['title'] ?? 'Sem título',
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFFfffffe),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // contra-capa do filme
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: movie['backdrop_path'] != null
                        ? DecorationImage(
                            image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500${movie['backdrop_path']}",
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.black,
                  ),
                ),
                // titulo do filme
                Container(
                  height: 250,
                  color: Colors.black54,
                ),
                Positioned(
                  bottom: 20,
                  left: 16,
                  child: Text(
                    movie['title'] ?? 'Sem título',
                    style: const TextStyle(
                      color: Color(0xFFfffffe),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4.0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // capa do filme
                  Center(
                    child: movie['poster_path'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
                              height: 350,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.movie, size: 100, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  // ano de lancamento
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ano: ${movie['release_date']?.split('-')[0] ?? 'Desconhecido'}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFfffffe),
                        ),
                      ),
                      // votos medios
                      Row(
                        children: [
                          const Icon(Icons.star, color: Color(0xFFff8906)),
                          Text(
                            " ${movie['vote_average']?.toStringAsFixed(1) ?? 'N/A'} / 10",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFFfffffe),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // sinopse do filme
                  const Text(
                    "Sinopse:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFfffffe),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie['overview'] ?? 'Sem descrição disponível.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFfffffe),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
