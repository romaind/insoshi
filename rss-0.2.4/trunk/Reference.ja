# -*- rd -*-

= Reference.ja

$Id: Reference.ja 341 2007-12-02 06:07:26Z kou $

RSS Makerのリファレンスです．

RSS ParserのAPIはRSS/Atomの要素を知っていれば使えるはずなので
省略します．ごめんなさい．

== 注意

Rubyの伝統的な(({Class#instance_method}))や
(({Class.class_method}))という表記を使いません．実際にコード
に書くときと同じ表記を使います．つまり，(({obj}))のインスタ
ンスメソッド(({meth}))を示すために以下のように書きます．

  obj.meth

以下に現れる(({maker}))は(({RSS::Maker.make}))に渡したブロッ
クへの引数名とします．つまり，以下のようにした時の
(({maker}))ということです．

  RSS::Maker.make(...) do |maker|
    ...
  end

--- RSS::Maker.make(version, &block)
     ((|version|))には(({"1.0"}))または(({"0.9"}))または
     (({"0.91"}))または(({"2.0"}))を指定します．(({"0.9"}))
     と(({"0.91"}))は同じであることに注意してください．バー
     ジョン番号の前に(({"rss"}))をつけてこのように指定するこ
     とも出来ます:
     (({"rss1.0"}))/(({"rss2.0"}))/(({"rss0.9"}))/(({"rss0.91"}))

     Atomフィード文書を生成する場合は
     (({"atom"}))/(({"atom:feed"}))/(({"atom1.0"}))/(({"atom1.0:feed"}))
     を指定してください。

     Atomエントリ文書を生成する場合は
     (({"atom:entry"}))/(({"atom1.0:entry"}))を指定してください。

     ((|block|))を実行したあとの(({maker}))オブジェクトから
     RSSオブジェクトを生成して返します．

== モデル

いくつかのオブジェクトは共通のAPIを持っています。

=== AtomTextConstruct

Atomのサポートにより、(({maker.channel.title}))などは単なる
テキストだけではなく、タグづけされたテキストやXML要素を指定
できるようになりました。それらは以下のようなメソッドを持ちま
す。

--- type
     内容の種類を返します。
--- type=(value)
     ((|value|))はtext/html/xhtmlのいずれかを指定します。

--- content
     種類がtext/htmlの場合の内容を返します。
--- content=(value)
     種類がtext/htmlの場合の内容を設定します。

--- xml_content
     種類がxhtmlの場合の内容を返します。
--- xml_content=(value)
     種類がxhtmlの場合の内容を設定します。文字列または
     RSS::XML::Elementで指定します。あるいは、それらの配列で
     指定することも出来ます。

--- xhtml
     (({xml_content}))の別名です。
--- xhtml=(value)
     (({xml_content=}))の別名です。

=== AtomPersonConstruct

Atomのサポートにより、人を表現するモデルが導入されました。そ
れは以下のようなメソッドを持ちます。

--- name
--- name=(value)

--- uri
--- uri=(value)

--- email
--- email=(value)

== maker

RSS/Atomのルート要素を生成するオブジェクトです．

(({maker.channel}))または(({maker.items}))を適切に設定しなけ
ればRSS/Atomは生成されません．

--- maker.version
     作成するXMLのバージョンを返します．

--- maker.version=(value)
     作成するXMLのバージョンを設定します．

--- maker.encoding
     作成するXMLのエンコーディングを返します．デフォルトは
     UTF-8です．

--- maker.encoding=(value)
     作成するXMLのエンコーディングを設定します．(({maker}))
     に設定する際のエンコーディングはここで指定したものにす
     る必要があります．

--- maker.standalone
     作成するXMLのstandaloneを返します．

--- maker.standalone=(value)
     作成するXMLのstandaloneを設定します．

--- maker.feed_version
     作成するフィードのバージョンを返します．

--- maker.rss_version
     (({maker.feed_version}))の別名です。

--- maker.xml_stylesheets
     (({xml_stylesheet}))を管理するオブジェクトを返します．
     
--- maker.channel
     channel要素を生成するオブジェクトを返します．Atomフィー
     ド文書ではatom:feed要素を生成します。
     
--- maker.image
     image要素を生成するオブジェクトを返します．Atomフィー
     ド文書ではatom:feed/atom:logo要素を生成します。
     
--- maker.items
     item要素を生成するオブジェクトを管理するオブジェクトを
     返します．Atomフィード文書ではatom:feed/atom:entry要素
     に対応します。Atomエントリ文書では最初のitemのみが使用
     されます。
     
--- maker.textinput
     textinput要素を生成するオブジェクトを返します．
     
=== maker.xml_stylsheets

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.xml_stylesheets.new_xml_stylesheet
     新しく(({xml_stylesheet}))を作成し，返します．作成された
     (({xml_stylesheet}))は(({xml_stylesheet}))リストの最後
     に追加されています．ブロックを指定した以下のような使い
     かたを推奨します．

       maker.xml_stylesheets.new_xml_stylesheet do |xss|
         xss.XXX = XXX
         ...
       end

==== xml_stylesheet

(({xml_stylesheet}))は
(({maker.xml_stylesheet.new_xml_stylesheet}))で作成されたオ
ブジェクトとします．

(({href}))と(({type}))は必ず指定する必要があります．ただし，
(({href}))に設定した値の拡張子が.xslまたは.cssの場合は
(({type}))を指定する必要はありません．自動で推測します．

--- xml_stylesheet.href
--- xml_stylesheet.href=(value)

--- xml_stylesheet.type
--- xml_stylesheet.type=(value)

--- xml_stylesheet.title
--- xml_stylesheet.title=(value)

--- xml_stylesheet.media
--- xml_stylesheet.media=(value)

--- xml_stylesheet.charset
--- xml_stylesheet.charset=(value)

--- xml_stylesheet.alternate
--- xml_stylesheet.alternate=(value)

== maker.channel

channel要素の値を設定します．Atomフィード文書の場合は
atom:feed要素に対応します。Atomエントリ文書の場合はいくつか
の値がデフォルト値として利用されます。

RSS 1.0を生成する場合は(({about}))，(({title}))，(({link}))，
(({description}))を設定しなければいけません．

RSS 0.91を生成する場合は(({title}))，(({link}))，
(({description}))，(({language}))を設定しなければいけません．

RSS 2.0を生成する場合は(({title}))，(({link}))，
(({description}))を設定しなければいけません．

Atomフィード文書を生成する場合は(({title}))、(({updated}))、
(({id}))を設定しなければいけません。もし、maker.items中のど
のitemも(({author}))を設定しない場合は(({author}))を設定しな
ければいけません。

上記の(({maker.channel}))が要求する値を設定していない場合は
(({RSS::NotSetError}))例外が発生します．

説明がないメソッドは単なるアクセサです。

--- maker.channel.about
--- maker.channel.about=(value)

--- maker.channel.title
     (({title.content}))を返します。0.1.6以前と同じ挙動です。
--- maker.channel.title {|title| ...}
     ブロックに(({title}))を渡します。
--- maker.channel.title=(value)
     (({title.content}))に((|value|))を設定します。

--- maker.channel.links
     (({links}))を返します。
--- maker.channel.link
     (({links}))の最初の要素の(({href}))を返します。
     (({links}))が空の場合は(({nil}))を返します。
--- maker.channel.link=(value)
     (({links}))の最初の要素の(({href}))に((|value|))を設定
     します。(({links}))が空の場合は(({links.new_link}))で新
     しく作成し、(({href}))を設定します。

--- maker.channel.description
     (({description.content}))を返します。0.1.6以前と同じ挙動です。
--- maker.channel.description {|description| ...}
     ブロックに(({description}))を渡します。
--- maker.channel.description=(value)
     (({description.content}))に((|value|))を設定します。

--- maker.channel.subtitle
     (({maker.channel.description}))の別名です．
--- maker.channel.subtitle=(value)
     (({maker.channel.description=}))の別名です．

--- maker.channel.language
--- maker.channel.language=(value)

--- maker.channel.copyright
     (({copyright.content}))を返します。0.1.6以前と同じ挙動です。
--- maker.channel.copyright {|copyright| ...}
     ブロックに(({copyright}))を渡します。
--- maker.channel.copyright=(value)
     (({copyright.content}))に((|value|))を設定します。

--- maker.channel.rights
--- maker.channel.rights {|rights| ...}
     (({maker.channel.copyright}))の別名です．
--- maker.channel.rights=(value)
     (({maker.channel.copyright=}))の別名です．

--- maker.channel.managingEditor
--- maker.channel.managingEditor=(value)

--- maker.channel.webMaster
--- maker.channel.webMaster=(value)

--- maker.channel.rating
--- maker.channel.rating=(value)

--- maker.channel.docs
--- maker.channel.docs=(value)

--- maker.channel.date
--- maker.channel.date=(value)

--- maker.channel.pubDate
     (({maker.channel.date}))の別名です．
--- maker.channel.pubDate=(value)
     (({maker.channel.date=}))の別名です．

--- maker.channel.updated
     (({maker.channel.date}))の別名です．
--- maker.channel.updated=(value)
     (({maker.channel.date=}))の別名です．

--- maker.channel.lastBuildDate
--- maker.channel.lastBuildDate=(value)

--- maker.channel.generator
     (({generator.content}))を返します。
--- maker.channel.generator {|generator| ...}
     ブロックに(({generator}))を渡します。
--- maker.channel.generator=(value)
     (({generator.content}))に((|value|))を設定します。

--- maker.channel.ttl
--- maker.channel.ttl=(value)

--- maker.channel.categories
     (({categories}))を返します．

--- maker.channel.cloud
     (({cloud}))を返します．

--- maker.channel.skipDays
     (({skipDays}))を返します．

--- maker.channel.skipHours
     (({skipHours}))を返します．

--- maker.channel.authors
     (({authors}))を返します。
--- maker.channel.author
     (({authors}))の最初の要素の(({name}))を返します。
     (({authors}))が空の場合は(({nil}))を返します。
--- maker.channel.author=(value)
     (({authors}))の最初の要素の(({name}))に((|value|))を設定
     します。(({authors}))が空の場合は(({authors.new_author}))で新
     しく作成し、(({name}))を設定します。

--- maker.channel.contributors
     (({contributors}))を返します。
--- maker.channel.contibutor
     (({contibutors}))の最初の要素の(({name}))を返します。
     (({contibutors}))が空の場合は(({nil}))を返します。
--- maker.channel.contibutor=(value)
     (({contibutors}))の最初の要素の(({name}))に((|value|))を設定
     します。(({contibutors}))が空の場合は
     (({contibutors.new_contibutor}))で新しく作成し、
     (({name}))を設定します。

--- maker.channel.icon
     (({maker.channel.image_favicon.about}))の別名です．
--- maker.channel.icon=(value)
     (({maker.channel.image_favicon.about=}))の別名です．

--- maker.channel.logo
     (({maker.image.url}))の別名です．
--- maker.channel.logo=(value)
     (({maker.image.url=}))の別名です．

=== maker.channel.title

AtomTextConstructを参照してください。

RSSを生成するときは(({content}))しか利用されません。

=== maker.channel.links

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.channel.links.new_link
     新しく(({link}))を作成し，返します．作成された
     (({link}))は(({link}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       maker.channel.links.new_link do |link|
         link.XXX = XXX
         ...
       end

==== link

(({link}))は(({maker.channel.links.new_link}))で作成されたオ
ブジェクトとします．

(({href}))を指定する必要があります．

--- link.href
--- link.href=(value)

--- link.rel
--- link.rel=(value)

--- link.type
--- link.type=(value)

--- link.hreflang
--- link.hreflang=(value)

--- link.title
--- link.title=(value)

--- link.length
--- link.length=(value)

=== maker.channel.description

AtomTextConstructを参照してください。

RSSを生成するときは(({content}))しか利用されません。

=== maker.channel.copyright

AtomTextConstructを参照してください。

RSSを生成するときは(({content}))しか利用されません。

=== maker.channel.generator

RSS 2.0/Atomフィード文書を生成するときに利用されます。

RSS 2.0を生成するときは(({content}))しか利用されません。

--- maker.channel.generator.uri
--- maker.channel.generator.uri=(value)

--- maker.channel.generator.version
--- maker.channel.generator.version=(value)

--- maker.channel.generator.content
--- maker.channel.generator.content=(value)

=== maker.channel.categories

RSS 2.0を生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.channel.categories.new_category
     新しく(({category}))を作成し，返します．作成された
     (({category}))は(({category}))リストの最後
     に追加されています．ブロックを指定した以下のような使い
     かたを推奨します．

       maker.channel.categories.new_category do |category|
         category.XXX = XXX
         ...
       end

==== category

(({category}))は
(({maker.channel.categories.new_category}))で作成されたオ
ブジェクトとします．

(({content}))を指定する必要があります．

--- category.domain
--- category.domain=(value)

--- category.content
--- category.content=(value)

=== maker.channel.cloud

RSS 2.0を生成するときだけ利用されます．

全ての属性を設定する必要があります．

--- maker.channel.cloud.domain
--- maker.channel.cloud.domain=(value)

--- maker.channel.cloud.port
--- maker.channel.cloud.port=(value)

--- maker.channel.cloud.path
--- maker.channel.cloud.path=(value)

--- maker.channel.cloud.registerProcedure
--- maker.channel.cloud.registerProcedure=(value)

--- maker.channel.cloud.protocol
--- maker.channel.cloud.protocol=(value)

=== maker.channel.skipDays

RSS 0.91/2.0を生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.channel.skipDays.new_day
     新しく(({day}))を作成し，返します．作成された
     (({day}))は(({day}))リストの最後
     に追加されています．ブロックを指定した以下のような使い
     かたを推奨します．

       maker.channel.skipDays.new_day do |day|
         day.XXX = XXX
         ...
       end

==== day

(({day}))は
(({maker.channel.skipDays.new_day}))で作成されたオ
ブジェクトとします．

(({content}))を指定する必要があります．

--- day.content
--- day.content=(value)

=== maker.channel.skipHours

RSS 0.91/2.0を生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.channel.skipHours.new_hour
     新しく(({hour}))を作成し，返します．作成された
     (({hour}))は(({hour}))リストの最後
     に追加されています．ブロックを指定した以下のような使い
     かたを推奨します．

       maker.channel.skipHours.new_hour do |hour|
         hour.XXX = XXX
         ...
       end

==== hour

(({hour}))は
(({maker.channel.skipHours.new_hour}))で作成されたオ
ブジェクトとします．

(({content}))を指定する必要があります．

--- hour.content
--- hour.content=(value)

=== maker.channel.authors

Atomを生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.channel.authors.new_author
     新しく(({author}))を作成し，返します．作成された
     (({author}))は(({author}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       maker.channel.authors.new_author do |author|
         author.XXX = XXX
         ...
       end

==== author

AtomPersonConstructを参照してください。

=== maker.channel.contributors

Atomを生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.channel.contributors.new_contributor
     新しく(({contributor}))を作成し，返します．作成された
     (({contributor}))は(({contributor}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       maker.channel.contributors.new_contributor do |contributor|
         contributor.XXX = XXX
         ...
       end

==== contributor

AtomPersonConstructを参照してください。

== maker.image

RSS 1.0の場合は(({url}))，(({title}))，
(({maker.channel.link}))，(({maker.channel}))が適切に設定さ
れている必要があります．

RSS 0.91/2.0の場合は(({url}))，(({title}))，
(({maker.channel.link}))が適切に設定されている必要があります．

Atomフィードの場合は(({url}))が適切に設定されている必要があり
ます．

--- maker.image.title
--- maker.image.title=(value)

--- maker.image.url
--- maker.image.url=(value)

--- maker.image.width
--- maker.image.width=(value)

--- maker.image.height
--- maker.image.height=(value)

--- maker.image.description
--- maker.image.description=(value)

== maker.items

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- maker.items.new_item
     新しく(({item}))を作成し，返します．作成された
     (({item}))は(({item}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       maker.items.new_item do |item|
         item.XXX = XXX
         ...
       end

--- maker.items.do_sort
     現在の(({do_sort}))の値を取得します．デフォルトでは
     (({false}))になっています．

--- maker.items.do_sort=(boolean_or_proc)
     (({true}))に設定すると(({item.date}))が新しい順に並び替
     えます．(({Proc}))オブジェクトを指定することにより並び
     替え方法をカスタマイズすることができます．

--- maker.items.max_size
     現在の(({max_size}))の値を取得します．デフォルトでは
     (({-1}))になっています．

--- maker.items.max_size=(integer)
     出力する(({item}))の数の最大値を設定します．


=== item

(({item}))は(({maker.items.new_item}))で作成されたオブジェク
トとします．

RSS 1.0/0.91の場合は(({title}))，(({link}))を設定する必要があ
ります．

RSS 2.0の場合は(({title}))または(({description}))を設定する
必要があります．

Atomフィードの場合は(({id}))、(({title}))、(({updated}))を設
定する必要があります。(({id}))が設定されていない場合は
(({link}))を利用します。

Atomエントリの場合は(({id}))、(({title}))、(({updated}))、一
人以上の(({authors}))を設定する必要があります。(({id}))が設定
されていない場合は(({link}))を利用します。(({authors}))が一
人も設定されていない場合は(({maker.channel.authors}))を利用
します。

--- item.title
     (({title.content}))を返します。0.1.6以前と同じ挙動です。
--- item.title {|title| ...}
     ブロックに(({title}))を渡します。
--- item.title=(value)
     (({title.content}))に((|value|))を設定します。

--- item.links
     (({links}))を返します。
--- item.link
     (({title}))を返します。0.1.6以前はStringかnilでした。
--- item.title=(value)
     (({title.content}))に((|value|))を設定します。

--- item.links
     (({links}))を返します。
--- item.link
     (({links}))の最初の要素の(({href}))を返します。
     (({links}))が空の場合は(({nil}))を返します。
--- item.link=(value)
     (({links}))の最初の要素の(({href}))に((|value|))を設定
     します。(({links}))が空の場合は(({links.new_link}))で新
     しく作成し、(({href}))を設定します。

--- item.description
     (({description.content}))を返します。0.1.6以前と同じ挙動です。
--- item.description {|description| ....}
     ブロック(({description}))を渡します。
--- item.description=(value)
     (({description.content}))に((|value|))を設定します。

--- item.summary
--- item.summary {|summary| ...}
     (({item.description}))の別名です。
--- item.summary=(value)
     (({item.description=}))の別名です。

--- item.date
--- item.date=(value)

--- item.pubDate
     (({item.date}))の別名です．
--- item.pubDate=(value)
     (({item.date=}))の別名です．

--- item.updated
     (({item.date}))の別名です．
--- item.updated=(value)
     (({item.date=}))の別名です．

--- item.authors
     (({authors}))を返します。
--- item.author
     (({authors}))の最初の要素の(({name}))を返します。
     (({authors}))が空の場合は(({nil}))を返します。
--- item.author=(value)
     (({authors}))の最初の要素の(({name}))に((|value|))を設定
     します。(({authors}))が空の場合は(({authors.new_author}))で新
     しく作成し、(({name}))を設定します。

--- item.contibutors
     (({contibutors}))を返します。
--- item.contibutor
     (({contibutors}))の最初の要素の(({name}))を返します。
     (({contibutors}))が空の場合は(({nil}))を返します。
--- item.contibutor=(value)
     (({contibutors}))の最初の要素の(({name}))に((|value|))を設定
     します。(({contibutors}))が空の場合は
     (({contibutors.new_contibutor}))で新しく作成し、
     (({name}))を設定します。

--- item.comments
--- item.comments=(value)

--- item.guid
     (({guid}))を返します。
--- item.enclosure
     (({enclosure}))を返します。
--- item.source
     (({source}))を返します。
--- item.categories
     (({categories}))を返します。

--- item.rights
     (({rights.content}))を返します。0.1.6以前と同じ挙動です。
--- item.rights {|rights| ...}
     ブロックに(({rights}))を渡します。
--- item.rights=(value)
     (({rights.content}))に((|value|))を設定します。

--- item.content
     (({content}))を返します。

--- item.id
--- item.id=(value)

--- item.published
--- item.published=(value)

==== item.title

AtomTextConstructを参照してください。

RSSを生成するときは(({content}))しか利用されません。

==== item.links

RSS 2.0/Atomを生成するときに利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- item.links.new_link
     新しく(({link}))を作成し，返します．作成された
     (({link}))は(({link}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       item.links.new_link do |link|
         link.XXX = XXX
         ...
       end

     (({item.links.new_link}))が作成する(({link}))は
     (({maker.channel.links.new_link}))が作成する
     (({link}))と同じAPIを持ちます．

==== item.description

AtomTextConstructを参照してください。

RSSを生成するときは(({content}))しか利用されません。

==== item.authors

RSS 2.0/Atomを生成するときに利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- item.authors.new_author
     新しく(({author}))を作成し，返します．作成された
     (({author}))は(({author}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       item.authors.new_author do |author|
         author.XXX = XXX
         ...
       end

     (({item.authors.new_author}))が作成する(({author}))は
     (({maker.channel.authors.new_author}))が作成する
     (({author}))と同じAPIを持ちます．

==== item.contributors

Atomを生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- item.contributors.new_contributor
     新しく(({contributor}))を作成し，返します．作成された
     (({contributor}))は(({contributor}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       item.contributors.new_contributor do |contributor|
         contributor.XXX = XXX
         ...
       end

     (({item.contributors.new_contributor}))が作成する(({contributor}))は
     (({maker.channel.contributors.new_contributor}))が作成する
     (({contributor}))と同じAPIを持ちます．

==== item.guid

RSS 2.0を生成するときだけ利用されます．

(({content}))を設定する必要があります．

--- item.guid.isPermaLink
--- item.guid.isPermaLink=(value)

--- item.guid.content
--- item.guid.content=(value)

==== item.enclosure

RSS 2.0を生成するときだけ利用されます．

(({url}))，(({length}))，(({type}))を設定する必要があります．

--- item.enclosure.url
--- item.enclosure.url=(value)

--- item.enclosure.length
--- item.enclosure.length=(value)

--- item.enclosure.type
--- item.enclosure.type=(value)

==== item.source

RSS 2.0を生成するときだけ利用されます．

(({url}))，(({content}))を設定する必要があります．

--- item.source.url
--- item.source.url=(value)

--- item.source.content
--- item.source.content=(value)

==== item.categories

RSS 2.0を生成するときだけ利用されます．

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- item.categories.new_category
     新しく(({category}))を作成し，返します．作成された
     (({category}))は(({category}))リストの最後
     に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       item.categories.new_category do |category|
         category.XXX = XXX
         ...
       end

     (({item.categories.new_category}))が作成する
     (({category}))は
     (({maker.channel.categories.new_category}))が作成する
     (({category}))と同じAPIを持ちます．

==== item.rights

AtomTextConstructを参照してください。

RSSを生成するときは(({content}))しか利用されません。

==== item.content

Atomを生成するときのみ利用されます。

--- type
     内容の種類を返します。
--- type=(value)
     ((|value|))はtext、html、xhtmlまたはMIMEタイプを指定しま
     す。

--- src
     種類がMIMEタイプのときの内容のIRIを返します。
--- src=(value)
     種類がMIMEタイプのときの内容のIRIを指定します。

--- content
     種類がtext、htmlあるいはXML用以外のMIMEタイプの場合の
     内容を返します。
--- content=(value)
     種類がtext、htmlあるいはXML用以外のMIMEタイプの場合の内
     容を設定します。Base64エンコーディングが必要なMIMEタイ
     プの場合でもBase64エンコーディングを行った文字列を指定
     する必要はありません。

--- xml_content
     種類がxhtmlあるいはXML用のMIMEタイプの場合の内容を返し
     ます。
--- xml_content=(value)
     種類がxhtmlあるいはXML用のMIMEタイプの場合の内容を設定し
     ます。文字列またはRSS::XML::Elementで指定します。あるい
     は、それらの配列で指定することも出来ます。

--- xhtml
     (({xml_content}))の別名です。
--- xhtml=(value)
     (({xml_content=}))の別名です。

--- xml
     (({xml_content}))の別名です。
--- xml=(value)
     (({xml_content=}))の別名です。

== maker.textinput

RSS 1.0の場合は(({title}))，(({description}))，(({name}))，
(({link}))，(({maker.channel}))を適切に設定する必要がありま
す．

RSS 0.91/2.0の場合は(({title}))，(({description}))，
(({name}))，(({link}))を設定する必要があります．

Atomでは利用されません。

--- maker.textinput.title
--- maker.textinput.title=(value)

--- maker.textinput.description
--- maker.textinput.description=(value)

--- maker.textinput.name
--- maker.textinput.name=(value)

--- maker.textinput.link
--- maker.textinput.link=(value)

== モジュール

以下のモジュールが組み込まれています．

  * Content
  * Dublin Core
  * Syndication
  * TrackBack
  * Image
  * ITunes
  * Slash

=== Content

以下のメソッドを(({item}))に追加します．

--- content_encoded
--- content_encoded=(value)

=== Dublin Core

以下のメソッドを(({maker.channel}))，(({maker.image}))，
(({item}))，(({maker.textinput}))に追加します．

RSS Makerは0.1.3より複数のDublin Coreの要素をサポートしまし
た．そのため，Dublin Core周りのAPIが変更されましたが，0.1.2
以前のAPIも互換性のために残されているので0.1.2以前のために作
成されたスクリプトも動作するはずです．

--- dc_titles.new_title
     新しく<dc:title>要素を追加し，それを返します．
     ブロックを指定した以下のような使いかたを推奨します．

       dc_titles.new_title do |title|
         title.XXX = XXX
         ...
       end

     値を設定するには(({dc_titles.new_title.value=}))や，(({value=}))
     の別名である(({dc_titles.new_title.content=}))を利用でき
     ます．

     現在設定している値を取得するには(({value}))や(({value}))
     の別名である(({content}))を利用できます．

--- dc_descriptions.new_description
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_creators.new_creator
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_subjects.new_subject
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_publishers.new_publisher
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_contributors.new_contributor
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_types.new_type
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_formats.new_format
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_identifiers.new_identifier
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_sources.new_source
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_languages.new_language
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_relations.new_relation
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_coverages.new_coverage
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_rights_list.new_rights
     使用方法は(({dc_titles.new_title}))と同様です．

--- dc_rightses.new_rights
     (({dc_rights_list.new_rights}))の別名です。

--- dc_dates.new_date
     使用方法は(({dc_titles.new_title}))と同様です．


互換性のために，1番初めに現れるDublin Coreの要素を操作する以
下のメソッドも追加します．

--- dc_title
--- dc_title=(value)

--- dc_description
--- dc_description=(value)

--- dc_creator
--- dc_creator=(value)

--- dc_subject
--- dc_subject=(value)

--- dc_publisher
--- dc_publisher=(value)

--- dc_contributor
--- dc_contributor=(value)

--- dc_type
--- dc_type=(value)

--- dc_format
--- dc_format=(value)

--- dc_identifier
--- dc_identifier=(value)

--- dc_source
--- dc_source=(value)

--- dc_language
--- dc_language=(value)

--- dc_relation
--- dc_relation=(value)

--- dc_coverage
--- dc_coverage=(value)

--- dc_rights
--- dc_rights=(value)

--- dc_date
     (({maker.channel}))と(({item}))では(({date}))の別名です．

--- dc_date=(value)
     (({maker.channel}))と(({item}))では(({date=}))の別名です．

=== Syndication

以下のメソッドを(({maker.channel}))に追加します．

--- sy_updatePeriod
--- sy_updatePeriod=(value)

--- sy_updateFrequency
--- sy_updateFrequency=(value)

--- sy_updateBase
--- sy_updateBase=(value)

=== TrackBack

以下のメソッドを(({item}))に追加します．

--- trackback_ping
--- trackback_ping=(value)

--- trackback_abouts

==== trackback_abouts

(({#<<}))，(({#[]}))，(({#[]=}))，(({#first}))，(({#last}))，
(({#push}))，(({#pop}))，(({#shift}))，(({#unshift}))，
(({#each}))、(({#size}))、(({#empty?}))、(({#clear}))、
(({#replace}))など配列と同じメソッドも持ちます．

--- trackback_abouts.new_about
     新しく(({about}))を作成し，返します．作成された
     (({about}))は(({about}))リストの最後に追加されています．
     ブロックを指定した以下のような使いかたを推奨します．

       trackback_abouts.new_about do |about|
         about.XXX = XXX
         ...
       end

+ about

(({about}))は(({trackback_abouts.new_about}))で作成されたオブジェク
トとします．

--- value
--- value=(new_value)

--- resource
    (({value}))の別名です．
--- resource=(new_value)
    (({value=}))の別名です．

--- content
    (({value}))の別名です．
--- content=(new_value)
    (({value=}))の別名です．

=== Image

以下のメソッドを(({item}))に追加します．

--- image_item

また，以下のメソッドを(({channel}))に追加します．

--- image_favicon

==== image_item

Dublin Coreのメソッドも使えます．

--- image_item.about
--- image_item.about=

--- image_item.resource
--- image_item.resource=

--- image_item.image_width
--- image_item.image_width=

--- image_item.width
     (({image_item.image_width}))の別名です．
--- image_item.width=
     (({image_item.image_width=}))の別名です．

--- image_item.image_height
--- image_item.image_height=

--- image_item.height
     (({image_item.image_height}))の別名です．
--- image_item.height=
     (({image_item.image_height=}))の別名です．

==== image_favicon

Dublin Coreのメソッドも使えます．

--- image_item.about
--- image_item.about=

--- image_item.image_size
--- image_item.image_size=

--- image_item.size
     (({image_item.image_size}))の別名です．
--- image_item.size=
     (({image_item.image_size=}))の別名です．

=== ITunes

Podcast用の情報を生成します。RSS 2.0を生成する場合のみ利用さ
れます。

以下のメソッドを(({channel}))に追加します．

--- itunes_author
--- itunes_author=

--- itunes_block
--- itunes_block=

--- itunes_block?
     (({itunes_block}))が(({"yes"}))または(({true}))のときに
     (({true}))を返します。大文字小文字は区別されません。

--- itunes_categories

--- new_itunes_category(text=nil)
     新しく(({itunes_category}))を作成し、返します。
     ((|text|))は(({itunes_category.text}))に設定されます。
     (({itunes_category}))は(({itunes_categories}))リストの最
     後に追加されています。

     (({itunes_categories.new_category}))よりも便利です。

--- itunes_image
--- itunes_image=

--- itunes_explicit
--- itunes_explicit=

--- itunes_explicit?
     (({itunes_explicit}))が(({"yes"}))または(({true}))のときに
     (({true}))を返し、(({"clean"}))または(({false}))のとき
     に(({false}))を返し、それ以外のときに(({nil}))を返しま
     す。大文字小文字は区別されません。

--- itunes_keywords
--- itunes_keywords=(keywords)
     ((|keywords|))は配列またはCSV形式の文字列で指定します。

--- itunes_new_feed_url
--- itunes_new_feed_url=

--- itunes_owner

--- itunes_subtitle
--- itunes_subtitle=

--- itunes_summary
--- itunes_summary=

以下のメソッドを(({item}))に追加します．

--- itunes_author
--- itunes_author=

--- itunes_block
--- itunes_block=

--- itunes_block?
     (({itunes_block}))が(({"yes"}))または(({true}))のときに
     (({true}))を返します。大文字小文字は区別されません。

--- itunes_duration
--- itunes_duration=

--- itunes_duration {|itunes_duration| ...}
     ブロックに(({itunes_duration}))を渡します。

--- itunes_explicit
--- itunes_explicit=

--- itunes_explicit?
     (({itunes_explicit}))が(({"yes"}))または(({true}))のときに
     (({true}))を返し、(({"clean"}))または(({false}))のとき
     に(({false}))を返し、それ以外のときに(({nil}))を返しま
     す。大文字小文字は区別されません。

--- itunes_keywords
--- itunes_keywords=(keywords)
     ((|keywords|))は配列またはCSV形式の文字列で指定します。

--- itunes_subtitle
--- itunes_subtitle=

--- itunes_summary
--- itunes_summary=

==== itunes_categories

--- itunes_categories.new_category

     新しく<itunes:category>要素を追加し，それを返します．
     ブロックを指定した以下のような使いかたを推奨します．

       itunes_categories.new_category do |category|
         category.text = CATEGORY_NAME
         ...
       end

     値を設定するには(({itunes_category.text=}))を使います。

     現在設定している値を取得するには
     (({itunes_category.text}))を使います。

     サブカテゴリを指定するには
     (({itunes_category.new_category.text=}))とします。

+ itunes_category

--- itunes_category.text
--- itunes_category.text=
     カテゴリ名を取得・指定します。

--- itunes_category.new_category
     サブカテゴリを指定します。使用方法は
     (({itunes_categories.new_category}))と同様です。

==== itunes_owner

--- itunes_owner.itunes_name
--- itunes_owner.itunes_name=

--- itunes_owner.itunes_email
--- itunes_owner.itunes_email=

==== itunes_duration

--- itunes_duration.content
--- itunes_duration.content=(content)
     次のどれかの形式で再生時間を指定します。（H: 時間, M:
     分, S: 秒）
       * HH:MM:SS
       * H:MM:SS
       * MM:SS
       * M:SS

--- itunes_duration.hour
--- itunes_duration.hour=

--- itunes_duration.minute
--- itunes_duration.minute=

--- itunes_duration.second
--- itunes_duration.second=

=== Slash

以下のメソッドを(({item}))に追加します。

--- slash_section
--- slash_section=(value)

--- slash_department
--- slash_department=(value)

--- slash_comments
--- slash_comments=(value)

--- slash_hit_parade

     slash:hit_paradeの値を整数の配列で返します。コンマ区切り
     の整数の文字列ではないので注意してください。

--- slash_hit_parade=(value)

     ((|value|))はコンマ区切りの整数の文字列でも整数の配列で
     もどちらでもかまいません。

--- slash_hit_parades
     slash_hit_paradeの別名です。

--- slash_hit_parades=(value)
     slash_hit_parade=の別名です。
