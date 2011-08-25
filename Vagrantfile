Vagrant::Config.run do |config|
  config.vm.box = "debian-squeeze-minimal-uk"
  config.vm.box_url = "http://oco-vms.s3.amazonaws.com/debian-squeeze-minimal-uk.box"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "oco_bootstrap.pp"
  end
end
