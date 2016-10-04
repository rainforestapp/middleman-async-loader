## middleman-async-loader
Provides helper to asynchronously load assets (css, js, webfonts) via injecting script and link tags in Middleman for performance optimisations.

### Install

- Just put `gem 'middleman-async-assets'` in your Gemfile
- then `bundle`
- In your `config.rb`, put following

```ruby
activate :async_assets
```

### Usage

The helper generates javascript. So you need to use it inside a script tag like so:

```haml
%script
  = async_css 'screen'
  = async_js 'https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js', 'boom', 'whatever'
  = async_font 'https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
```

And you can also load js assets like this:
```haml
%scripts
  = async_js_in_order 'jquery', 'my-thing-dependent-on-jquery'
```

