# This is an exceptionally cheesy pipeline-store / param-store
# It emulates a pipeline-scoped persistence store.
module BlogGem
  class PipelineStoreEmulator
    require 'json'

    attr_accessor :attribs
    attr_accessor :store_path
    def initialize(json_file:)
      if !File.exist?(json_file)
        File.open(json_file, 'w') { |file| file.write( {}.to_json ) }
      end
      @store_path = json_file
      @attribs = JSON.parse(IO.read(json_file), {:symbolize_names => true})
    end

    def get(attrib_name:)
      @attribs.has_key?(attrib_name.to_sym) ? @attribs[attrib_name.to_sym] : nil
    end

    def put(attrib_name:, value:)
      @attribs[attrib_name.to_sym] = value
      get(attrib_name: attrib_name)
    end

    def save
      File.open(@store_path, 'w') { |file| file.write( JSON.pretty_generate(@attribs) ) }
    end
  end
end
