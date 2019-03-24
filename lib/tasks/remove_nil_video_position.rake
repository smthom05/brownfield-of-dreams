namespace :remove_nil_video_position do
  task update_video_position: :environment do
    Video.where(position: nil).update_all(position: 0)
    puts 'Videos with nil position have been updated to 0'
  end
end
