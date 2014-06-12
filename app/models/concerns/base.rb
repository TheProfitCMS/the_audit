module TheAudit
  module Base
    extend ActiveSupport::Concern

    included do
      include BaseSorts

      scope :audit_scope, ->(params){
        by_ip(params)
        .by_holder(params)
        .by_date_range(params)
        .by_user_agent(params)
        .by_controller_action(params)
        .simple_sort(params)
      }

      scope :by_ip, ->(params){
        ip = params[:ip]
        return nil if ip.blank?
        where(ip: ip)
      }

      scope :by_user_agent, ->(params){
        ua = params[:user_agent]
        return nil if ua.blank?
        where(user_agent: ua)
      }

      scope :by_holder, ->(params){
        return nil if params[:obj_id].blank? && params[:obj_type].blank?
        _type, id = params[:obj_type], params[:obj_id]

        return where(obj_type: _type) if id.blank?
        return where(obj_id: id)      if _type.blank?

        where(obj_type: _type).where(obj_id: id)
      }

      scope :by_date_range, ->(params){
        from, to = params[:date_start], params[:date_end]
        return nil if from.blank? && to.blank?
        return where("audits.created_at > ?", from.to_datetime) if to.blank?
        return where("audits.created_at < ?", to.to_datetime)   if from.blank?
        return where("audits.created_at > ? AND audits.created_at < ?", from.to_datetime, to.to_datetime)
      }

      scope :by_controller_action, ->(params){
        ca = params[:controller_action]
        return nil if ca.blank?

        ctrl, act = ca.split '-'
        return nil if act.blank?

        where(controller_name: ctrl).where(action_name: act)
      }

      belongs_to :user
      belongs_to :obj, polymorphic: true
    end

    def init controller, object = nil, data = {}
      self.obj             = object
      self.action_name     = controller.action_name
      self.controller_name = controller.controller_name

      self.data = data.to_json unless data.blank?

      if r = controller.request
        self.ip          = r.ip
        self.user_agent  = r.user_agent
        self.remote_ip   = r.remote_ip
        self.remote_addr = r.remote_addr
        self.remote_host = r.remote_host
        self.fullpath    = CGI::unescape(r.fullpath || '')
        self.referer     = CGI::unescape(r.referer  || 'direct_visit')
      end

      self
    end
  end
end
