# TheAudit::Routes.mixin(self)
module TheAudit
  class Routes
    def self.mixin mapper
      mapper.namespace :admin do
        mapper.resources :audits, except: [:new, :create]
      end
    end
  end
end

