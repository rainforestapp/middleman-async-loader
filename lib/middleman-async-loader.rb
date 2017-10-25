require "middleman-core"

Middleman::Extensions.register :async_loader do
  require 'middleman-async-loader/extension.rb'
  Middleman::AsyncLoader
end
