# Puppet module: te_agent

This is a Puppet module for the ThousandEyes Enterprise Agent.  


Platform
--------
- Ubuntu 14.04(trusty) and 16.04 (xenial)
- CentOS/RedHat >=6.3

**Note:** This module needs a Puppet version greater or equal to 4 .

## Usage
Clone the repository into a `te_agent` folder.

Below are several use cases with different install options for the  
ThousandEyes Enterprise Agent.

Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
    <th>Possible values</th>
  </tr>
  <tr>
    <td><tt>agent</tt></td>
    <td>Boolean</td>
    <td>Installs or removes the te-agent package</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>agent_service_enable</tt></td>
    <td>Boolean</td>
    <td>Enables or disables the te-agent service</td>
    <td><tt>*equals agent parameter value*</tt></td>
  </tr>
  <tr>
    <td><tt>browserbot</tt></td>
    <td>Boolean</td>
    <td>Installs or removes Browserbot</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>set_repository</tt></td>
    <td>Boolean</td>
    <td>Includes or not the ThousandEyes repository</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>agent_utils</tt></td>
    <td>Boolean</td>
    <td>Installs or removes the agent utilities</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>international_langs</tt></td>
    <td>Boolean</td>
    <td>Installs or removes the language package</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>account_token</tt></td>
    <td>String</td>
    <td>Account token for the agent</td>
    <td><tt>'account_token' (Sample value)</tt></td>
  </tr>
  <tr>
    <td><tt>log_path</tt></td>
    <td>String</td>
    <td>Agent log path</td>
    <td><tt>'/var/log'</tt></td>
  </tr>
  <tr>
    <td><tt>log_level</tt></td>
    <td>String</td>
    <td>Log level</td>
    <td><tt>'DEBUG'</tt></td>
    <td><tt>'DEBUG','TRACE'</tt></td>
  </tr>
  <tr>
    <td><tt>log_file_size</tt></td>
    <td>Integer</td>
    <td>Log file size (MB)</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>num_log_files</tt></td>
    <td>Integer</td>
    <td>Amount of log files.</td>
    <td><tt>13</tt></td>
  </tr>
  <tr>
    <td><tt>proxy_location</tt></td>
    <td>String</td>
    <td>Proxy location (IP:PORT)</td>
    <td><tt>-</tt></td>
  </tr>
  <tr>
    <td><tt>proxy_user</tt></td>
    <td>String</td>
    <td>Proxy username</td>
    <td><tt>-</tt></td>
  </tr>
  <tr>
    <td><tt>proxy_pass</tt></td>
    <td>String</td>
    <td>Proxy password</td>
    <td><tt>-</tt></td>
  </tr>
  <tr>
    <td><tt>proxy_bypass_list</tt></td>
    <td>String</td>
    <td>Proxy bypass list (Comma separated values)</td>
    <td><tt>-</tt></td>
  </tr>
  <tr>
    <td><tt>proxy_type</tt></td>
    <td>String</td>
    <td>Proxy type</td>
    <td><tt>'DIRECT'</tt></td>
    <td><tt>'DIRECT','STATIC','PAC'</tt></td>
  </tr>
  <tr>
    <td><tt>proxy_auth_type</tt></td>
    <td>String</td>
    <td>Proxy authentication type</td>
    <td><tt>-</tt></td>
    <td><tt>'BASIC','KERBEROS','NTLM'</tt></td>
  </tr>
  <tr>
    <td><tt>crash_reports</tt></td>
    <td>Integer</td>
    <td>Enables or disables crash reports</td>
    <td><tt>1</tt></td>
    <td><tt>0, 1</tt></td>
  </tr>

</table>


 * Default settings
 ```
 class { 'te_agent':
     account_token => 'your_account_token_goes_here',
 }
 ```

 * Set the proxy (http proxy, no auth)

 ```
 class { 'te_agent':
     account_token  => 'your_account_token_goes_here',
     proxy_location => 'proxy.example.com:7070',
     proxy_type     => 'PAC',
 }
 ```


### Example

Execute the following command to use the provided example manifest:

```puppet apply --modulepath path_to_module examples/init.pp```

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
