###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :layout, "main"

activate :directory_indexes
activate :gemoji

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
  set :disqus_shortname, "theblogofgrantammons_dev"
  set :url_root, 'http://localhost'
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
  set :disqus_shortname, "theblogofgrantammons"
  set :url_root, 'http://grantammons.me'
end

activate :blog do |blog|
  blog.layout = "main"
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "articles/{year}-{month}-{day}-{title}.html"
  blog.taglink = "tag/{tag}.html"
  # blog.layout = "layout"
  blog.summary_separator = /<!--more-->/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :google_analytics do |ga|
    ga.tracking_id = 'UA-37191428-1'
end

ready do
  # blog.tags.each do |tag, articles|
  #   proxy "/tag/#{tag.downcase.parameterize}/feed.xml", '/feed.xml', layout: false do
  #     @tagname = tag
  #     @articles = articles[0..5]
  #   end
  # end

  #proxy "/author/#{terize}.html", '/author.html', ignore: true
end

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, gh_blockcode: true, smartypants: true, footnotes: true, link_attributes: { rel: 'nofollow' }, tables: true
activate :syntax, line_numbers: false

set :casper, {
  blog: {
    url: 'http://grantammons.me',
    name: 'Grant Ammons',
    description: 'My thoughts as a developer and engineering leader',
    date_format: '%d %B %Y',
    navigation: false,
    logo: nil # Optional
  },
  author: {
    name: 'Grant Ammons',
    bio: nil, # Optional
    location: 'Philly', # Optional
    website: nil, # Optional
    gravatar_email: 'gammons@gmail.com', # Optional
    twitter: 'gammons' # Optional
  },
  navigation: {
    "Home" => "/",
    "About me" => "/about"
  }
}
