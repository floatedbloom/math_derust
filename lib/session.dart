import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppSession {
  static AppSession? _instance;
  static AppSession get instance {
    _instance ??= AppSession._internal();
    return _instance!;
  }

  AppSession._internal();

  SupabaseClient get _client => Supabase.instance.client;

  // Get current user's username
  String? get currentUsername => _userData?['username'] as String?;
  
  // Get current user's database ID
  int? get currentUserId => _userData?['id'] as int?;
  
  // Get current auth user ID
  String? get authUserId => _client.auth.currentUser?.id;
  
  // Get current user's email
  String? get currentEmail => _client.auth.currentUser?.email;
  
  // Get current user's avatar URL
  String? get avatarUrl => _userData?['avatar_url'] as String?;
  
  // Check if email is verified
  bool get isEmailVerified => _client.auth.currentUser?.emailConfirmedAt != null;
  
  // Check if user is logged in
  bool get isLoggedIn => _client.auth.currentUser != null && _userData != null;
  
  // Cache for user data from our users table
  Map<String, dynamic>? _userData;

  // Resend verification email
  Future<void> resendVerificationEmail() async {
    final email = currentEmail;
    if (email == null) return;
    
    await _client.auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

  // Sign up a new user
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    String? mathClass,
  }) async {
    // Sign up with Supabase Auth - pass username/class in metadata
    // A database trigger will automatically create the user profile
    final authResponse = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        'math_class': mathClass ?? '',
      },
    );

    // If user is immediately confirmed (no email verification), load data
    if (authResponse.session != null) {
      await _loadUserData();
    }

    return authResponse;
  }

  // Sign in existing user
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    final authResponse = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (authResponse.user != null) {
      await _loadUserData();
    }

    return authResponse;
  }

  // Sign in with username or email
  Future<AuthResponse> signInWithUsername({
    required String username,
    required String password,
  }) async {
    String email;
    
    // Check if input is an email (contains @)
    if (username.contains('@')) {
      email = username;
    } else {
      // Look up the email for this username
      final userRecord = await _client
          .from('users')
          .select('email')
          .eq('username', username)
          .maybeSingle();

      if (userRecord == null) {
        throw AuthException('User not found');
      }
      
      email = userRecord['email'] as String;
    }

    return signIn(
      email: email,
      password: password,
    );
  }

  // Load user data from our users table
  Future<void> _loadUserData() async {
    final authUser = _client.auth.currentUser;
    if (authUser == null) {
      _userData = null;
      return;
    }

    final userData = await _client
        .from('users')
        .select()
        .eq('auth_user_id', authUser.id)
        .maybeSingle();

    _userData = userData;
  }

  // Restore session on app start
  Future<void> restoreSession() async {
    // Supabase automatically restores the auth session
    // We just need to load our user data
    if (_client.auth.currentUser != null) {
      await _loadUserData();
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
    _userData = null;
  }

  // Refresh user data (call after profile updates)
  Future<void> refreshUserData() async {
    await _loadUserData();
  }

  // Legacy support: Update username in session after change
  Future<void> updateUsername(String newUsername) async {
    if (_userData != null && currentUserId != null) {
      await _client
          .from('users')
          .update({'username': newUsername})
          .eq('id', currentUserId!);
      await _loadUserData();
    }
  }

  // Upload avatar image
  Future<String?> uploadAvatar(File imageFile) async {
    final userId = authUserId;
    if (userId == null) return null;

    final fileExt = imageFile.path.split('.').last.toLowerCase();
    final fileName = '$userId/avatar.$fileExt';
    
    // Upload to Supabase Storage
    await _client.storage.from('avatars').upload(
      fileName,
      imageFile,
      fileOptions: const FileOptions(upsert: true),
    );

    // Get public URL
    final publicUrl = _client.storage.from('avatars').getPublicUrl(fileName);

    // Update user profile with avatar URL
    await _client
        .from('users')
        .update({'avatar_url': publicUrl})
        .eq('auth_user_id', userId);

    await _loadUserData();
    return publicUrl;
  }

  // Remove avatar
  Future<void> removeAvatar() async {
    final userId = authUserId;
    if (userId == null) return;

    // Try to delete all possible avatar files
    try {
      await _client.storage.from('avatars').remove([
        '$userId/avatar.jpg',
        '$userId/avatar.jpeg',
        '$userId/avatar.png',
        '$userId/avatar.webp',
      ]);
    } catch (_) {
      // Ignore errors if files don't exist
    }

    // Clear avatar URL in database
    await _client
        .from('users')
        .update({'avatar_url': null})
        .eq('auth_user_id', userId);

    await _loadUserData();
  }

  // Delete account (removes database record and signs out)
  // Note: Auth user deletion typically requires a server-side function or database trigger
  Future<void> deleteAccount() async {
    final dbUserId = currentUserId;
    
    if (dbUserId == null) return;

    // Delete user record from database (this should cascade delete related records)
    // A database trigger should handle auth user deletion
    await _client
        .from('users')
        .delete()
        .eq('id', dbUserId);

    // Sign out the user
    await signOut();
  }
}

// Keep the old Session class name as an alias for backward compatibility
typedef Session = AppSession;
