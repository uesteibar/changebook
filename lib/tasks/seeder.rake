namespace :seeder do
  desc "Create a bunch of recommendations for demo purposes"
  task :recommendations => :environment do
    Recommendation.destroy_all
    Event.where("item_urn LIKE 'recommendation%'").destroy_all
    times = (Book.count * 10)
    puts "Creating #{times} recommendations"
    print "."
    times.times do
      user = User.all.sample
      book = Book.all.sample
      user.recommend(book, Faker::Hacker.say_something_smart, Faker::Number.number(2))
      print "."
    end
    puts "DONE!"
  end

  desc "Create a bunch of thanks for demo purposes"
  task :thanks => :environment do
    Thank.destroy_all
    times = (Recommendation.count * 10)
    puts "Creating #{times} thanks"
    print "."
    times.times do
      user = User.all.sample
      recommendation = Recommendation.all.sample
      unless user.thanked?(recommendation)
        recommendation.thanks.create(user_id: user.id)
      end
      print "."
    end
    puts "DONE!"
  end
end
