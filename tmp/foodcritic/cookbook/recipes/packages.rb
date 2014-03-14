node["collectd"]["packages"].each do |pkg|
  package pkg
end

template "#{node["collectd"]["dir"]}/collectd.conf" do
  mode "0644"
  owner root
  group root
  source "collectd.conf.erb"
  notifies :restart, "service[collectd]"
end

service "collectd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  only_if { node["collectd"]["packages"].include?("collectd") }
end
