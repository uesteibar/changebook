namespace :seeder do
  desc "Create a bunch of recommendations for demo purposes"
  task :recommendations => :environment do
    recommendations = [
      {valoration: 90, message: "Loved it! One of the best books I've read this year."},
      {valoration: 82, message: "This one was really good!"},
      {valoration: 70, message: "Not bad, it was pretty cool."},
      {valoration: 50, message: "Not a best seller, but I recommend it if you like the genre."},
      {valoration: 75, message: "I liked it!"},
      {valoration: 68, message: "It was as long as good."}
    ]

    Recommendation.destroy_all
    Thank.destroy_all
    Event.where("item_urn LIKE 'recommendation%'").destroy_all
    times = (Book.count * User.count) / 2
    puts "Creating #{times} recommendations"
    print "."
    times.times do
      user = User.all.sample
      book = Book.all.sample
      recommendation = recommendations.sample
      user.recommend(book, recommendation[:message], recommendation[:valoration])
      print "."
    end
    puts "DONE!"
  end

  desc "Create a bunch of thanks for demo purposes"
  task :thanks => :environment do


    Thank.destroy_all
    times = (Recommendation.count * User.count) / 2
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

  desc "Create a bunch of offerings for demo purposes"
  task :ownerships => :environment do
    Ownership.destroy_all
    times = (Book.count * 10)
    puts "Creating #{times} offerings"
    print "."
    times.times do
      user = User.all.sample
      book = Book.all.sample
      user.ownerships.create(book_id: book.id, to_give_away: true)
      print "."
    end
    puts "DONE!"
  end
end
