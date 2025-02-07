class ApplicationController < ActionController::API
  def reseed
    return head :forbidden unless Rails.env.development?

    # Drop and recreate the database, then load schema and seeds
    Rails.application.load_tasks
    Rake::Task["db:drop"].execute
    Rake::Task["db:create"].execute
    Rake::Task["db:schema:load"].execute
    Rake::Task["db:seed"].execute

    # Reset Rake tasks to ensure they can be run again if needed
    Rake::Task.tasks.each(&:reenable)

    render json: { message: "Database reset and reseeded successfully" }
  end
end
