require "middleman-core"

Middleman::Extensions.register :async_loader do
  require 'middleman-async-loader.rb'
  Middleman::AsyncLoader
end
