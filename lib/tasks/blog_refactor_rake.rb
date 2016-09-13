require_relative '../store/PipelineStoreEmulator'
require_relative '../steps/BaseSteps'

# TODO: Split steps into their own files
# Dir.glob(File.dirname(File.absolute_path(__FILE__)) + '/steps/*', &method(:require))

def define_task(description, *args, &block)
  desc description
  Rake::Task.define_task(*args, &block)
end

# this assumes a param-store is required by every pipeline step
define_task('Lazy-initialization of param-store; required by all steps', :setup_store) do
  @store = BlogRefactorGem::PipelineStoreEmulator.new(json_file: @store_path) if @store.nil?
end

@meta[:steps].each do |step|
  task_sym = "#{@meta[:pipeline]}:#{step[:phase]}:#{step[:name]}".to_sym

  define_task(step[:description], task_sym) do |t, args|
    # derive worker class namespace::name
    pipeline = @meta[:pipeline].capitalize
    phase = step[:phase].capitalize
    job = step[:name].split('_').collect(&:capitalize).join
    class_ref = "#{pipeline}::#{phase}::#{job}"

    # instantiate worker (with store instance)
    Object::const_get(class_ref).new(store: @store)
  end

  # apply a built-in dependency to lazily-instantiate the store
  task task_sym => [ :setup_store ]
end
