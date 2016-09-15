require 'blog_refactor_gem/version'
#require 'steps/all_steps'
Dir[File.join(".", "steps/**/*.rb")].each do |f|
  require f
end
require 'store/pipeline_store_emulator'
