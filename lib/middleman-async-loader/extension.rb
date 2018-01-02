require 'middleman-core'

class Middleman::AsyncLoader < Middleman::Extension
  helpers do
    def load_css(*sources, **opts)
      bundle_sources(sources, :css, false, **opts)
    end

    def load_font(*sources, **opts)
      bundle_sources(sources, :css, true, **opts)
    end

    def load_js(*sources, **opts)
      bundle_sources(sources, :js, false, **opts)
    end

    def load_js_in_order(*sources, **opts)
     string = ''
     sources.reverse.each do |source|
        string = "___asl('js','#{asset_path(:js, source)}',false,#{options_string(opts)})#{maybe_on_load(string)};"
      end
      bootstrap() + string
    end

    alias :async_js :load_js
    alias :async_font :load_font
    alias :async_css :load_css
    alias :async_js_in_order :load_js_in_order

    private

    def options_string **opts
      s = "'"
      if opts.has_key? :integrity
        s += Array(opts[:integrity]).join " "
      end
      s += "','"
      if opts.has_key? :crossorigin
        s += opts[:crossorigin]
      end
      return s + "'"
    end

    def async_wrap string
      "(function(){#{string}}());"
    end

    def maybe_on_load string
      return '' if string.empty?
      ".onload=function(){#{string}}"
    end

    def bundle_sources(sources, type, isFont = false, **opts)
      bootstrap() + async_wrap(sources.map do |source|
        "___asl('#{type.to_s}','#{asset_path(type, source)}',#{isFont ? 'true':'false'},#{options_string(opts)});"
      end.reduce(:+))
    end

    def bootstrap
      return "" if @has_loaded == true
      @has_loaded = true
      "window.___asl=function(t,f,wf,i,c){var d=document,e=d.createElement(t=='css'?'link':'script');e[t=='css'?'href':'src']=f;e[t=='css'?'rel':'type']=t=='css'?'stylesheet':'text/javascript';if(wf){e.rel='subresource'};e.integrity=i;e.crossOrigin=c;d.body.appendChild(e);return e;};"
    end
  end
end
