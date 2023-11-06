class UpdateAuthorNameJob < ApplicationJob
  queue_as :default

  def perform(author)
    Author.update(name: "Anil")
  end
end
