import 'package:flutter/material.dart';
import '../../utils/footer.dart';
import '../../utils/custom_header.dart';
import '../../widgets/post_card.dart';
import '../../services/post_service.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late PostsService _postsService;
  List<dynamic> _posts = []; // Liste des posts récupérés
  bool _isLoading = true; // Pour gérer l'état de chargement
  String _errorMessage = ''; // Message d'erreur en cas de problème de récupération des données

  @override
  void initState() {
    super.initState();
    _postsService = PostsService(); // Initialisation du service
    _loadPosts();
  }

  // Fonction pour charger les posts depuis l'API
  Future<void> _loadPosts() async {
    try {
      final posts = await _postsService.getPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
        _errorMessage = ''; // Réinitialiser le message d'erreur si tout se passe bien
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load posts. Please try again later.'; // Message d'erreur en cas d'échec
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Hauteur du header
        child:Header(profileImageUrl: 'https://example.com/user_profile_image.jpg'), // Passer l'URL de la photo de profil
 // Utilisation du Header
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Indicateur de chargement
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red))) // Afficher le message d'erreur
              : _posts.isEmpty
                  ? Center(child: Text('No posts available')) // Message si aucun post n'est disponible
                  : ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        var post = _posts[index];
                        return PostCard(
                          profileImageUrl: post['userProfileImageUrl'], // Lien vers l'image du profil
                          username: post['username'], // Nom de l'utilisateur
                          postImageUrl: post['imageUrl'], // Lien de l'image du post
                          likesCount: post['likesCount'], // Nombre de likes
                          commentsCount: post['commentsCount'], // Nombre de commentaires
                          sharesCount: post['sharesCount'], // Nombre de partages
                        );
                      },
                    ),
      bottomNavigationBar: CustomFooter( // Utilisation du footer
        selectedIndex: 0, // L'index de l'élément sélectionné
        onItemTapped: (index) {
          // Définir la logique de gestion des éléments tapés ici
        },
      ),
    );
  }
}
