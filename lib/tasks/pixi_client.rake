namespace :pixi_client do
  desc 'Create .example file'
  task :download_wsdl do
    touch '.example'
  end

  task :install => [:download_wsdl] do
  end
end
