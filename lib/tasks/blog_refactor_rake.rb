require_relative '../store/pipeline_store_emulator'
require_relative '../steps/all_steps'

# TODO: Split steps into their own files
# Dir.glob(File.dirname(File.absolute_path(__FILE__)) + '/steps/*', &method(:require))

def define_task(description, *args, &block)
  desc description
  Rake::Task.define_task(*args, &block)
end

# this assumes a pipeline-scoped param store is required by every pipeline step
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

    # TODO: fix me
    # tasks write log messages to the store, which is hooked up via 'enhance'
    Rake::Task['pipeline:build:' + t[:name]].enhance do |e|
      tasks = @store.get(attrib_name: 'tasks_executed')
      @store.put(attrib_name: 'tasks_executed', value: (tasks.nil? ? [] : tasks) << { name: e.name, time: Time.now.strftime('%c') })
      @store.save
    end

  end

  # apply a built-in dependency to lazily-instantiate the store
  task task_sym => [ :setup_store ]
end
