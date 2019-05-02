namespace :bino do
  desc "Initializes Bino service"

  task :init, [:source, :destiny, :source_type, :destiny_type, :object_id] => [:environment] do |task, args|
    Rails.logger.info "Lets wake up Bino!"
    BinoService.new(
      args[:source],
      args[:destiny],
      args[:source_type],
      args[:destiny_type],
      args[:object_id],
    ).transport
  end
end
