json.array!(@audits) do |audit|
  json.extract! audit, :id, :user_id, :obj_id, :obj_type, :controller_name, :action_name, :ip, :remote_ip, :fullpath, :referer, :user_agent, :remote_addr, :remote_host, :data
  json.url audit_url(audit, format: :json)
end
