Displays a user's featured NoveLand novel on Discourse user cards and profile pages.

# NoveLand Representative Novel Card

NoveLand 公式 Discourse フォーラム向けのテーマコンポーネントです。

NoveLand 側から DiscourseConnect の `sync_sso` で同期された代表作情報を使い、ユーザーカードとプロフィールページに表紙画像付きの代表作カードを表示します。カードをクリックすると NoveLand の作品ページへ移動します。

## 前提

Discourse 側で代表作用のユーザーフィールドが 4 つ定義され、NoveLand 側の `sync_sso` から値が同期されている必要があります。

- 代表作タイトル
- 作品ページ URL
- 表紙画像 URL
- あらすじ

各フィールドは `show_on_user_card=true`、`show_on_profile=false`、`editable=false` を想定しています。表示はこのテーマコンポーネントが担当するため、標準のユーザーフィールド表示はユーザーカード上で非表示にします。

## インストール

1. Discourse 管理画面で `admin > Customize > Themes` を開きます。
2. `Install` を選びます。
3. `From a git repository` を選びます。
4. リポジトリ URL に `https://github.com/WebNovelLaboratory/discourse-representative-novel-card` を入力してインストールします。
5. インストール後、このテーマコンポーネントを利用中のテーマに追加します。

## Theme settings

インストール直後はフィールド ID が未設定のため、カードは表示されません。`admin > Customize > Themes` からこのテーマコンポーネントの settings を開き、各ユーザーフィールド ID を設定してください。

- `rep_novel_field_id_title`: 代表作タイトルのユーザーフィールド ID
- `rep_novel_field_id_url`: 作品ページ URL のユーザーフィールド ID
- `rep_novel_field_id_cover`: 表紙画像 URL のユーザーフィールド ID
- `rep_novel_field_id_synopsis`: あらすじのユーザーフィールド ID
- `open_link_in_new_tab`: 作品ページを新しいタブで開くか

ユーザーフィールド ID は `admin/customize/user_fields` で対象フィールドの編集画面を開くと、URL から確認できます。

`rep_novel_field_id_title` または `rep_novel_field_id_url` が `0` の間、またはタイトル・URL が空のユーザーでは何も描画しません。URL は `http://` または `https://` で始まる値だけを表示対象にします。

## ローカル開発・検証

Discourse は staff ユーザーや本人に対して、ユーザーフィールドを常にシリアライズする場合があります。公開表示の挙動を確認するときは、一般ユーザー視点でユーザーカードとプロフィールページを確認してください。

Glimmer の通常の `{{ }}` 描画だけを使い、代表作タイトルやあらすじを HTML として解釈しない実装にしています。
