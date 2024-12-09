# Puppet module: te_agent

This Puppet module installs and configures the ThousandEyes Enterprise Agent.  

## Platform

- Ubuntu 16.04 (xenial), 18.04 (bionic), 20.04 (focal) and 22.04 (jammy)
- CentOS/RedHat 7, 8 and 9

**Note:** This module needs Puppet >= 4. If you want the version for Puppet 3.7, check the `puppet3.7` tag.

## Usage

Clone the repository into a `te_agent` folder.

Below are several use cases with different install options for the  
ThousandEyes Enterprise Agent.

- Default settings

 ```pp
 class { 'te_agent':
     account_token => 'your_account_token_goes_here',
 }
 ```

- Set the proxy (http proxy, no auth)

 ```pp
 class { 'te_agent':
     account_token  => 'your_account_token_goes_here',
     proxy_location => 'proxy.example.com:7070',
     proxy_type     => 'PAC',
 }
 ```

- Set Browserbot memory limit for Chrome container

 ```pp
 class { 'te_agent':
     account_token  => 'your_account_token_goes_here',
     bbot_params    => {
       podman => {
         containerResourceLimitsChrome => {
           memoryLimitBytes => 2362232012,
         },
       },
     },
 }
 ```

and the equivalent in Hiera:
 ```yaml
 te_agent::account_token: 'your_account_token_goes_here'
 te_agent::bbot_params:
   podman:
     containerResourceLimitsChrome:
       memoryLimitBytes: 2362232012
 ```

## Attributes

|Key|Type|Description|Default|Possible values|
|--- |--- |--- |--- |--- |
|account_token|String|Account token for the agent|`'account_token'` (Sample value)|
|agent|Boolean|Installs or removes the te-agent package|`true`|
|agent_service_enable|Boolean|Enables or disables the te-agent service|(equals agent parameter value)|
|agent_utils|Boolean|Installs or removes the agent utilities|`false`|
|browserbot|Boolean|Installs or removes Browserbot|`false`|
|crash_reports|Integer|Enables or disables crash reports|`1`|`0`, `1`|
|international_langs|Boolean|Installs or removes the language package|`false`|
|log_file_size|Integer|Log file size (MB)|`10`|
|log_level|String|Log level|`'DEBUG'`|`'DEBUG'`,`'TRACE'`|
|log_path|String|Agent log path|`'/var/log'`|
|num_log_files|Integer|Amount of log files|`13`|
|proxy_auth_type|String|Proxy authentication type||`'BASIC'`,`'KERBEROS'`,`'NTLM'`|
|proxy_bypass_list|String|Proxy bypass list (Comma separated values)||
|proxy_location|String|Proxy location (IP:PORT)||
|proxy_pass|String|Proxy password||
|proxy_type|String|Proxy type|`'DIRECT'`|`'DIRECT'`,`'STATIC'`,`'PAC'`|
|proxy_user|String|Proxy username||
|set_repository|Boolean|Includes or not the ThousandEyes repository|`true`|
|bbot_params|Hash|Browserbot parameters||Please check [manifests/init.pp](manifests/init.pp#L93-L233) header for more details|

## Example

Execute the following command to use the provided example manifest:

`puppet apply --modulepath path_to_module examples/init.pp`

## License

This program is free software: you can redistribute it and/or modify  
it under the terms of the GNU General Public License as published by  
the Free Software Foundation, either version 3 of the License, or  
(at your option) any later version.

This program is distributed in the hope that it will be useful,  
but WITHOUT ANY WARRANTY; without even the implied warranty of  
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
GNU General Public License for more details.  

You should have received a copy of the GNU General Public License  
along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Contact

If you have questions or comments, please send them to  
opensource+puppet@thousandeyes.com, or to the following address:

ThousandEyes, Inc.  
201 Mission Street, Suite 1700 \
San Francisco, CA, USA \
94105 \
Attn: ThousandEyes Open Source Projects  
