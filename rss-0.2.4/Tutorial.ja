# -*- rd -*-

= Tutorial.ja

$Id: Tutorial.ja 325 2007-09-09 10:18:31Z kou $

== 注意

RSS ParserはRSS 0.9x/1.0/2.0をサポートしていますが，RSS 0.90
はサポートしてません．ごめんなさい．

Atom・Podcast用モジュール（itunes:XXX要素）を使いたい場合は
0.1.8以降を使ってください。

Slashモジュール（slash:XXX要素）を使いたい場合は0.2.0以降を
使ってください。

== require

0.1.4以前はいろいろrequireしないといけなかったんですが，
0.1.5からは以下のひとつのrequireでよくなりました．

  require 'rss'

== パース

フィードをパースしたい場合はRSS::Parserクラスを使います。
RSS::Parser.parseはフィードの文字列，ファイル名またはURIオブ
ジェクトをパースします。RSS 1.0をパースした場合はRSS::RDFオブ
ジェクトを、RSS 0.9x/2.0をパースした場合はRSS::Rssオブジェク
トを，Atomをパースした場合はRSS::Feedオブジェクトを返します。
パースしたフィードがwell formedなXMLで無い場合は，RSS::Error
のサブクラス(RSS::NotWellFormedError)の例外が発生します。
well formedなXMLなのに，RSS 0.9x/1.0/2.0, Atomのいずれでもな
い場合は，nilが返ります．

例えば、RSS 1.0をバリデーション付きでパースするには以下のよ
うにします。ここで、変数(({rss_source}))にはRSS 1.0形式の文
字列が格納されているものとします。

  require 'rss'
  rss = RSS::Parser.parse(rss_source, true)

RSS::Parser.parseの第二引数は省略するとtrueが指定されたもの
とみなされるので、これは以下のようにも書けます。

  require 'rss'
  rss = RSS::Parser.parse(rss_source)

最初はバリデーション付きでパースして，validではないRSSだった
場合はバリデーション無しでパースするには以下のように書きます。

  require 'rss'
  rss = nil
  begin
    rss = RSS::Parser.parse(rss_source)
  rescue RSS::InvalidRSSError
    rss = RSS::Parser.parse(rss_source, false)
  end

これは(({rss_source}))がRSS 0.9x/1.0/2.0, Atomのどれか分から
ない時にも有効です。

=== 知らない要素の扱い

パーサはデフォルトでは知らない要素(仕様書に規定されていない
要素)を無視します。もし、知らない要素に遭遇した時に例外を発
生させたければ，RSS::Parser.parseの第三引数にfalseを指定して
ください。こうすると、パース中に知らない要素に遭遇した時に
RSS::UnknownTagError例外が発生します。RSS::UnknownTagErrorク
ラスはRSS::InvalidErrorクラスのサブクラスです。

以下のようにすると，より厳密にパースできます。

  RSS::Parser.parse(rss_source, true, false)

== パースされたフィード

フィードをパースするとRSS::RDF, RSS::RDF::Channel, RSS::Rss,
Atom::Feed等のオブジェクトになります。各オブジェクトで子要素
オブジェクトにアクセスするために，要素名と同じ名前のアクセサ
があります。

=== リーダ(reader)

rdf:RDF要素の子要素であるchannel要素を参照するには，以下のよう
にします。

  rss = RSS::Parser.parse(rss_source)
  rss.channel # => /rdf:RDF/channel要素; RSS::RDF::Channel

もし、要素が子要素も属性も持たない場合はStringが返ってきます。
その要素が省略可能ならばnilが返って来るかもしれません。これ
は要素が子要素または属性を持つ場合も同様です。

  rss = RSS::Parser.parse(rss_source)
  rss.channel.description # => /rdf:RDF/channel/text(); String

属性にアクセスする時も同様です。channel要素のrdf:about属性に
アクセスするには以下のようにします。属性の値はStringかnilで
す。

  rss = RSS::Parser.parse(rss_source)
  rss.channel.about # => /rdf:RDF/channel/@about属性; String または nil

