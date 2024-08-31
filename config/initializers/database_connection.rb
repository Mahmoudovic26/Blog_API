Rails.application.config.after_initialize do
    ActiveRecord::Base.connection_pool.disconnect!
  
    ActiveSupport.on_load(:active_record) do
      config = ActiveRecord::Base.configurations.find_db_config(Rails.env)
      config.merge(
        prepared_statements: false,
        advisory_locks: false
      )
      ActiveRecord::Base.establish_connection(config)
    end
  end