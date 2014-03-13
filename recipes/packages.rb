node["collectd"]["packages"].each do |pkg|
  package pkg
end

template 'collectd.conf' do
  path "#{node["collectd"]["dir"]}/collectd.conf"
  owner 'root'
  group 'root'
  mode 0644
  notifies :restart, 'service[collectd]'
end

service "collectd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  only_if { node["collectd"]["packages"].include?("collectd") }
end
