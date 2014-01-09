require "the_audit/engine"
require "the_audit/version"

module TheAudit; end


_root_ = File.expand_path('../../', __FILE__)

# Loading of concerns
require "#{_root_}/app/controllers/concerns/controller.rb"

%w[ base ].each do |concern|
  require "#{_root_}/app/models/concerns/#{concern}.rb"
end
