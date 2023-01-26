// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AlbumDao? _albumdaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Album` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cover` TEXT, `name` TEXT NOT NULL, `path` TEXT NOT NULL, `count` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AlbumDao get albumdao {
    return _albumdaoInstance ??= _$AlbumDao(database, changeListener);
  }
}

class _$AlbumDao extends AlbumDao {
  _$AlbumDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _albumInsertionAdapter = InsertionAdapter(
            database,
            'Album',
            (Album item) => <String, Object?>{
                  'id': item.id,
                  'cover': item.cover,
                  'name': item.name,
                  'path': item.path,
                  'count': item.count
                }),
        _albumUpdateAdapter = UpdateAdapter(
            database,
            'Album',
            ['id'],
            (Album item) => <String, Object?>{
                  'id': item.id,
                  'cover': item.cover,
                  'name': item.name,
                  'path': item.path,
                  'count': item.count
                }),
        _albumDeletionAdapter = DeletionAdapter(
            database,
            'Album',
            ['id'],
            (Album item) => <String, Object?>{
                  'id': item.id,
                  'cover': item.cover,
                  'name': item.name,
                  'path': item.path,
                  'count': item.count
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Album> _albumInsertionAdapter;

  final UpdateAdapter<Album> _albumUpdateAdapter;

  final DeletionAdapter<Album> _albumDeletionAdapter;

  @override
  Future<List<Album>> findAll() async {
    return _queryAdapter.queryList('select * from Album',
        mapper: (Map<String, Object?> row) =>
            Album(name: row['name'] as String, path: row['path'] as String));
  }

  @override
  Future<int> insertOne(Album data) {
    return _albumInsertionAdapter.insertAndReturnId(
        data, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOne(Album data) async {
    await _albumUpdateAdapter.update(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(Album data) async {
    await _albumDeletionAdapter.delete(data);
  }
}
