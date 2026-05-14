import 'package:flutter/material.dart';
import 'package:flutter_common_classes/flutter_common_classes.dart';
import 'package:flutter_common_classes/localization/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ListPage(),
      localizationsDelegates: [
        FlutterCommonLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],
      locale: const Locale('es'),
    );
  }
}

class ListPage extends PageLoaderWidget<PostsCubit, List<Post>> {
  const ListPage({super.key});

  @override
  PostsCubit get mainCubit => PostsCubit();

  @override
  LoadingStyle get loadingStyle => SkeletonizerLoadingStyle(
        mockData: List.generate(
          10,
          (index) => Post(
              title: "Title $index",
              body: " dad wad aw da da da ada da d ad a da daw daw"),
        ),
      );

  @override
  Widget view(BuildContext context, List<Post> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final post = data[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.body),
        );
      },
    );
  }
}

class PostsCubit extends AutoLoaderCubit<List<Post>> {
  PostsCubit();

  @override
  Future<Either<Failure, List<Post>>> callUseCase() async {
    await Future.delayed(const Duration(seconds: 2));

    throw AppFailure.unexpected("Unexpected error 1");

    return Right(
        /*[
      Post(title: "Title 1", body: "Body 1"),
      Post(title: "Title 2", body: "Body 2"),
    ]*/
        []);
  }
}

class Post {
  final String title;
  final String body;

  Post({required this.title, required this.body});
}
