#
# Cookbook Name:: freeipa
# Recipe:: default
#
# Copyright 2014, Webhosting.coop
#
#
ipa_admin_password = default["freeipa"]["ipa_admin_password"]
hostname = default["freeipa"]["hostname"] 
domain = default["freeipa"]["domain"] 
dir_manager_password = default["freeipa"]["dir_manager_password"] 
realm_name = default["freeipa"]["realm_name"]

hostsfile_entry node['ipaddress'] do
    hostname  default["freeipa"]["hostname"]
    action    :create_if_missing
end
package "freeipa-server" do
  action [:install]
end

script "install freeipa" do
  interpreter "bash"
  user "root"
  group "root"
  cwd "/tmp"
  code <<-EOH
  ipa-server-install -U --no-host-dns -a #{ipa_admin_password} --hostname=#{hostname} -n #{domain} -p #{dir_manager_password} -r #{realm_name}
  EOH
end
