import 'package:flutter/material.dart';
import 'package:math_derust/data/db.dart';
import 'package:math_derust/session.dart';
import 'package:math_derust/theme/app_theme.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  CommunityState createState() => CommunityState();
}

class CommunityState extends State<Community> with SingleTickerProviderStateMixin {
  DbHelper db = DbHelper.instance;
  List<Map<String, dynamic>> posts = [];
  
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
    _loadPosts();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadPosts() async {
    List<Map<String, dynamic>> fetchedPosts = await db.queryAll('posts');
    if (mounted) {
      setState(() {
        posts = fetchedPosts;
      });
    }
  }

  void _createPost() {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              const GradientTitle(text: 'NEW POST', fontSize: 20),
              
              const SizedBox(height: 24),
              
              Container(
                decoration: AppDecorations.cardDecoration,
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  cursorColor: AppColors.gold,
                ),
              ),
              
              const SizedBox(height: 16),
              
              Container(
                decoration: AppDecorations.cardDecoration,
                child: TextField(
                  controller: contentController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'What\'s on your mind?',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                  cursorColor: AppColors.gold,
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: 'CANCEL',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryButton(
                      text: 'POST',
                      onPressed: () async {
                        String title = titleController.text.trim();
                        String content = contentController.text.trim();
                        if (title.isNotEmpty && content.isNotEmpty) {
                          Map<String, dynamic> row = {
                            "creator_id": Session.instance.currentUserId,
                            "title": title,
                            "content": content,
                          };
                          await db.insert('posts', row);
                          
                          // Update quest progress for creating posts
                          final userId = Session.instance.currentUserId;
                          if (userId != null) {
                            await db.updateQuestsByCondition(userId, 'post_created');
                          }
                        }
                        Navigator.pop(context);
                        _loadPosts();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  const GradientTitle(text: 'COMMUNITY', fontSize: 24),
                  
                  const SizedBox(height: 20),
                  
                  // Create post button
                  GestureDetector(
                    onTap: _createPost,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.gold.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: AppGradients.goldGradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.edit_rounded,
                              color: AppColors.backgroundDark,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Share something with the community...',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            Expanded(
              child: posts.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<Map<String, String?>>(
                          future: db.getUserInfoById(posts[index]["creator_id"]),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                height: 100,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.gold,
                                  ),
                                ),
                              );
                            }
                            return _buildCommunityPost(
                              snapshot.data?['username'] ?? "Unknown",
                              snapshot.data?['avatar_url'],
                              posts[index]["title"] ?? "No Title",
                              posts[index]["content"] ?? "",
                              posts[index]["likes"] ?? 0,
                              posts[index]["id"] ?? 0,
                              index,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.forum_outlined,
              size: 50,
              color: AppColors.goldMuted,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Posts Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Be the first to share!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityPost(
    String username,
    String? avatarUrl,
    String title,
    String content,
    int likes,
    int postId,
    int index,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () => _showComments(context, postId, db),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey.shade800.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User header
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: avatarUrl == null ? AppGradients.goldGradient : null,
                      borderRadius: BorderRadius.circular(12),
                      image: avatarUrl != null
                          ? DecorationImage(
                              image: NetworkImage(avatarUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: avatarUrl == null
                        ? Center(
                            child: Text(
                              username.isNotEmpty ? username[0].toUpperCase() : 'U',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.backgroundDark,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '@$username',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gold,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Content
              Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                  height: 1.4,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Actions - likes and comments
              _PostActions(
                postId: postId,
                initialLikes: likes,
                db: db,
                onCommentTap: () async => _showComments(context, postId, db),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showComments(BuildContext context, int postId, DbHelper db) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: db.queryWhere('comments', 'parent_id', postId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.gold),
                ),
              );
            }
            
            var comments = snapshot.data!;
            
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: AppColors.backgroundCard,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${comments.length}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: comments.isEmpty
                        ? Center(
                            child: Text(
                              'No comments yet. Be the first!',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder<Map<String, String?>>(
                                future: db.getUserInfoById(comments[index]["creator_id"]),
                                builder: (context, userSnapshot) {
                                  if (!userSnapshot.hasData) {
                                    return const SizedBox.shrink();
                                  }
                                  
                                  final username = userSnapshot.data?['username'] ?? 'User';
                                  final avatarUrl = userSnapshot.data?['avatar_url'];
                                  int likeCount = comments[index]['likes'] ?? 0;
                                  
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 12),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: AppColors.backgroundDark,
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 28,
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                    color: avatarUrl == null 
                                                        ? AppColors.goldMuted.withOpacity(0.2)
                                                        : null,
                                                    borderRadius: BorderRadius.circular(8),
                                                    image: avatarUrl != null
                                                        ? DecorationImage(
                                                            image: NetworkImage(avatarUrl),
                                                            fit: BoxFit.cover,
                                                          )
                                                        : null,
                                                  ),
                                                  child: avatarUrl == null
                                                      ? Center(
                                                          child: Text(
                                                            username.isNotEmpty ? username[0].toUpperCase() : 'U',
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500,
                                                              color: AppColors.goldMuted,
                                                            ),
                                                          ),
                                                        )
                                                      : null,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '@$username',
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.goldMuted,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              comments[index]['content'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            _CommentLikeButton(
                                              commentId: comments[index]["id"],
                                              initialLikes: likeCount,
                                              db: db,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                  ),
                  
                  // Comment input at bottom
                  _CommentInput(
                    postId: postId,
                    db: db,
                    onCommentPosted: () {
                      // Close the sheet - the parent will refresh
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Comment input widget with text field
class _CommentInput extends StatefulWidget {
  final int postId;
  final DbHelper db;
  final VoidCallback onCommentPosted;

  const _CommentInput({
    required this.postId,
    required this.db,
    required this.onCommentPosted,
  });

  @override
  State<_CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<_CommentInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isPosting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _postComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty || _isPosting) return;

    setState(() => _isPosting = true);

    try {
      await widget.db.insert('comments', {
        "parent_id": widget.postId,
        "creator_id": Session.instance.currentUserId,
        "content": content,
      });

      // Update quest progress for creating comments
      final userId = Session.instance.currentUserId;
      if (userId != null) {
        await widget.db.updateQuestsByCondition(userId, 'comment_created');
      }

      _controller.clear();
      widget.onCommentPosted();
    } finally {
      if (mounted) {
        setState(() => _isPosting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade800.withOpacity(0.3),
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundDark,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.grey.shade800.withOpacity(0.3),
                  ),
                ),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: _postComment,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: AppGradients.goldGradient,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: _isPosting
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.backgroundDark,
                        ),
                      )
                    : const Icon(
                        Icons.send_rounded,
                        color: AppColors.backgroundDark,
                        size: 20,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate StatefulWidget for post actions to properly manage like state
class _PostActions extends StatefulWidget {
  final int postId;
  final int initialLikes;
  final DbHelper db;
  final Future<void> Function() onCommentTap;

  const _PostActions({
    required this.postId,
    required this.initialLikes,
    required this.db,
    required this.onCommentTap,
  });

  @override
  State<_PostActions> createState() => _PostActionsState();
}

class _PostActionsState extends State<_PostActions> {
  late int _likeCount;
  bool _isLiked = false;
  int _commentCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.initialLikes;
    _loadState();
  }

  Future<void> _loadState() async {
    final results = await Future.wait([
      widget.db.hasUserLiked(widget.postId, 'post'),
      widget.db.getCommentCount(widget.postId),
    ]);
    
    if (mounted) {
      setState(() {
        _isLiked = results[0] as bool;
        _commentCount = results[1] as int;
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshCommentCount() async {
    final count = await widget.db.getCommentCount(widget.postId);
    if (mounted) {
      setState(() {
        _commentCount = count;
      });
    }
  }

  Future<void> _toggleLike() async {
    final result = await widget.db.toggleLike(widget.postId, 'post');
    if (mounted) {
      setState(() {
        _likeCount = result['likes'] as int;
        _isLiked = result['liked'] as bool;
      });
    }
  }

  Future<void> _handleCommentTap() async {
    await widget.onCommentTap();
    // Refresh comment count after returning from comment sheet
    await _refreshCommentCount();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Like button
        GestureDetector(
          onTap: _toggleLike,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: _isLiked 
                  ? AppColors.error.withOpacity(0.15)
                  : AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(20),
              border: _isLiked
                  ? Border.all(color: AppColors.error.withOpacity(0.3))
                  : null,
            ),
            child: Row(
              children: [
                Icon(
                  _isLiked 
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  size: 18,
                  color: _isLiked 
                      ? AppColors.error
                      : Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  '$_likeCount',
                  style: TextStyle(
                    fontSize: 13,
                    color: _isLiked 
                        ? AppColors.error
                        : Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Comment button with count
        GestureDetector(
          onTap: _handleCommentTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 18,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                _isLoading
                    ? SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: Colors.grey.shade500,
                        ),
                      )
                    : Text(
                        _commentCount > 0 ? '$_commentCount' : 'Reply',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                          fontWeight: _commentCount > 0 ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Separate StatefulWidget for comment likes
class _CommentLikeButton extends StatefulWidget {
  final int commentId;
  final int initialLikes;
  final DbHelper db;

  const _CommentLikeButton({
    required this.commentId,
    required this.initialLikes,
    required this.db,
  });

  @override
  State<_CommentLikeButton> createState() => _CommentLikeButtonState();
}

class _CommentLikeButtonState extends State<_CommentLikeButton> {
  late int _likeCount;
  bool _isLiked = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _likeCount = widget.initialLikes;
    _loadLikeState();
  }

  Future<void> _loadLikeState() async {
    final isLiked = await widget.db.hasUserLiked(widget.commentId, 'comment');
    if (mounted) {
      setState(() {
        _isLiked = isLiked;
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleLike() async {
    final result = await widget.db.toggleLike(widget.commentId, 'comment');
    if (mounted) {
      setState(() {
        _likeCount = result['likes'] as int;
        _isLiked = result['liked'] as bool;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            size: 16,
            color: _isLiked ? AppColors.error : Colors.grey.shade500,
          ),
          const SizedBox(width: 4),
          Text(
            '$_likeCount',
            style: TextStyle(
              fontSize: 12,
              color: _isLiked ? AppColors.error : Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
