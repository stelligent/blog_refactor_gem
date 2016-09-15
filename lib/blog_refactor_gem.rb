require 'blog_refactor_gem/version'
require 'store/pipeline_store_emulator'
Dir[File.join(".", "steps/**/*.rb")].each do |f|
  require f
end
