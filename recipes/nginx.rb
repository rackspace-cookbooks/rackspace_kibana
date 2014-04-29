#
# Cookbook Name:: kibana
# Recipe:: nginx
#
# Copyright 2013, John E. Vincent
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set['nginx']['default_site_enabled'] = node['rackspace_kibana']['nginx']['enable_default_site']

include_recipe 'nginx'

template '/etc/nginx/sites-available/kibana' do
  source node['rackspace_kibana']['nginx']['template']
  cookbook node['rackspace_kibana']['nginx']['template_cookbook']
  notifies :reload, 'service[nginx]'
  variables(
    :es_server => node['rackspace_kibana']['es_server'],
    :es_port   => node['rackspace_kibana']['es_port'],
    :server_name => node['rackspace_kibana']['webserver_hostname'],
    :server_aliases => node['rackspace_kibana']['webserver_aliases'],
    :kibana_dir => node['rackspace_kibana']['installdir'],
    :listen_address => node['rackspace_kibana']['webserver_listen'],
    :listen_port => node['rackspace_kibana']['webserver_port']
  )
end

nginx_site 'kibana'
