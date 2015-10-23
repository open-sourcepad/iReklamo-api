# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

module SeedEverything
  def self.go
    complainer = User.create(email_address: 'complainer@yahoo.com', password:  'complainer@yahoo.com', password_confirmation: 'complainer@yahoo.com', name: 'Complainer McPerson')

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.586837,
      longitude: 121.061007,
      category: 'pothole',
      title: 'Ruby Road Pothole',
      description: 'Big ass pothole',
      image: File.new('./db/pics/pothole.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.585186,
      longitude: 121.059967,
      category: 'pothole',
      title: 'ADB Avenue Pothole',
      description: 'My bike always falls here',
      image: File.new('./db/pics/pothole2.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.588976,
      longitude: 121.061319,
      category: 'pothole',
      title: 'Garnet Pothole',
      description: 'THIS IS A BIG HAZARD!!!',
      image: File.new('./db/pics/pothole3.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.586007,
      longitude: 121.059817,
      category: 'light',
      title: 'Busted light in front of Podium',
      description: 'What the hell',
      image: File.new('./db/pics/light.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.586007,
      longitude: 121.059817,
      category: 'light',
      title: 'NO LIGHT IN FRONT jjG',
      description: 'What the hell',
      image: File.new('./db/pics/light2.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.585861,
      longitude: 121.063122,
      category: 'light',
      title: 'NO LIGHT IN FRONT jjG',
      description: 'What the hell',
      image: File.new('./db/pics/light3.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.589091,
      longitude: 121.058015,
      category: 'garbage',
      title: 'Di na makatao tong basurang to',
      description: 'I hate the government',
      image: File.new('./db/pics/garbage.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.582975,
      longitude: 121.061909,
      category: 'garbage',
      title: 'Garbage literally in front of the Stock Exchange',
      description: 'This is insane',
      image: File.new('./db/pics/garbage2.jpg')
    )

    Complaint.create(
      user_id: complainer.id,
      latitude: 14.585809,
      longitude: 121.058755,
      category: 'garbage',
      title: 'Trash on the rooftop',
      description: 'How did it get here',
      image: File.new('./db/pics/garbage3.jpg')
    )
  end
end

# For rake db:seed
SeedEverything.go
