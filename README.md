# Puppet module: teagent

This is a Puppet module for the ThousandEyes Enterprise Agent.  

## Usage
Below are several use cases with different install options for the  
ThousandEyes Enterprise Agent.

 * Default settings
 ```
 class { 'teagent': 
     account_token => 'your_account_token_goes_here',
 }
 ```

 * Enable browserbot

 ```
 class { 'teagent': 
     account_token => 'your_account_token_goes_here',
     browserbot    => true,
 }
 ```

* Install the ThousandEyes Agent Utilities

 ```
 class { 'teagent':
     account_token => 'your_account_token_goes_here',
     agent_utils   => true,
 }
 ```
     
 * Enable browserbot and install the international language packages

 ```
 class { 'teagent': 
     account_token       => 'your_account_token_goes_here',
     browserbot          => true,
     international_langs => true,
 }
 ```

 * Set the log path location
 
 ```
 class { 'teagent': 
     account_token => 'your_account_token_goes_here',
     log_path   => '/var/log',
 }
 ```

 * Set the proxy (http proxy, no auth)
 
 ```
 class { 'teagent': 
     account_token => 'your_account_token_goes_here',
     proxy_host        => 'proxy.example.com',
     proxy_port    => '8080',
 }
 ```

 * Set the ThousandEyes Enterprise Agent to run with an IPv6 address
 
 ```
 class { 'teagent': 
     account_token => 'your_account_token_goes_here',
     ip_version    => 'ipv6',
 }
 ```

* Don't check the dependencies and don't add the ThousandEyes repository

 ```
 class { 'teagent':
     account_token => 'your_account_token_goes_here',
     set_repo      => false, 
 }
 ```

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
301 Howard Street #1700  
San Francisco, CA  94105  
Attn: ThousandEyes Open Source Projects  
