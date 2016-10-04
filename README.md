middleman-async-loader
=================

Provides helper to asynchronously load JS/CSS in Middleman for performance optimisations.

The helper generates javascript. So you need to use it inside a script tag like so:

```haml
%script
  = async_css "all"
  = async_js "all"
```

Install
=======

- `gem 'middleman-async-assets'` then `bundle`

- In your `config.rb`, put following

```ruby
activate :async_assets
```
