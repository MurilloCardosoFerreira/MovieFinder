# Movie Finder

---

## Sobre o Projeto

 Movie Finder é um aplicativo de busca que permite procurar informações sobre filmes utilizando a API The Movie Database (TMDB). Nele você pode ter informações sobre a capa, contra-capa, ano de lançamento, avaliação média e sinopse de qualquer filme do seu interesse.

 ---

 ## Ferramentas de desenvolvimento

 - Flutter (Framework)
 - Dart (Linguagem de Programação)
 - TMDB (API)

---

## Informações para utilização do código (DEV)

1. Clone o repositório:
```sh
git clone https://github.com/MurilloCardosoFerreira/MovieFinder.git
cd movie_finder
```

2. Crie uma conta no site da API e encontre o Token de Leitura da API:
   > https://www.themoviedb.org

3. Substitua o bearer token do código pelo seu:
   vá em api_service.dart e substitua bearerToken na linha 6
```dart
.../
  final String bearerToken = "coloque_seu_token";
\...
```

4. Teste a conexão:
   Você pode utilizar programas como Postman para testar a conexão entre a API
   
   4.1. Baixe e instale o Postman no link https://www.postman.com
   
   4.2. Abra o Postman e aperte CTRL + T ou clique em Send an API request
   
   4.3. coloque a URL https://api.themoviedb.org/3/search/movie?query=sonic&language=pt-BR
   
   4.4. Clique em Authorization, vá em Auth Type, selecione Bearer Token e coloque seu token

   Se tudo der certo, será retornado um Json contendo vários filmes relacionados ao Sonic, em português. Para modificar isso você pode ir até a URL e modificar a query (filme) e language (tradução de retorno)

6. Rode o programa
```sh
flutter run
```
