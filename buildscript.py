# Original app builder script, just here for archive
from os import system, chdir
name = "OpenSpacesBoard"
system("rails new " + name)
chdir(name)
system("rails generate model SpaceTime room sesson start_time:datetime end_time:datetime available:boolean")
system("rails generate model Topic convener description title space_time:references")

file("app/models/space_time.rb", 'w').write("""
class SpaceTime < ActiveRecord::Base
  has_one :topic
end
""")

system("rake db:migrate")

"""
class SpaceTime < ActiveRecord::Base
  has_one :topic
end

class Topic < ActiveRecord::Base
  belongs_to :space_time
end


seeds.db file:
SpaceTime.create([
    { room: "Downstairs", time: "11 - 12" },
    { room: "Upstairs", time: "11 - 12" },
])
"""