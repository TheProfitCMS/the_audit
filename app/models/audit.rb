class Audit < ActiveRecord::Base
  belongs_to :user
  belongs_to :obj, polymorphic: true
  
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