同名の複数の子要素があるかもしれないときも同様です。ただし、
リーダに引数を指定しないと最初の子要素が返ってきます。例えば、
rdf:RDF要素の最初のitem要素にアクセスするには以下のようにし
ます。

  rss = RSS::Parser.parse(rss_source)
  rss.item # => /rdf:RDF/item[1]要素; RSS::RDF::Item

3番目のitem要素にアクセスするには以下のようにします。省略さ
れなかったリーダの引数はArray#[]の引数と同じように扱われます。

  rss = RSS::Parser.parse(rss_source)
  rss.item(2) # => /rdf:RDF/item[3]要素; RSS::RDF::Item

子要素すべてを取得したいときは要素名の複数形がリーダとなりま
す。すべてのitem要素を取得するには以下のようにします。

  rss = RSS::Parser.parse(rss_source)
  rss.items # => /rdf:RDF/item要素の配列; [RSS::RDF::Item, ...]

=== ライタ(writer)

rdf:RDF要素の子要素であるchannel要素を設定するには以下のよう
にします。RSS::RDF::Channel.newの第一引数にはrdf:about属性の
値を指定することもできます。

  rss = RSS::Parser.parse(rss_source)
  rss.channel = RSS::RDF::Channel.new(rdf_about_value)

属性値を設定する場合も同様です。

  rss = RSS::Parser.parse(rss_source)
  rss.channel.about = "http://cozmixng.www.cozmixng.org/"

同名の複数の子要素が存在する場合は少し異なります．要素名の複
数形でのメソッドで要素の配列を取得して，その配列に対して
Array#<<やArray#[]=などを用いて要素を設定します．

  rss = RSS::Parser.parse(rss_source)
  item = RSS::RDF::Item.new(rdf_about_value)
  rss.items << item
  rss.items.last == item # => true

注意: item=/set_itemなどはRubyっぽくないので使わないでくださ
い．

== 出力

RSS Parserといっているので誤解されがちですが，RSS/Atomを出力
することもできます．

=== 基本

(({to_s}))するとRSSまたはAtom形式の文字列を返します．

RSS/Atomを出力する流れは以下のようになります．

  * RSS/Atomオブジェクト（(({RSS::RDF}))とか(({RSS::Rss}))と
    か(({RSS::Atom::Feed}))クラスのオブジェクト）を作成する

  * 出力エンコーディングを指定する(省略可)

  * RSS/Atomオブジェクトの(({to_s}))メソッドを呼ぶ

=== xml-stylesheet

xml-stylesheetも出力することができます．

RSSのルート要素（(({RSS::RDF}))または(({RSS::Rss}))）オブジェ
クトおよびAtomのルート要素（(({RSS::Atom::Feed}))または
(({RSS::Atom::Entry}))）オブジェクトはxml_stylesheetsという名
前の配列を持っています．この配列に(({RSS::XMLStyleSheet}))オ
ブジェクトを挿入することでRSS/Atomにxml-stylesheetを関連づけ
ることができます．

  rss.xml_stylesheets << RSS::XMLStyleSheet.new(...)

(({RSS::XMLStyleSheet.new}))には以下のような(({Hash}))または
連想配列を渡します．作成される(({RSS::XMLStyleSheet}))オブジェ
クトは与えられた引数によって初期化されます．

(({Hash})):

  {
    :href => "...",
    :type => "...",
    :title => "...",
    :media => "...",
    :charset => "...",
    :alternate => "...",
  }

連想配列:

  [
    [:href, "..."],
    [:type, "..."],
    [:title, "..."],
    [:media, "..."],
    [:charset, "..."],
    [:alternate, "..."],
  ]

全てのキーは省略可能です．

例えば，xml-stylesheetとしてsample.xslを指定する場合は以下の
ようにします．

  rss.xml_stylesheets << RSS::XMLStyleSheet.new({:href => "sample.xsl"})

本当は(({{:type => "text/xsl"}}))も指定しないといけないとこ
ろですが，拡張子が.xslまたは，.cssの場合は適当に推測してくれ
るので省略可能です．

