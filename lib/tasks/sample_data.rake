namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Key Kosmatov",
      :email => "key@kosmatov.su", :password => "foobar",
      :password_confirmation => "foobar"
    )
    admin.toggle!(:admin)
    21.times do |n|
      name = Faker::Name.name
      email = "example-#{n}@kosmatov.su"
      password = "somepassword"
      User.create!(:name => name, :email => email, :password => password,
        :password_confirmation => password
      )
    end
    users = User.all(:limit => 7)
    users.each do |owner|
      users.shuffle.each do |user|
        owner.outstories.create!(
          :content => Faker::Lorem.sentence(5),
          :user_id => user.id
        )
      end
    end
  end
end
