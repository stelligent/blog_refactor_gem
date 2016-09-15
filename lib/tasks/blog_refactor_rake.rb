require_relative '../store/pipeline_store_emulator'
require_relative '../steps/acceptance/automated_testing'
require_relative '../steps/acceptance/environment_configuration'
require_relative '../steps/acceptance/environment_creation'
require_relative '../steps/commit/scm_polling'
require_relative '../steps/commit/static_analysis'
require_relative '../steps/commit/unit_testing'
require_relative '../steps/utils/cfn'

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

    # tasks write log messages to the store, which is hooked up via 'enhance'
    Rake::Task[task_sym.to_s].enhance do |e|
      tasks = @store.get(attrib_name: 'tasks_executed')
      @store.put(attrib_name: 'tasks_executed', value: (tasks.nil? ? [] : tasks) << { name: e.name, time: Time.now.strftime('%c') })
      @store.save
    end
  end

  # apply a built-in dependency to lazily-instantiate the store
  task task_sym => [ :setup_store ]
end
