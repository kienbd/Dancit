# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#



def category_seed
  ["hiphop","jazz","locking","kpop","ballet","breaking","poping","modern"].each do |cat|
    sd = Category.create(name: cat)
    sd.save
  end
end


Category.delete_all
category_seed
