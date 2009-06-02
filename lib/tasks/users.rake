namespace :users do 
  desc "create default users"
  task :create => :merb_env do

    DataMapper.auto_migrate!

    [['james@abscond.org', 'James Darling']].each do |(email, name)|
      Member.create!(:email=>email, :name=>name, :password=>'oneclick') if Member.all(:email=>email).empty?
    end
  end
end