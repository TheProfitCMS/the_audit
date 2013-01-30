require 'the_audit'
require 'rails'

module TheAudit
  class Engine < Rails::Engine
    # initializer "Assets precompile hook", :group => :all do |app|
    #   app.config.assets.precompile += %w( file.js file.css )
    # end
  end
end