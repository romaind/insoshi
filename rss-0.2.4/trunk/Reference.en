# -*- rd -*-

= Reference.en

$Id: Reference.en 341 2007-12-02 06:07:26Z kou $

This is a reference of RSS Maker.

You can understand RSS Parser's API easily if you know
the elements of RSS. And I abbreviate it because you'll be
able to use it, sorry.

== Note

I don't use traditional notation of Ruby's method like
(({Class#instance_method})) and (({Class.class_method})). I
use the same notation of code. In fact, I write the
following when I show instance method (({meth})) of (({obj})):

  obj.meth

A (({maker})) which is appeared in the following is
block argument name of (({RSS::Maker.make})). That is, the
(({maker})) is a (({maker})) in the following.

  RSS::Maker.make(...) do |maker|
    ...
  end

--- RSS::Maker.make(version, &block)
     ((|version|)) is (({"1.0"})), (({"0.91"})), (({"0.9"}))
     or (({"2.0"})). Note that (({"0.9"})) is the same as
     (({"0.91"})). You can prepend (({"rss"})) like the
     following:
     (({"rss1.0"}))/(({"rss2.0"}))/(({"rss0.9"}))/(({"rss0.91"}))

     To make Atom feed document, you need to specify one of
     them:
     (({"atom"}))/(({"atom:feed"}))/(({"atom1.0"}))/(({"atom1.0:feed"}))

     To make Atom entry document, you need to specify one of
     them:
     (({"atom:entry"}))/(({"atom1.0:entry"}))

     This returns RSS object which is made by the
     (({maker})) object after yields ((|block|)).

== Models

Some objects have common API.

=== AtomTextConstruct

(({maker.channel.title})) and some objects can handle not
only a text but also a tagged text, a XML element and so on
by supporting Atom.

--- type
     Returns a type of content.
--- type=(value)
     ((|value|)) is one of text, html or xhtml.

--- content
     Returns a content for text or html type.
--- content=(value)
     Sets a content for text or html type.

--- xml_content
     Returns a content for xhtml type.
--- xml_content=(value)
     Sets a content for xhtml type. ((|value|)) is one
     of them: a string, RSS::XML::Element or an array of them.

--- xhtml
     Is an alias of (({xml_content})).
--- xhtml=(value)
     Is an alias of (({xml_content=})).

=== AtomPersonConstruct

A model to represent a person is introduced by supporting
Atom. The model has the following methods:

--- name
--- name=(value)

--- uri
--- uri=(value)

--- email
--- email=(value)


== maker

This is an object which makes root element of RSS or Atom.

RSS or Atom object doesn't be made if you don't configure
(({maker.channel})) or (({maker.items})) appropriately.

--- maker.version
     Returns XML version.

--- maker.version=(value)
     Sets XML version.

--- maker.encoding
     Returns XML encoding. The default value is UTF-8.

--- maker.encoding=(value)
     Sets XML encoding. You need to use same encoding of it
     when you set some values to the (({maker})).

--- maker.standalone
     Returns XML standalone.

--- maker.standalone=(value)
     Sets XML standalone.

--- maker.feed_version
     Returns a feed version to make.

--- maker.rss_version
     Is an alias of (({maker.feed_version})).

--- maker.xml_stylesheets
     Returns a object which administrate some
     (({xml_stylesheet}))s.

--- maker.channel
     Returns a object which makes channel element. It makes
     atom:feed element for Atom feed document.

--- maker.image
     Returns a object which makes image element. It makes
     atom:feed/atom:logo element for Atom feed document.

--- maker.items
     Returns a object which administrate some
     (({item}))s. It corresponds with atom:feed/atom:entry
     elements for Atom feed document. The first item is used
     for Atom entry document.

--- maker.textinput
     Returns a object which makes texti(I)nput element.

=== maker.xml_stylsheets

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.xml_stylesheets.new_xml_stylesheet
     Makes new (({xml_stylesheet})) and returns it. It is
     appended to (({xml_stylesheet})) list. Using with block
     style is recommended like the following:

       maker.xml_stylesheets.new_xml_stylesheet do |xss|
         xss.XXX = XXX
         ...
       end

==== xml_stylesheet

(({xml_stylesheet})) is the object which is made by
(({maker.xml_stylesheet.new_xml_stylesheet})).

You need to specify (({href})) and (({type})). But you can
omit (({type})) when you specify (({href})) which value's
extension is .xsl or .css. Because RSS Maker can guess it.

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

(({maker.channel})) configures values of channel element for
RSS document and atom:feed element for Atom feed
document. Some values are used as default value for Atom
entry document.

In RSS 1.0 case, you need to specify (({about})),
(({title})), (({link})) and (({description})).

In RSS 0.91 case, you need to specify (({title})), (({link})),
(({description})) and (({language})).

In RSS 2.0 case, you need to specify (({title})), (({link}))
and (({description})).

In Atom feed document case, you need to specify (({title})),
(({updated})) and (({id})). You also need to specify
(({author})) if one of (({maker.items})) at least doesn't
specify (({author})).

(({RSS::NotSetError})) exception is raised if you don't set
the above required values.

There are methods that doesn't have description. They are
just an accessor.

--- maker.channel.about
--- maker.channel.about=(value)

--- maker.channel.title
     Returns (({title.content})). It's same behavior as
     0.1.6 or earlier.
--- maker.channel.title {|title| ...}
     Pass ((|title|)) to the given block.
--- maker.channel.title=(value)
     Sets (({title.content})) as ((|value|)).

--- maker.channel.links
     Returns (({links})).
--- maker.channel.link
     Returns (({href})) of the first element of (({links})).
     If (({links})) is empty, returns (({nil})).
--- maker.channel.link=(value)
     Sets (({href})) of the first element of (({links})) as
     ((|value|)). If (({links})) is empty, makes new
     (({link})) by (({links.new_link})) and sets (({href})).

--- maker.channel.description
     Returns (({description.content})). It's same behavior as
     0.1.6 or earlier.
--- maker.channel.description {|description| ...}
     Pass ((|description|)) to the given block.
--- maker.channel.description=(value)
     Sets (({description.content})) as ((|value|)).

--- maker.channel.subtitle
     Is an alias of (({maker.channel.description})).
--- maker.channel.subtitle=(value)
     Is an alias of (({maker.channel.description=})).

--- maker.channel.language
--- maker.channel.language=(value)

--- maker.channel.copyright
     Returns (({copyright.content})). It's same behavior as
     0.1.6 or earlier.
--- maker.channel.copyright {|copyright| ...}
     Pass ((|copyright|)) to the given block.
--- maker.channel.copyright=(value)
     Sets (({copyright.content})) as ((|value|)).

--- maker.channel.rights
--- maker.channel.rights {|rights| ...}
     Is an alias of (({maker.channel.copyright})).
--- maker.channel.rights=(value)
     Is an alias of (({maker.channel.copyright=})).

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
     Is an alias of (({maker.channel.date})).
--- maker.channel.pubDate=(value)
     Is an alias of (({maker.channel.date=})).

--- maker.channel.updated
     Is an alias of (({maker.channel.date})).
--- maker.channel.updated=(value)
     Is an alias of (({maker.channel.date=})).

--- maker.channel.lastBuildDate
--- maker.channel.lastBuildDate=(value)

--- maker.channel.generator
     Returns (({generator.content})).
--- maker.channel.generator {|generator| ...}
     Pass ((|generator|)) to the given block.
--- maker.channel.generator=(value)
     Sets (({generator.content})) as ((|value|)).

--- maker.channel.ttl
--- maker.channel.ttl=(value)

--- maker.channel.categories
     returns (({categories})).

--- maker.channel.cloud
     returns (({cloud})).

--- maker.channel.skipDays
     returns (({skipDays})).

--- maker.channel.skipHours
     returns (({skipHours})).

--- maker.channel.authors
     Returns (({authors})).
--- maker.channel.author
     Returns (({name})) of the first element of (({authors})).
     If (({authors})) is empty, returns (({nil})).
--- maker.channel.author=(value)
     Sets (({name})) of the first element of (({authors}))
     as ((|value|)). If (({authors})) is empty, makes new
     (({author})) by (({authors.new_author})) and sets
     (({name})).

--- maker.channel.contributors
     Returns (({contributors})).
--- maker.channel.contibutor
     Returns (({name})) of the first element of (({contirbutors})).
     If (({contirbutors})) is empty, returns (({nil})).
--- maker.channel.contibutor=(value)
     Sets (({name})) of the first element of (({contributors}))
     as ((|value|)). If (({contributors})) is empty, makes new
     (({contributor})) by (({contributors.new_contributor})) and sets
     (({name})).

--- maker.channel.icon
     Is an alias of (({maker.channel.image_favicon.about})).
--- maker.channel.icon=(value)
     Is an alias of (({maker.channel.image_favicon.about=})).

--- maker.channel.logo
     Is an alias of (({maker.image.url})).
--- maker.channel.logo=(value)
     Is an alias of (({maker.image.url=})).

=== maker.channel.title

See AtomTextConstruct.

(({content})) is used only in RSS case.

=== maker.channel.links

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.channel.links.new_link
     Makes new (({link})) and returns it. It is appended to
     (({link})) list. Using with block style is
     recommended like the following:

       maker.channel.links.new_link do |link|
         link.XXX = XXX
         ...
       end

==== link

(({link})) is the object which is made by
(({maker.channel.links.new_link})).

You need to specify (({href})).

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

See AtomTextConstruct.

(({content})) is used only in RSS case.

=== maker.channel.copyright

See AtomTextConstruct.

(({content})) is used only in RSS case.

=== maker.channel.generator

This is used only in RSS 2.0 or Atom feed document cases.

(({content})) is used only in RSS 2.0 case.

--- maker.channel.generator.uri
--- maker.channel.generator.uri=(value)

--- maker.channel.generator.version
--- maker.channel.generator.version=(value)

--- maker.channel.generator.content
--- maker.channel.generator.content=(value)

=== maker.channel.categories

This is used only in RSS 2.0 case.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.channel.categories.new_category
     Makes new (({category})) and returns it. It is appended to
     (({category})) list. Using with block style is
     recommended like the following:

       maker.channel.categories.new_category do |category|
         category.XXX = XXX
         ...
       end

==== category

(({category})) is the object which is made by
(({maker.channel.categories.new_category})).

You need to specify (({content})).

--- category.domain
--- category.domain=(value)

--- category.content
--- category.content=(value)

=== maker.channel.cloud

This is used only in RSS 2.0 case.

You need to specify all attribute.

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

This is used only in RSS 0.91/2.0 cases.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.channel.skipDays.new_day
     Makes new (({day})) and returns it. It is appended to
     (({day})) list. Using with block style is recommended
     like the following:

       maker.channel.skipDays.new_day do |day|
         day.XXX = XXX
         ...
       end

==== day

(({day})) is the object which is made by
(({maker.channel.skipDays.new_day})).

You need to specify (({content})).

--- day.content
--- day.content=(value)

=== maker.channel.skipHours

This is used only in RSS 0.91/2.0 cases.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.channel.skipHours.new_hour
     Makes new (({hour})) and returns it. It is appended to
     (({hour})) list. Using with block style is recommended
     like the following:

       maker.channel.skipHours.new_hour do |hour|
         hour.XXX = XXX
         ...
       end

==== hour

(({hour})) is the object which is made by
(({maker.channel.skipHours.new_hour})).

You need to specify (({content})).

--- hour.content
--- hour.content=(value)

=== maker.channel.authors

This is used only in Atom feed/entry document case.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.channel.authors.new_author

     Makes new (({author})) and returns it. It is appended to
     (({author})) list. Using with block style is
     recommended like the following:

       maker.channel.authors.new_author do |author|
         author.XXX = XXX
         ...
       end

==== author

See AtomPersonConstruct.

=== maker.channel.contributors

This is used only in Atom feed/entry document case.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.channel.contributors.new_contributor

     Makes new (({contributor})) and returns it. It is appended to
     (({contributor})) list. Using with block style is
     recommended like the following:

       maker.channel.contributors.new_contributor do |contributor|
         contributor.XXX = XXX
         ...
       end

==== contributor

See AtomPersonConstruct.

== maker.image

In RSS 1.0 case, you need to specify (({url})), (({title})),
(({maker.channel.link})) and (({maker.channel})).

In RSS 0.91/2.0 cases, you need to specify (({url})),
(({title})) and (({maker.channel.link})).

In Atom feed document case, you need to specify (({url})).

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

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- maker.items.new_item
     Makes new (({item})) and returns it. It is appended to
     (({item})) list. Using with block style is recommended
     like the following:

       maker.items.new_item do |item|
         item.XXX = XXX
         ...
       end

--- maker.items.do_sort
     Returns current (({do_sort})) value. The default value
     is (({false})).

--- maker.items.do_sort=(boolean_or_proc)
     If you specify (({true})), items are sorted by
     (({item.date})) in descending order. You can customize
     sort way by specify (({Proc})) object.

--- maker.items.max_size
     Returns current (({max_size})) value. The default value
     is (({-1})).

--- maker.items.max_size=(integer)
     Sets max output (({item})) size.

=== item

(({item})) is the object which is made by
(({maker.items.new_item})).

In RSS 1.0/0.91 cases, you need to specify (({title})) and
(({link})).

In RSS 2.0 case, you need to specify (({title})) or
(({description})).

In Atom feed document case, you need to specify (({id})),
(({title})) and (({updated})). If (({id})) is not specified,
(({link})) is used.

In Atom entry document case, you need to specify (({id})),
(({title})), (({updated})) and (({author})). If (({id})) is
not specified, (({link})) is used. If there are no
(({authors})), (({maker.channel.authors})) are used.

--- item.title
     Returns (({title.content})). It's same behavior as
     0.1.6 or earlier.
--- item.title {|title ...}
     Pass ((|title|)) to the given block.
--- item.title=(value)
     Sets (({title.content})) as ((|value|)).

--- item.links
     Returns (({links})).
--- item.link
     Returns (({href})) of the first element of (({links})).
     If (({links})) is empty, returns (({nil})).
--- item.link=(value)
     Sets (({href})) of the first element of (({links})) as
     ((|value|)). If (({links})) is empty, makes new
     (({link})) by (({links.new_link})) and sets (({href})).

--- item.description
     Returns (({description.content})). It's same behavior as
     0.1.6 or earlier.
--- item.description {|description| ...}
     Pass ((|description|)) to the given block.
--- item.description=(value)
     Sets (({description.content})) as ((|value|)).

--- item.summary
--- item.summary {|summary| ...}
     Is an alias of (({item.description})).
--- item.summary=(value)
     Is an alias of (({item.description=})).

--- item.date
--- item.date=(value)

--- item.pubDate
     Is an alias of (({item.date})).
--- item.pubDate=(value)
     Is an alias of (({item.date=})).

--- item.updated
     Is an alias of (({item.date})).
--- item.updated=(value)
     Is an alias of (({item.date=})).

--- item.authors
     Returns (({authors})).
--- item.author
     Returns (({name})) of the first element of (({authors})).
     If (({authors})) is empty, returns (({nil})).
--- item.author=(value)
     Sets (({name})) of the first element of (({authors}))
     as ((|value|)). If (({authors})) is empty, makes new
     (({author})) by (({authors.new_author})) and sets
     (({name})).

--- ite.contributors
     Returns (({contributors})).
--- ite.contibutor
     Returns (({name})) of the first element of (({contirbutors})).
     If (({contirbutors})) is empty, returns (({nil})).
--- ite.contibutor=(value)
     Sets (({name})) of the first element of (({contributors}))
     as ((|value|)). If (({contributors})) is empty, makes new
     (({contributor})) by (({contributors.new_contributor})) and sets
     (({name})).

--- item.comments
--- item.comments=(value)

--- item.guid
     Returns (({guid})).
--- item.enclosure
     Returns (({enclosure})).
--- item.source
     Returns (({source})).
--- item.categories
     Returns (({categories})).

--- item.rights
     Returns (({rights.content})). It's same behavior as
     0.1.6 or earlier.
--- item.rights {|rights ...}
     Pass ((|rights|)) to the given block.
--- item.rights=(value)
     Sets (({rights.content})) as ((|value|)).

--- item.content
     Returns (({content})).

--- item.id
--- item.id=(value)

--- item.published
--- item.published=(value)

==== item.title

See AtomTextConstruct.

(({content})) is used only in RSS case.

==== item.links

They are used only in RSS 2.0 and Atom cases.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- item.links.new_link
     Makes new (({link})) and returns it. It is appended to
     (({link})) list. Using with block style is
     recommended like the following:

       item.links.new_link do |link|
         link.XXX = XXX
         ...
       end

     (({link})) made by (({item.links.new_link})) has same
     API as (({link})) made by
     (({maker.channel.links.new_link})).

==== item.description

See AtomTextConstruct.

(({content})) is used only in RSS case.

==== item.authors

They are used only in RSS 2.0 and Atom cases.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- item.authors.new_author
     Makes new (({author})) and returns it. It is appended to
     (({author})) list. Using with block style is
     recommended like the following:

       item.authors.new_author do |author|
         author.XXX = XXX
         ...
       end

     (({author})) made by (({item.authors.new_author})) has same
     API as (({author})) made by
     (({maker.channel.authors.new_author})).

==== item.contributors

They are used only in Atom cases.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- item.contributors.new_contributor
     Makes new (({contributor})) and returns it. It is appended to
     (({contributor})) list. Using with block style is
     recommended like the following:

       item.contributors.new_contributor do |contributor|
         contributor.XXX = XXX
         ...
       end

     (({contributor})) made by
     (({item.contributors.new_contributor})) has same
     API as (({contributor})) made by
     (({maker.channel.contributors.new_contributor})).

==== item.guid

This is used only in RSS 2.0 case.

You need to specify (({content})).

--- item.guid.isPermaLink
--- item.guid.isPermaLink=(value)

--- item.guid.content
--- item.guid.content=(value)

==== item.enclosure

This is used only in RSS 2.0 case.

You need to specify (({url})), (({length})) and (({type})).

--- item.enclosure.url
--- item.enclosure.url=(value)

--- item.enclosure.length
--- item.enclosure.length=(value)

--- item.enclosure.type
--- item.enclosure.type=(value)

==== item.source

This is used only in RSS 2.0 case.

You need to specify (({url})) and (({content})).

--- item.source.url
--- item.source.url=(value)

--- item.source.content
--- item.source.content=(value)

==== item.categories

This is used only in RSS 2.0 case.

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- item.categories.new_category
     Makes new (({category})) and returns it. It is appended to
     (({category})) list. Using with block style is
     recommended like the following:

       item.categories.new_category do |category|
         category.XXX = XXX
         ...
       end

     (({category})) which is made by
     (({item.categories.new_category})) has the same API as
     (({category})) which is made by
     (({maker.channel.categories.new_category})).

==== item.rights

See AtomTextConstruct.

(({content})) is used only in RSS case.

==== item.content

This is used only in Atom cases.

--- type
     Returns a type of content.
--- type=(value)
     ((|value|)) is one of text, html, xhtml or MIME type.

--- src
     Returns a IRI of a content for MIME type.
--- src=(value)
     Sets a IRI of a content for MIME type as ((|value|)).

--- content
     Returns a content for text or html type or any MIME types
     except for XML.
--- content=(value)
     Sets a content for text/html type or any MIME types
     except for XML as ((|value|)). You don't need to do
     Base64 encoding even if a MIME type requires Base64
     encoding.

--- xml_content
     Returns a content for xhtml type or any MIME types
     for XML.
--- xml_content=(value)
     Sets a content for xhtml type or any MIME types
     for XML as ((|value|)). ((|value|)) is one of them: a
     string, RSS::XML::Element or an array of them.

--- xhtml
     Is an alias of (({xml_content})).
--- xhtml=(value)
     Is an alias of (({xml_content=})).

--- xml
     Is an alias of (({xml_content})).
--- xml=(value)
     Is an alias of (({xml_content=})).

== maker.textinput

In RSS 1.0 case, you need to specify (({title})),
(({description})), (({name})), (({link})) and
(({maker.channel})).

In RSS 0.91/2.0 cases, you need to specify (({title})),
(({description})), (({name})) and (({link})).

This is not used in Atom cases.

--- maker.textinput.title
--- maker.textinput.title=(value)

--- maker.textinput.description
--- maker.textinput.description=(value)

--- maker.textinput.name
--- maker.textinput.name=(value)

--- maker.textinput.link
--- maker.textinput.link=(value)

== Modules

The following modules are available.

  * Content
  * Dublin Core
  * Syndication
  * TrackBack
  * Image
  * ITunes
  * Slash

=== Content

This adds the following methods to (({item})).

--- content_encoded
--- content_encoded=(value)

=== Dublin Core

This adds the following methods to (({maker.channel})),
(({maker.image})), (({item})) and (({maker.textinput})).

RSS Maker supports multiple Dublin Core elements from
0.1.3. This causes API change but RSS Maker still has the
API before 0.1.3. So some scripts for before 0.1.2 will
work.

--- dc_titles.new_title
     Adds new <dc:title> element then returns it. Using with
     block style is recommended like the following:

       dc_titles.new_title do |title|
         title.XXX = XXX
         ...
       end

     You can use (({dc_titles.new_title.value=})) and
     (({dc_titles.new_title.content=})) which is an alias of
     (({value=})) for modifying the value of this.

     You can use (({value})) and (({content})) which is an
     alias of (({value})) for getting the value of this.

--- dc_descriptions.new_description
     The usage of this is same as (({dc_titles.new_title})).

--- dc_creators.new_creator
     The usage of this is same as (({dc_titles.new_title})).

--- dc_subjects.new_subject
     The usage of this is same as (({dc_titles.new_title})).

--- dc_publishers.new_publisher
     The usage of this is same as (({dc_titles.new_title})).

--- dc_contributors.new_contributor
     The usage of this is same as (({dc_titles.new_title})).

--- dc_types.new_type
     The usage of this is same as (({dc_titles.new_title})).

--- dc_formats.new_format
     The usage of this is same as (({dc_titles.new_title})).

--- dc_identifiers.new_identifier
     The usage of this is same as (({dc_titles.new_title})).

--- dc_sources.new_source
     The usage of this is same as (({dc_titles.new_title})).

--- dc_languages.new_language
     The usage of this is same as (({dc_titles.new_title})).

--- dc_relations.new_relation
     The usage of this is same as (({dc_titles.new_title})).

--- dc_coverages.new_coverage
     The usage of this is same as (({dc_titles.new_title})).

--- dc_rights_list.new_rights
     The usage of this is same as (({dc_titles.new_title})).

--- dc_rightses.new_rights
     Is an alias of (({dc_rights_list.new_rights})).

--- dc_dates.new_date
     The usage of this is same as (({dc_titles.new_title})).


For compatibility, this adds the following methods for
handling the first Dublin Core element.

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
     Is an alias of (({date})) in (({maker.channel})) and (({item})).

--- dc_date=(value)
     Is an alias of (({date=})) in (({maker.channel})) and (({item})).

=== Syndication

This adds the following methods to (({maker.channel})).

--- sy_updatePeriod
--- sy_updatePeriod=(value)

--- sy_updateFrequency
--- sy_updateFrequency=(value)

--- sy_updateBase
--- sy_updateBase=(value)

=== TrackBack

This adds the following methods to (({item})).

--- trackback_ping
--- trackback_ping=(value)

--- trackback_abouts

==== trackback_abouts

This has some methods like Array: (({#<<})), (({#[]})),
(({#[]=})), (({#first})), (({#last})), (({#push})),
(({#pop})), (({#shift})), (({#unshift})), (({#each})),
(({#size})), (({#empty?})), (({#clear})), (({#replace}))
and so on.

--- trackback_abouts.new_about
     Makes new (({about})) and returns it. It is appended to
     (({about})) list. Using with block style is recommended
     like the following:

       trackback_abouts.new_about do |about|
         about.XXX = XXX
         ...
       end

+ about

(({about})) is the object which is made by
(({trackback_abouts.new_about})).

--- value
--- value=(new_value)

--- resource
     Is an alias of (({value})).
--- resource=(new_value)
     Is an alias of (({value=})).

--- content
     Is an alias of (({value})).
--- content=(new_value)
     Is an alias of (({value=})).

=== Image

This adds the following methods to (({item})).

--- image_item

And, this adds the following methods to (({channel})).

--- image_favicon

==== image_item

You can use Dublin Core's methods, too.

--- image_item.about
--- image_item.about=

--- image_item.resource
--- image_item.resource=

--- image_item.image_width
--- image_item.image_width=

--- image_item.width
     Is an alias of (({image_item.image_width})).
--- image_item.width=
     Is an alias of (({image_item.image_width=})).

--- image_item.image_height
--- image_item.image_height=

--- image_item.height
     Is an alias of (({image_item.image_height})).
--- image_item.height=
     Is an alias of (({image_item.image_height=})).

==== image_favicon

You can use Dublin Core's methods, too.

--- image_item.about
--- image_item.about=

--- image_item.image_size
--- image_item.image_size=

--- image_item.size
     Is an alias of (({image_item.image_size})).
--- image_item.size=
     Is an alias of (({image_item.image_size=})).

=== ITunes

This module is for Podcast. This module is used only to make
RSS 2.0.

This module adds the following methods to (({channel})).

--- itunes_author
--- itunes_author=

--- itunes_block
--- itunes_block=

--- itunes_block?
     Returns (({true})) if (({itunes_block})) is (({"yes"}))
     or (({true})). (case insensitive)

--- itunes_categories

--- new_itunes_category(text=nil)
     Adds new <itunes:category> element then returns
     it. ((|text|)) is set to (({itunes_category.text})).
     The created <itunes:category> is appended to
     (({itunes_categories})).

     It's convenience rather than
     (({itunes_categories.new_category})).

--- itunes_image
--- itunes_image=

--- itunes_explicit
--- itunes_explicit=

--- itunes_explicit?
     Returns (({true})) if (({itunes_explicit})) is
     (({"yes"})) or (({true})), (({false})) if
     (({itunes_explicit})) is (({"clean"})) or (({false})),
     otherwise (({nil})). (case insensitive)

--- itunes_keywords
--- itunes_keywords=(keywords)
     ((|keywords|)) should be Array of keyword or String as CSV.

--- itunes_new_feed_url
--- itunes_new_feed_url=

--- itunes_owner

--- itunes_subtitle
--- itunes_subtitle=

--- itunes_summary
--- itunes_summary=

And, adds the following methods to (({item})).

--- itunes_author
--- itunes_author=

--- itunes_block
--- itunes_block=

--- itunes_block?
     Returns (({true})) if (({itunes_block})) is (({"yes"}))
     or (({true})). (case insensitive)

--- itunes_duration
--- itunes_duration=

--- itunes_duration {|itunes_duration| ...}
     Passes (({itunes_duration})) to the given block.

--- itunes_explicit
--- itunes_explicit=

--- itunes_explicit?
     Returns (({true})) if (({itunes_explicit})) is
     (({"yes"})) or (({true})), (({false})) if
     (({itunes_explicit})) is (({"clean"})) or (({false})),
     otherwise (({nil})). (case insensitive)

--- itunes_keywords
--- itunes_keywords=(keywords)
     ((|keywords|)) should be Array of keyword or String as CSV.

--- itunes_subtitle
--- itunes_subtitle=

--- itunes_summary
--- itunes_summary=

==== itunes_categories

--- itunes_categories.new_category

     Adds new <itunes:category> element then returns it. Using with
     block style is recommended like the following:

       itunes_categories.new_category do |category|
         category.text = CATEGORY_NAME
         ...
       end

     You can use (({itunes_category.text=})) for modifying
     the value of this.

     You can use (({itunes_category.text})) for getting the
     value of this.

     You can use (({itunes_category.new_category.text=}))
     for adding a sub category.

+ itunes_category

--- itunes_category.text
--- itunes_category.text=
     Sets/gets category name.

--- itunes_category.new_category
     Adds a new sub category. The usage is same as
     (({itunes_categories.new_category})).

==== itunes_owner

--- itunes_owner.itunes_name
--- itunes_owner.itunes_name=

--- itunes_owner.itunes_email
--- itunes_owner.itunes_email=

==== itunes_duration

--- itunes_duration.content
--- itunes_duration.content=(content)
     Sets duration time as the following format (H: hour, M:
     minute, S: second):
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

This adds the following methods to (({item})).

--- slash_section
--- slash_section=(value)

--- slash_department
--- slash_department=(value)

--- slash_comments
--- slash_comments=(value)

--- slash_hit_parade

     returns a value of slash:hit_parade as an array of
     integer or nil. Note that this doesn't return
     comma-separated string.

--- slash_hit_parade=(value)

     ((|value|)) can be a comma-separated integers as string
     or an integer array.

--- slash_hit_parades
     is an alias of slash_hit_parade.

--- slash_hit_parades=(value)
     is an alias of slash_hit_parade=.
