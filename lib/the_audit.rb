require "the_audit/version"

module TheAudit
  def self.is_bot? user_agent
    !!user_agent.to_s.match(/bot|riddler/mix)
  end

  class Engine < Rails::Engine; end
  # initializer "Assets precompile hook", :group => :all do |app|
  #   app.config.assets.precompile += %w( file.js file.css )
  # end
end

_root_ = File.expand_path('../../', __FILE__)

# Loading of concerns
require "#{_root_}/app/controllers/concerns/controller.rb"
require "#{_root_}/config/routes.rb"

%w[ base ].each do |concern|
  require "#{_root_}/app/models/concerns/#{concern}.rb"
end
