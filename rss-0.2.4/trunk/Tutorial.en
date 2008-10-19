# -*- rd -*-

= Tutorial.en

$Id: Tutorial.en 325 2007-09-09 10:18:31Z kou $

Sorry for my funny English :-(

== Note

RSS Parser supports RSS 0.9x/1.0/2.0 excluding 0.90. Sorry.

If you want to handle Atom and/or Podcast module (itunes:XXX
element), use 0.1.8 or later.

If you want to handle Slash module (slash:XXX element), use
0.2.0 or later.

== require

You only require "rss" if you're using RSS Parser 0.1.5 or later:

  require 'rss'

== Parsing

Use RSS::Parser class to parse a feed. RSS::Parser.parse
parse feed string, feed file name or URI object as a
feed. It returns RSS::RDF object when parsing RSS 1.0,
RSS::Rss object when parsing RSS 0.9x/2.0, RSS::Atom::Feed
when parsing Atom feed document 1.0 or RSS::Atom::Entry when
parsing Atom entry document 1.0. If parsed feed is not a
well formed XML, RSS::Parser.parse returns nil or raises a
exception that is a subclass of RSS::Error.

An example of parsing RSS 1.0 with validation is
below, where the variable (({rss_source})) is String of RSS 1.0.

  require 'rss'
  rss = RSS::Parser.parse(rss_source, true)

The second argument of RSS::Parser.parse is true by default,
so it can be left out. The following does the same as the
previous example.

  require 'rss'
  rss = RSS::Parser.parse(rss_source)

First parse RSS with validation, and if it is not valid
parse with non-validation.

  require 'rss'
  rss = nil
  begin
    rss = RSS::Parser.parse(rss_source)
  rescue RSS::InvalidRSSError
    rss = RSS::Parser.parse(rss_source, false)
  end

This is good for when you don't know what kind of feed.

=== Handling of unknown elements.

The Parser's default behavior is to ignore unknown (not
specified in specifications) element. Specify the third
argument of RSS::Parser.parse if you want parser to raise
exception when it comes across an unknown element. The
parser raises RSS::UnknownTagError exception when it comes
across as unknown element. RSS::UnknownTagError is a
subclass of RSS::InvalidError.

If you want to parse a feed strictly (this is default):

  RSS::Parser.parse(rss_source, true, false)

== Parsed feed

A parsed feed is converted to RSS::RDF, RSS::RDF::Channel,
RSS::Rss, RSS::Atom::Feed, and so on. Each object has some
accessors that has the same name of each child element to
access child element.

=== reader

To reference a channel element child element of a rdf:RDF
is below:

  rss = RSS::Parser.parse(rss_source)
  rss.channel # => /rdf:RDF/channel; RSS::RDF::Channel

If the element doesn't have any child elements nor any
attributes, the accessor returns String. If the element is
not required, the accessor may return nil. This is same int
the case of the element having some child elements or some
attributes.

  rss = RSS::Parser.parse(rss_source)
  rss.channel.description # => /rdf:RDF/channel/text(); String

A way of accessing the attribute is same as above. A way of
accessing rdf:about attribute of channel element is like
below. The attribute avlue is String or nil.

  rss = RSS::Parser.parse(rss_source)
  rss.channel.about # => /rdf:RDF/channel/@about; String or nil

To accessing an element that may have some child elements of
same name is same as above. But if you don't specify any
argument to reader, it returns the first child element. For
example, a way of accessing item element that child element
of rdf:RDF element is like below:

  rss = RSS::Parser.parse(rss_source)
  rss.item # => /rdf:RDF/item[1]; RSS::RDF::Item

A way of accessing the third item element is shown below. Not
omitted arguments of reader is handled same as arguments
of Array#[].

  rss = RSS::Parser.parse(rss_source)
  rss.item(2) # => /rdf:RDF/item[3]; RSS::RDF::Item

Plural of a child element name is a reader which get all
children. A way of accessing all the item element is shown below.

  rss = RSS::Parser.parse(rss_source)
  rss.items # => an array of /rdf:RDF/item; [RSS::RDF::Item, ...]

=== writer

A way of setting a channel element that child element of
rdf:RDF element is shown below. You can specify the first
argument of RSS::RDF::Channel.new to value of rdf:about.

  rss = RSS::Parser.parse(rss_source)
  rss.channel = RSS::RDF::Channel.new(rdf_about_value)

