require 'the_audit'
require 'rails'

module TheAudit
  class Engine < Rails::Engine
    #TODO taichiman: We need this lines? 
    # initializer "Assets precompile hook", :group => :all do |app|
    #   app.config.assets.precompile += %w( file.js file.css )
    # end
  end
end