import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/core/storage/settings_storage.dart';
import 'package:mobile/features/auth/data/auth_repository.dart';
import 'package:mobile/features/person/models/person_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SettingsStorage storage;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  AuthBloc({required this.authRepository, required this.storage})
    : super(AuthInitial()) {
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isRegistered = await storage.readRegistrationStatus();
    if (!isRegistered) return;

    emit(AuthLoading());
    try {
      final person = await authRepository.getMe();
      emit(AuthSuccess(person: person));
    } catch (_) {
      emit(AuthInitial());
    }
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        // Пользователь закрыл окно выбора аккаунта — не ошибка.
        emit(AuthInitial());
        return;
      }

      final googleAuth = await account.authentication;

      // Бэкенд верифицирует Firebase ID token (aud = наш Firebase-проект),
      // а не сырой Google idToken (aud = Google OAuth client) — поэтому
      // сначала входим через Google-креды в Firebase Auth, и берём токен
      // уже оттуда.
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final firebaseIdToken = await userCredential.user?.getIdToken();
      if (firebaseIdToken == null) {
        emit(const AuthError(message: 'Firebase не вернул idToken'));
        return;
      }

      await authRepository.loginWithGoogle(firebaseIdToken);
      final person = await authRepository.getMe();

      emit(AuthSuccess(person: person));
    } catch (e) {
      debugPrint('auth/google error: $e');
      emit(AuthError(message: e.toString()));
    }
  }
}