A way of setting value of attribute is same as above.

  rss = RSS::Parser.parse(rss_source)
  rss.channel.about = "http://cozmixng.www.cozmixng.org/"

A way of setting a child element is different when existing
some child elements that have same name. You get elements by
a method which name is plural form of element name as array.
And you set element against the array by Array#<<, Array#[]=
and so on.

  rss = RSS::Parser.parse(rss_source)
  item = RSS::RDF::Item.new(rdf_about_value)
  rss.items << item
  rss.items.last == item # => true

NOTE: Don't use item=/set_item and so on because they are
not sense of Ruby.

== Output

RSS Parser can output RSS/Atom.

=== Basic

(({#to_s})) returns string as RSS or Atom format.

The following is the flow to output RSS/Atom:

  * Make RSS/Atom object ((({RSS::RDF})), (({RSS::Rss})),
  (({RSS::Atom::Feed})) and so on).

  * Specify output encoding (optional).

  * Call (({#to_s})) method of RSS/Atom object.

=== xml-stylesheet

RSS Parser can output xml-stylesheet.

Root element of RSS ((({RSS::RDF})) or (({RSS::Rss}))) or
Atom ((({RSS::Atom::Feed})) or (({RSS::Atom::Entry})))
object has an array which name is xml_stylesheets. You can
associated xml-stylesheet with RSS/Atom by inserting
(({RSS::XMLStyleSheet})) object to the array.

  rss.xml_stylesheets << RSS::XMLStyleSheet.new(...)

You pass the following (({Hash})) or associative array to
(({RSS::XMLStyleSheet.new})) as
argument. (({RSS::XMLStyleSheet})) object which is made by
it is initialized by using passed argument.

(({Hash})):

  {
    :href => "...",
    :type => "...",
    :title => "...",
    :media => "...",
    :charset => "...",
    :alternate => "...",
  }

associative array:

  [
    [:href, "..."],
    [:type, "..."],
    [:title, "..."],
    [:media, "..."],
    [:charset, "..."],
    [:alternate, "..."],
  ]

All key is optional.

For example, do the following when you want to specify
sample.xsl as xml-stylesheet.

  rss.xml_stylesheets << RSS::XMLStyleSheet.new({:href => "sample.xsl"})

In fact, you must specify (({{:type => "text/xsl"}})), but
it is optional if the extension is .xsl or .css. Because RSS
Parser can guess the type from those extensions.

=== Making RSS/Atom object

If you want to make RSS/Atom object out of nothing, you can
use RSS Maker.


The usage is the following:

  require "rss"
  
  rss = RSS::Maker.make("VERSION") do |maker|
    maker.XXX = YYY
    ...
  end

==== A simple RSS

For example, to make the following RSS:

  * URI: http://example.com/
  * Description: Example Site
  * Name: Example
  * RSS URI: http://example.com/index.rdf
  * The RSS has an entry:
    * URL: http://example.com/article.html
    * Title: Sample Article

You can write like the following:

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

==== Adding published date

If published date of the previous entry is

  * 2004/11/1 10:10

then you can write like the following:

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

Note:

  item.date = ...

is same as

  item.dc_date = ...

(({#dc_date=})) is only alias of (({#date=})).


==== Adding another entry

If you have another entry:

  * URK: http://example.com/article2.html
  * Title: Sample Article2
  * Date: 2004/11/2 10:10

You can write like the following:

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

==== Sorting entries

If you want to sort the entries by those published date, you
need to add the following:

  maker.items.do_sort = true

And you can write like the following:

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

==== Adding a logo

If your site has the following logo:

  * Title: Example Site
  * URI: http://example.com/logo.png

You can write like the following:

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

==== Adding a search page

If you has a page for searching like the following:

  * URI: http://example.com/search.cgi
  * Parameter name: keyword
  * Title: Search Example Site
  * Description: Search Example Site's all text

You can write like the following:

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

==== Associating Style Sheets with XML

If you want to add a xml-stylesheet like the following:

  * URI: http://example.com/index.xsl

You can write like the following:

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

==== Making RSS 2.0

If you want to make RSS 2.0, you need to change the first
argument of (({RSS::Maker.make})) like the following:

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

==== Making RSS 0.91

If you want to make RSS 0.91, you need to change the first
argument of (({RSS::Maker.make})) to (({"0.91"})).

  rss = RSS::Maker.make("0.91") do |maker|
    ...
  end

==== Making Atom 1.0

If you want to make Atom 1.0, you need to change the first
argument of (({RSS::Maker.make})) to (({"atom"})).

  rss = RSS::Maker.make("0.91") do |maker|
    ...
  end

But there are other tasks. Because Atom 1.0 requires the
following information that is not required by RSS
1.0/2.0/0.91:

  * Author of the Atom 1.0
  * Updated date of the Atom 1.0

To support outputting Atom 1.0, you need to do the following:

  * Change the first argument of (({RSS::Maker.make})) to
    (({"atom"}))
  * Configure maker.channel.author
  * Configure maker.channel.date

If you use the following information:

  * Author: Bob
  * Updated: now

You can rewrite the script like the following:

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

You can change the script to output RSS 1.0. (This is a same
behavior at the first.) You just change the first argument
of the (({RSS::Maker.make})) to (({"1.0"})). You doesn't
need to remove information added for Atom 1.0. It is just
ignored.

=== Converting RSS/Atom object

You can use the following API for parsing RSS 1.0/2.0/0.91
or Atom:

  feed = RSS::Parser.parse(feed_xml)

But returned object may be RSS 1.0 object (RSS:RDF), RSS 2.0
object (RSS::Rss), Atom feed 1.0 object (RSS::Atom::Feed) or
Atom entry 1.0 object (RSS::Atom::Entry). So, you need to
concern with kind of the feed to use the object. And this
is not easy to use.

RSS Parser provides a solution to solve this problem: You
can select a kind of feed what you like. For example, you
can convert RSS 1.0 to RSS 2.0:

  require 'rss'
  rss10 = RSS::Parser.parse(rss10_xml)
  rss20 = rss10.to_feed("rss2.0")

You can handle all feed as RSS 2.0 by converting all feed to
RSS 2.0:

  feeds.each do |xml|
    rss20 = RSS::Parser.parse(xml).to_feed("rss2.0")
    ...
  end

And you can use the following API:

  feed.to_rss("1.0") # == feed.to_feed("rss1.0")
  feed.to_rss("2.0") # == feed.to_feed("rss2.0")
  feed.to_atom("1.0") # == feed.to_feed("atom1.0")

There is a problem that target feed type requires
information what converted feed doesn't have. In this case,
converting is failure. (An exception that subclass of
RSS::Error will be raised.) So, you need to add required
information. For example, RSS 1.0 requires a title for each
item but it is optional in RSS 2.0. To solve this situation,
you can use block:

  rss10 = feed.to_rss("1.0") do |maker|
    maker.items.each do |item|
      item.title.content ||= "No title"
    end
  end

To understand what you can do in block of to_feed, it's good
that you understand how to_feed works. An object parsed by
RSS Parser has setup_maker even if parsed feed type is
different. The method supplies RSS Maker with their own
information. to_feed calls setup_maker with RSS Maker
created by RSS::Maker.make to convert other feed
type. to_feed calls block with setup_maker-ed maker. So, you
can do same tasks against RSS Maker in to_feed's block.

=== Converting feed type

It's easy to convert feed to another feed's XML because you
can convert parsed feed to another feed:

  feed = RSS::Parser.parse(feed_xml)
  new_feed_xml = feed.to_feed("atom1.0").to_s

There is a convenience method to do this, to_xml. You can
rewrite the above codes with to_xml:

  feed = RSS::Parser.parse(feed_xml)
  new_feed_xml = feed.to_xml("atom1.0")

... There is only a small change. You can use block to
handle RSS Maker same as to_feed. It's very similar...

Using to_xml instead of to_feed().to_s has good and bad
points. to_xml just call to_s if converted feed's type and
target feed type is same. So, processing speed is up because
to_xml skips RSS::Maker.make. But you can't modify result by
specifying block. For example, a block specified to to_xml
will be called:

  rss10.to_xml("rss2.0") do |maker|
    # You can handle maker
  end

But a block specified to to_xml will not be called when you
will convert RSS 1.0 from RSS 1.0:

  rss10.to_xml("rss1.0") do |maker|
    # You cannot handler maker because this block is never called.
  end

I don't know whether this API is good or not. If you have a
good idea, please tell me.

== Sample

I introduce some sample scripts of RSS Parser. Those scripts
are included in sample/ directory.

=== Sample1 - List items

Let's write a script that parse feeds and display list of
values of item elements.

Parsed feeds are saved in files and assume thir name is
provided as command line arguments.

  require 'rss'
  ARGV.each do |fname|
    feed = nil
    begin
      feed = RSS::Parser.parse(File.read(fname), false)
    rescue RSS::Error
    end

    if feed.nil?
      puts "#{fname} is not RSS 0.9x/1.0/2.0 or Atom 1.0."
    else
      print_items(feed)
    end
  end

And you need only to define print_items method.

RSS::RDF, RSS::Rss, RSS::Atom::Feed and RSS::Atom::Entry
have a convenience method, items. And RSS::RDF and
RSS::Rss has a image method.

items method returns the following:

  * RSS::RDF: an array of /rdf:RDF/item elements
  * RSS::Rss: an array of /rss/channel/item elements
  * RSS::Atom::Feed: an array of /atom:feed/atom:entry
    elements
  * RSS::Atom::Entry: an array which has /atom:entry element

image method returns the following:

  * RSS::RDF: /rdf:RDF/image element
  * RSS::Rss: /rss/channel/image element

You can use items for this situation:

  def print_items(feed)
    feed.items.each do |item|
      puts "#{item.title} : #{item.description}"
    end
  end

This implementation will work well for RSS feed but not for
Atom feed. Because Atom feed doesn't have description
element. So, you can convert Atom feed to RSS feed:

  def print_items(feed)
    convert_to_rss10(feed).items.each do |item|
      puts "#{item.title} : #{item.description}"
    end
  end

You can define convert_to_rss10 method like the following:

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

You may need to set default value to some element.

You can use output_encoding= to change output encoding. If
specify encoding that can't be converted raise exception
that is RSS::UnknownConvertmethod object.

Let's rewrite above print_items to output UTF-8.

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

=== Sample2 - Display items sorted with update tiem

Next, let's display items sorted with update time using date
attribute of Dublin Core module.

This library has accessors that name `dc_<element_name>' to
access an element of Dublin Core module which appears
first. To access an array of elements, this library has
accessors that name `dc_<plural_element_name>'. (Use
`dc_rights_list' for accessing an array of dc_rights
element.)

You get an array of `an object which describe the element'
instead of `a string which describe the content of element'
when you access by plural form. This library has methods for
getting `a string which describes the content of element'
from `an object which describes the element'. Their names
are (({content})) and (({value})) which is an alias of
(({content})). And this library has methods for putting `a
string which describes the content of element' to `an object
which describes the element'. Their names are (({content=}))
and (({value=})) which is an alias of (({content=})).

  rss.channel.dc_title  # => `a string which describes the
                        #     content of element'
                        # (ex. "My site")

  rss.channel.dc_titles # => an array of `an object which
                        #    describes the element'
                        # (ex. [DublinCoreTitle object, ...])

  rss.channel.dc_titles.collect {|title| title.value}
                        # => an array of `a string which
                        #    describes the content of element'
                        # (ex. ["My site", ...])

  rss.channel.dc_titles.first.value == rss.channel.dc_title
                        # => true
  # more strict
  first_title = rss.channel.dc_titles.first
  first_title = first_title.value if first_title
  first_title == rss.channel.dc_title
                        # => true

By the way it has accessor that name `sy_<element_name>' to
access elements of Syndication module and Content modules's
one is `content_<element_name>'.

Parsed RSSs are saved in files and assume thir name is
provided as command line arguments same as sample1.

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
      puts "#{fname} is not RSS 1.0."
    else
      begin
        rss.output_encoding = "iso-8859-1"
      rescue RSS::UnknownConversionMethodError
      end
      rss.items.each do |item|
        items << item if item.dc_date
      end
    end
  end
  print_items(items)

And define method print_items.

Item#dc_date returns Time object or nil. (({items})) dosen't
have nil, so we can sort like bolow:

  def print_items(items)
    items.sort do |x, y|
      y.dc_date <=> x.dc_date
    end.each do |item|
      puts "#{item.dc_date.localtime.iso8601} : #{item.title} : #{item.description}"
    end
  end


=== Sample3 - To blend some feeds.

TODO: write a sample based on sample/blend.rb.

=== Sample4 - Converting a feed.

TODO: write a sample based on sample/convert.rb.
