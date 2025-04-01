import 'package:flutter/material.dart';
import '../../utils/footer.dart';
import '../../utils/custom_header.dart';
import '../../widgets/post_card.dart';
import '../../service/posts_service.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late PostsService _postsService;
  List<dynamic> _posts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _postsService = PostsService();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      final posts = await _postsService.getPosts();
  

      setState(() {
        _posts = posts;
        _isLoading = false;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur chargement des posts.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Header(),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)))
              : _posts.isEmpty
                  ? Center(child: Text('Aucun post disponible'))
                  : ListView.builder(
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        var post = _posts[index];
                        return PostCard(
                          postId: post['ID'] ?? 0,
                          userId: post['id_user'] ?? 0,
                          profileImageUrl:
                              post['User']?['profilpicture_user'] ?? '',
                          username: post['User']?['pseudo_user'] ?? 'Inconnu',
                          postImageUrl:
                              '', // Tu peux ajouter un champ "image_url" plus tard
                          likesCount: (post['Likes'] as List?)?.length ?? 0,
                          commentsCount:
                              (post['Comments'] as List?)?.length ?? 0,
                          sharesCount: 0,
                        );
                      },
                    ),
      bottomNavigationBar: CustomFooter(
        selectedIndex: 0,
        onItemTapped: (index) {},
      ),
    );
  }
}
