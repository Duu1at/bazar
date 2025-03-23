import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientProvider {
  static SupabaseClient? _client;
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 3,
    ),
  );

  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        debug: true,
      );
      _client = Supabase.instance.client;
      _setupErrorHandling();
      _logger.i('Supabase initialized successfully');
    } catch (e, st) {
      _logger.e('Supabase initialization failed', error: e, stackTrace: st);
      rethrow;
    }
  }

  static SupabaseClient get client {
    if (_client == null) {
      _logger.w('SupabaseClient accessed before initialization');
      throw Exception('SupabaseClient not initialized. Call initialize() first.');
    }
    return _client!;
  }

  static void _setupErrorHandling() {
    _client?.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        _logger.i('User signed in: ${data.session?.user.email}');
      }
      if (data.event == AuthChangeEvent.signedOut) {
        _logger.i('User signed out');
      }
    });

    _client?.realtime.onError((e) {
      _logger.e(
        e.toString(),
      );
    });

    _client?.realtime.onError(
      (error) {
        _logger.e(
          'Realtime Error',
          error: error.message,
        );
      },
    );
  }

  static Future<dynamic> safeQuery(
    String table, {
    String query = '*',
    int limit = 100,
  }) async {
    try {
      _logger.d('Executing query on $table');
      final response = await client.from(table).select(query).limit(limit);
      _logger.i('Query successful: ${response.length} items');
      return response;
    } on PostgrestException catch (e) {
      _logger.e(
        'Database Error',
        error: '${e.code}: ${e.message}',
      );
      rethrow;
    } catch (e, st) {
      _logger.e('Unexpected error', error: e, stackTrace: st);
      rethrow;
    }
  }
}
