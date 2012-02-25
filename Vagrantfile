Vagrant::Config.run do |config|
  config.vm.box = "oco-dev"
  config.vm.box_url = "http://oco-vms.s3.amazonaws.com/oco-dev.box"
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "oco_bootstrap.pp"
  end
end
