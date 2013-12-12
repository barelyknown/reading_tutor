namespace :export do
  task :words => :environment do
    CSV.open(Rails.root.join("db","seed","words.csv"), "w+") do |csv|
      limit = 1000
      ("a".."z").each do |char|
        print char + " "
        skip = 0
        begin
          words = Wordnik.words.search_words(query: "#{char}*", limit: limit, skip: skip)
          words.each { |w| csv << [w["wordstring"], w["count"]] }
          skip += limit
          print "."
        end while words.size == limit
        puts
      end
    end
    unsorted = CSV.parse(File.read(Rails.root.join("db","seed","words.csv")))
    CSV.open(Rails.root.join("db","seed","words.csv"), "w+") do |sorted|
      unsorted.sort_by { |row| row[1].to_i }.reverse.each do |row|
        sorted << row
      end
    end
  end
end