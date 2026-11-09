# journal

Flutter製の投稿一覧アプリ。投稿の検索と、セッション内でのいいね切り替えに対応しています。

公開URL: https://chicken-tatsuta.github.io/journal/

投稿は https://chicken-tatsuta.github.io/journal-posts/posts.json から取得します。取得できない場合は同梱の `assets/posts.json` を表示します。

## 更新と公開

Flutter 3.44.2で検証済みです。

```sh
flutter pub get
flutter test
flutter build web --release --base-href /journal/
rsync -a --delete build/web/ docs/
touch docs/.nojekyll
git add lib web assets test pubspec.yaml pubspec.lock docs
git commit -m "Update journal"
git push origin main
```

GitHub Pagesは `main` ブランチの `/docs` を公開します。
