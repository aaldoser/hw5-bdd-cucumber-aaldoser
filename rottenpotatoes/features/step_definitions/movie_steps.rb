# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
  rlist= rating_list.split(", ")
  rlist.each do |rating|
    if uncheck
      uncheck("ratings_" + rating)
    else
      check ("ratings_" + rating)
    end
  end
  
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  table = page.find(:css, 'table#movies')
  row_count = table.all(:css, 'tr').size - 1
  Movie.count.should be row_count.to_i
  #fail "Unimplemented"
end

Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
  movie1 = page.body.index(movie1)
  movie2 = page.body.index(movie2)
  
  if(movie1>movie2)
    return false 
  end
end
