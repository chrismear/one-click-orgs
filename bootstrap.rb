#!/usr/bin/env ruby

require 'net/https'
require 'uri'

class FetchError < RuntimeError; end

def msg(message)
  puts "[oco-bootstrap] #{message}"
end

def save_https_resource(url, destination)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  
  raise FetchError, "Error response " unless response.is_a?(Net::HTTPSuccess)
  
  File.open(destination, 'w') do |file|
    file << response.body
  end
end

# TODO Display usage instructions.
# TODO Check for presence of dependencies (VirtualBox, Vagrant)

# TODO Replace with canonical URL
BOOTSTRAP_BASE_URL = "https://raw.github.com/chrismear/one-click-orgs/bootstrap"

INSTALL_DIRECTORY = ARGV[0] || 'one-click-orgs'

msg "Bootstrapping into #{INSTALL_DIRECTORY}."

msg "Fetching bootstrap VM config..."
begin
  Dir.mkdir(INSTALL_DIRECTORY)
  Dir.mkdir(File.join(INSTALL_DIRECTORY, 'manifests'))
  save_https_resource(BOOTSTRAP_BASE_URL + '/Vagrantfile', File.join(INSTALL_DIRECTORY, 'Vagrantfile'))
  save_https_resource(BOOTSTRAP_BASE_URL + '/manifests/oco_bootstrap.pp', File.join(INSTALL_DIRECTORY, 'manifests', 'oco_bootstrap.pp'))
rescue => e
  msg "Error fetching config: #{e.message}"
  exit(false)
end
msg "Done."

Dir.chdir(INSTALL_DIRECTORY)

# TODO On Debian, check for vagrant in /var/lib/gems/{1.8,1.9.1}/bin
GEM_BIN_PATHS = ['/usr/local/bin', '/usr/bin', '/bin', '/var/lib/gems/1.9.1/bin', '/var/lib/gems/1.8/bin']
vagrant = nil

msg "Checking for Vagrant install..."
# Try system path
begin
  succeeded = system("vagrant version")
  raise RuntimeError unless succeeded
  vagrant = "vagrant"
rescue => e
end

# Try our list of paths
unless vagrant
  GEM_BIN_PATHS.each do |bin_path|
    begin
      succeeded = system("#{bin_path}/vagrant version")
      raise RuntimeError unless succeeded
      vagrant = "#{bin_path}/vagrant"
    rescue => e
    end
    break if vagrant
  end
end

unless vagrant
  msg "Could not find Vagrant."
  exit(false)
end
msg "Done."

msg "Bootstrapping VM..."
begin
  succeeded = system("#{vagrant} up")
  raise RuntimeError unless succeeded
rescue => e
  msg "Error bootstrapping VM: #{e.message}"
  exit(false)
end
msg "Done."

msg "Provisioning VM with development environment (this may take a while)..."
begin
  succeeded = system("#{vagrant} reload")
  raise RuntimeError unless succeeded
rescue => e
  msg "Error provisioning VM: #{e.message}"
  exit(false)
end
msg "Done."