=== RSS/Atomオブジェクトを作る

既存のRSS/Atomをパースせずに，一から新しくRSS/Atomを作成する
にはRSS Makerが便利です．

以下のように使います．

  require "rss"
  
  rss = RSS::Maker.make("バージョン") do |maker|
    maker.XXX = YYY
    ...
  end

==== シンプルなRSS

例えば，以下のような情報を持つRSS 1.0を生成するとします。

  * サイトのURLはhttp://example.com/
  * サイトの説明文はExample Site
  * サイト名はExample
  * RSS 1.0はhttp://example.com/index.rdfに置く
  * エントリは1つ
    * URLはhttp://example.com/article.html
    * タイトルはSample Article

この場合は以下のようになります。

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"
    
    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
    end
  end

==== 更新時刻を追加

もし，先のエントリが

  * 2004/11/1 10:10

のものならこうします．

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end
  end

サンプル中の

  item.date = ...

は

  item.dc_date = ...

でも構いません．(({#dc_date=}))は(({#date=}))の単なる別名で
す．

==== さらにエントリを追加

さらに，

  * http://example.com/article2.htmlにある
  * Sample Article2という
  * 2004/11/2 10:10に作成された

エントリを持つなら以下のようにします．

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end
  end

==== エントリを並び替える

もし，更新日が新しい順に並び替えたければ

  maker.items.do_sort = true

を追加し，以下のようにします．

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end
  end

==== ロゴの指定

もし，サイトに

  * Example Siteという名前の
  * http://example.com/logo.pngというロゴ

がある場合は以下のようにします．

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end

    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"
  end

==== 検索ページの指定

もし，

  * http://example.com/search.cgiに
  * keywordというパラメタ名で検索できる
  * Search Example Siteという名前で
  * Search Example Site's all textという説明付きの

検索用ページがあったら以下のようにします．

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end

    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"

    maker.textinput.title = "Search Example Site"
    maker.textinput.description = "Search Example Site's all text"
    maker.textinput.name = "keyword"
    maker.textinput.link = "http://example.com/search.cgi"
  end

==== XMLスタイルシートの指定

もし，

  * http://example.com/index.xslにある

xml-stylesheetを追加したい場合は以下のようにします．

  require "rss"
  
  rss = RSS::Maker.make("1.0") do |maker|
    xss = maker.xml_stylesheets.new_xml_stylesheet
    xss.href = "http://example.com/index.xsl"

    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end

    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"

    maker.textinput.title = "Search Example Site"
    maker.textinput.description = "Search Example Site's all text"
    maker.textinput.name = "keyword"
    maker.textinput.link = "http://example.com/search.cgi"
  end

==== RSS 2.0の生成

もし，RSS 2.0を生成したい場合は以下のように，
(({RSS::Maker.make}))の第一引数を変更します．

  require "rss"
  
  rss = RSS::Maker.make("2.0") do |maker|
    xss = maker.xml_stylesheets.new_xml_stylesheet
    xss.href = "http://example.com/index.xsl"

    maker.channel.about = "http://example.com/index.rdf"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end

    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"

    maker.textinput.title = "Search Example Site"
    maker.textinput.description = "Search Example Site's all text"
    maker.textinput.name = "keyword"
    maker.textinput.link = "http://example.com/search.cgi"
  end

==== RSS 0.91の生成

もし，RSS 0.91を生成したい場合は，RSS 2.0の場合と同様に
(({RSS::Maker.make}))の第一引数を(({"0.91"}))に変更します．

  rss = RSS::Maker.make("0.91") do |maker|
    ...
  end

==== Atom 1.0の生成

もし，Atom 1.0を生成したい場合は，RSS 0.91や2.0の場合と同様に
(({RSS::Maker.make}))の第一引数を(({"atom"}))に変更します．

  rss = RSS::Maker.make("atom") do |maker|
    ...
  end

ただし、これだけでは十分ではありません。これは、Atom 1.0では
RSS 1.0/2.0/0.91では必須ではなかった以下の情報が必要となるか
らです。

  * このAtom 1.0の作者
  * このAtom 1.0の更新日

よって、これまでのスクリプトをAtom 1.0を出力するようにするた
めには以下のように変更する必要があります。

  * (({RSS::Maker.make}))の第一引数を(({"atom"}))に変更
  * maker.channel.authorを設定
  * maker.channel.dateを設定

もし、

  * 作者がBobで
  * たった今、作成された

Atom 1.0なら以下のようになります。

  require "rss"
  
  atom = RSS::Maker.make("atom") do |maker|
    xss = maker.xml_stylesheets.new_xml_stylesheet
    xss.href = "http://example.com/index.xsl"

    maker.channel.about = "http://example.com/atom.xml"
    maker.channel.title = "Example"
    maker.channel.description = "Example Site"
    maker.channel.link = "http://example.com/"

    maker.channel.author = "Bob"
    maker.channel.date = Time.now

    maker.items.do_sort = true

    maker.items.new_item do |item|
      item.link = "http://example.com/article.html"
      item.title = "Sample Article"
      item.date = Time.parse("2004/11/1 10:10")
    end

    maker.items.new_item do |item|
      item.link = "http://example.com/article2.html"
      item.title = "Sample Article2"
      item.date = Time.parse("2004/11/2 10:10")
    end

    maker.image.title = "Example Site"
    maker.image.url = "http://example.com/logo.png"

    maker.textinput.title = "Search Example Site"
    maker.textinput.description = "Search Example Site's all text"
    maker.textinput.name = "keyword"
    maker.textinput.link = "http://example.com/search.cgi"
  end

Atom 1.0用の情報を加えたこのスクリプトを最初のRSS 1.0を出
力するスクリプトに戻す場合は、(({RSS::Maker.make}))の第一引
数を(({"1.0"}))に変えるだけです。Atom 1.0用に追加した情報を
削除する必要はありません。それらは単に無視されます。

=== RSS/Atomオブジェクトを変換する

フィードの種類がRSS 1.0/2.0でもAtomでもパースするためのAPIは
以下のように共通です。

  feed = RSS::Parser.parse(feed_xml)

しかし、返ってくるオブジェクトはRSS 1.0オブジェクト
（RSS::RDF）かもしれませんし、Atomオブジェクト
（RSS::Atom::Feed）かもしれません。このため、パースした結果
を使う場合はフィードの種類を意識しなくてはなく、使いづらくな
ります。

RSS Parserが提供する解決方法はユーザに好みのフィードの種類を
選んでもらうというものです。例えば、以下のようにしてRSS 1.0
をRSS 2.0に変換することができます。

o  require 'rss'
  rss10 = RSS::Parser.parse(rss10_xml)
  rss20 = rss10.to_feed("rss2.0")

種類がわからない複数のフィードを扱う場合は以下のようにし、す
べてのフィードをRSS 2.0のように扱うことができます。

  feeds.each do |xml|
    rss20 = RSS::Parser.parse(xml).to_feed("rss2.0")
    ...
  end

また、to_feedは以下のように書くことも出来ます。

  feed.to_rss("1.0") # == feed.to_feed("rss1.0")
  feed.to_rss("2.0") # == feed.to_feed("rss2.0")
  feed.to_atom("1.0") # == feed.to_feed("atom1.0")

形式を変換したときに問題になるのは、変換元のオブジェクトが変
換後の形式に必須の情報を持っていない場合です。この場合は変換
に失敗します（RSS::Errorのサブクラスの例外が発生します）。そ
のため、適宜、必要な情報を補う必要があります。たとえば、RSS
1.0では各item要素にタイトルが必須ですが、RSS 2.0では省略可能
です。そのような場合に対応するために、以下のようにブロックを
使用することが出来ます。

  rss10 = feed.to_rss("1.0") do |maker|
    maker.items.each do |item|
      item.title.content ||= "No title"
    end
  end

to_feedのブロック内で出来ることを理解するためには、to_feedが
どのように動作するかを理解するとよいです。パース結果のオブジェ
クトはフィードの種類に関わらずsetup_makerというメソッドを持っ
ています。これは、自分が持っている情報をRSS Makerに与えるメソッ
ドです。to_feedはRSS::Maker.makeで作ったRSS Makerに対して
setup_makerを行い、他の形式に変換しようとします。ブロックには
setup_makerを行った後のRSS Makerが渡されます。つまり、
to_feedのブロック内で出来ることはRSS Makerに対して出来ること
と同じです。

=== フィードの形式を変換する

上記の方法でパース済みのオブジェクトを変換できるので、フィー
ドを異なる形式のXMLへ変換することは簡単です。

  feed = RSS::Parser.parse(feed_xml)
  new_feed_xml = feed.to_feed("atom1.0").to_s

これを行うための便利なメソッドto_xmlがあります。to_xmlを使う
と以下のように書き直すことができます。

  feed = RSS::Parser.parse(feed_xml)
  new_feed_xml = feed.to_xml("atom1.0")

。。。あまり変わりませんね。to_feedを用いた場合と同じように
ブロックを指定してRSS Makerを操作することも出来ます。ますま
す変わりませんね。

to_feed().to_sではなく、to_xmlを使うことには一長一短がありま
す。to_xmlは変換元のフィードの種類と変換後のフィードの種類が
同じ場合は単にto_sを呼び出すだけです。これにより、同じ形式に
変換する場合の速度があがります（RSS Makerを作って変換、という
ことを省略するので当然です）。しかし、ブロックを指定して変換
後の結果を調整することができません。例えば、以下のようにRSS
1.0からRSS 2.0に変換する場合はブロックが呼ばれます。

  rss10.to_xml("rss2.0") do |maker|
    # makerを操作できる
  end

しかし、以下のようにRSS 1.0からRSS 1.0に変換しようとした場合
はブロックは呼び出されません。

  rss10.to_xml("rss1.0") do |maker|
    # ブロックが呼び出されないのでmakerを操作できない。
  end

このAPIに関しては、どうしたらよいのかまだ悩んでいます。もし、
なにかアイディアがあれば教えてください。

== サンプル

RSS Parserのサンプルスクリプトをいくつか紹介します．これらの
スクリプトはsample/以下に入っています．

=== サンプル1 - 項目一覧

それでは、複数のフィードをパースしてitem要素を表示するスクリ
プトを書いてみましょう。

パースするフィードはファイルに保存されていて引数で与えられる
ものとします。

  require 'rss'
  ARGV.each do |fname|
    feed = nil
    begin
      feed = RSS::Parser.parse(File.read(fname), false)
    rescue RSS::Error
    end

    if feed.nil?
      puts "#{fname}はRSS 0.9x/1.0/2.0, Atom 1.0のいずれでもありません。"
    else
      print_items(feed)
    end
  end

あとはprint_itemsというメソッドを定義するだけです。

RSS::RDF/RSS::Rss/RSS::Atom::Feed/RSS::Atom::Entryには便利の
ためにitemsというメソッドが定義されています。
RSS::RDF/RSS::Rssにはimageというメソッドが定義されています。

itemsはそれぞれ以下を返します。

  * RSS::RDF: 全ての/rdf:RDF/item要素の配列
  * RSS::Rss: 全ての/rss/channel/item要素の配列
  * RSS::Atom::Feed: 全ての/atom:feed/atom:entry要素の配列
  * RSS::Atom::Entry: /atom:entry要素のみが含まれる配列

imageはそれぞれ以下を返します。

  * RSS::RDF: /rdf:RDF/image要素
  * RSS::Rss: /rss/channel/image要素

ここでは、itemsを使って各項目を表示します。

  def print_items(feed)
    feed.items.each do |item|
      puts "#{item.title} : #{item.description}"
    end
  end

これは、RSSフィードに対してはうまく動きますが、Atomフィードに
対してはうまく動きません。それはAtomフィードにはdescription要
素がないからです。そこで、AtomフィードもRSSフィードに変えて
扱うことにします。

  def print_items(feed)
    convert_to_rss10(feed).items.each do |item|
      puts "#{item.title} : #{item.description}"
    end
  end

convert_to_rss10は以下のようになります。

  def convert_to_rss10(feed)
    feed.to_rss("1.0") do |maker|
      maker.channel.about ||= maker.channel.link
      maker.channel.description.content ||= "No description"
      maker.items.each do |item|
        item.title.content ||= "No title"
        item.link ||= "UNKNOWN"
      end
    end
  end

未設定の可能性がある要素にデフォルト値を設定しています。

出力する文字コードを変更するにはoutput_encoding=が使えます。
もし、変換できないエンコーディングが指定された場合は
RSS::UnknownConversionMethodError例外が発生します。

先程のprint_itemsをEUC-JPで出力するように書き換えてみましょう。

  def print_items(feed)
    rss10 = convert_to_rss10(feed)
    begin
      rss10.output_encoding = "EUC-JP"
    rescue RSS::UnknownConversionMethodError
    end
    rss10.items.each do |item|
      puts "#{item.title} : #{item.description}"
    end
  end

=== サンプル2 - 更新順表示

次はDublin Coreモジュールのdate属性を使って更新順にitemを表
示してみましょう。

最初に現れたDublin Coreモジュールの要素にアクセスするには
「dc_要素名」というアクセサが用意されています。全ての要素の
配列にアクセスするには「dc_要素の複数形」（dc_rightsは
dc_rights_listになります）とします．

複数形でアクセスした場合は「要素の内容を表す文字列」ではなく，
「要素を表すオブジェクト」の配列が返ります．「要素を表すオブ
ジェクト」から「要素の内容を表す文字列」を取得するには
(({content}))メソッドやその別名である(({value}))メソッドを利
用します．「要素の内容を表す文字列」を設定するには
(({content=}))メソッドやその別名である(({value=}))メソッドを
利用します．

  rss.channel.dc_title  # => 「要素の内容を表す文字列」
                        # （"My site"など）

  rss.channel.dc_titles # => 「要素を表すオブジェクト」の配列
                        # （[DublinCoreTitleオブジェクト, ...]）

  rss.channel.dc_titles.collect {|title| title.value}
                        # => 「要素の内容を表す文字列」の配列
                        # （["My site", ...]など）

  rss.channel.dc_titles.first.value == rss.channel.dc_title
                        # => true
  # 厳密にはこう
  first_title = rss.channel.dc_titles.first
  first_title = first_title.value if first_title
  first_title == rss.channel.dc_title
                        # => true

ちなみにSyndicationモジュールの要素にアクセスするには「sy_要
素名」というアクセサが，Contentモジュールの要素にアクセスす
るには「content_要素名」というアクセサが用意されています。

サンプル1と同じようにパースするRSSはファイルに保存されていて
引数で与えられるものとします。

  require 'rss'
  items = []
  ARGV.each do |fname|
    rss_source = nil
    File.open(fname) do |f|
      rss_source = f.read
    end

    rss = nil
    begin
      rss = RSS::Parser.parse(rss_source, true)
    rescue RSS::Error
    end

    if rss.nil?
      puts "#{fname}はRSS 1.0ではありません。"
    else
      begin
        rss.output_encoding = "euc-jp"
      rescue RSS::UnknownConversionMethodError
      end
      rss.items.each do |item|
        items << item if item.dc_date
      end
    end
  end
  print_items(items)

あとはprint_itemsというメソッドを定義するだけです。

Item#dc_dateはTimeオブジェクトかnilを返します。引数の
(({items}))にはdc_dateがnilではないものしか含まれていないは
ずなので以下のようにソートできます。

  def print_items(items)
    items.sort do |x, y|
      y.dc_date <=> x.dc_date
    end.each do |item|
      puts "#{item.dc_date.localtime.iso8601} : #{item.title} : #{item.description}"
    end
  end

=== サンプル3 - 複数のフィードをブレンド

TODO: sample/blend.rbを元にしたサンプルを書く．

=== サンプル4 - フィードを変換する

TODO: sample/convert.rbを元にしたサンプルを書く．
