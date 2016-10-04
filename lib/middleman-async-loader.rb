require 'middleman-core'

class AsyncLoader < Middleman::Extension
  helpers do
    def load_css(*sources)
      bundle_sources(sources, :css)
    end

    def load_font(*sources)
      bundle_sources(sources, :css, true)
    end

    def load_js(*sources)
      bundle_sources(sources, :js, true)
    end

    alias :async_js :load_js
    alias :async_font :load_font
    alias :async_css :load_css

    private

    def async_wrap string
      "(function(){#{string})();"
    end

    def bundle_sources(sources, type, isFont)
      bootstrap() + async_wrap(sources.map { |source|
        "___asl('#{type.to_s}','#{asset_path(type, source)}'#{',true' if isFont});"
      }.reduce(:+))
    end

    def bootstrap
      return "" if @has_loaded == true
      @has_loaded = true
      "window.___asl=function(t,f,wf){var d=document,e=d.createElement(t=='css'?'link':'script');e[t=='css'?'href':'src']=f;e[t=='css'?'rel':'type']=t=='css'?'stylesheet':'text/javascript';if(wf){e.rel='subresource'};d.body.appendChild(e)};"
    end
  end
end

AsyncLoader.register(:async_loader)