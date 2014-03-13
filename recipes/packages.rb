node["collectd"]["packages"].each do |pkg|
  package pkg
end

template "#{node["collectd"]["dir"]}/collectd.conf" do
  mode "0644"
  source "collectd.conf.erb"
  variables(
    :name         => node["collectd"]["name"],
    :dir          => node["collectd"]["dir"],
    :confdir      => node["collectd"]["confdir"],
    :interval     => node["collectd"]["interval"],
    :read_threads => node["collectd"]["read_threads"],
    :plugins      => node["collectd"]["plugins"]
  )
  notifies :restart, "service[collectd]"
end

service "collectd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
  only_if { node["collectd"]["packages"].include?("collectd") }
end
