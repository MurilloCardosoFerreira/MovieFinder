import 'dart:convert'; 
import 'package:http/http.dart' as http; 

class ApiService {
  // token de leitura da API
  final String bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNWZmMGMwMjhhZjQ0MzI5MmZlYWVkMGQ0MTJiNjA4YSIsIm5iZiI6MTczOTQwMTcyMi4yNjgsInN1YiI6IjY3YWQyOWZhMjM3NWJmYzVmNmQwYjU3OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wtFDchHmS2xaRt20XTgOHIbXq7PdmRejadfDMUOIcc0"; // Token de acesso à API

  // request para API a partir do que foi digitado na busca
  Future<List<dynamic>> fetchMovies(String query) async {
    final response = await http.get( 
      Uri.parse("https://api.themoviedb.org/3/search/movie?query=$query&language=pt-BR"), // URL da request
      headers: { 
        "Authorization": "Bearer $bearerToken",
        "Content-Type": "application/json;charset=utf-8",
      },
    );

    if (response.statusCode == 200) { // em caso de sucesso cria uma lista a partir do json retornado pela API
      final data = jsonDecode(response.body);
      return data['results'];
    } else {
      throw Exception("Erro ao buscar filmes: ${response.statusCode}"); // exception colocada por formalidade
    }
  }
}
