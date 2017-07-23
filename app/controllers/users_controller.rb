class UsersController < ApplicationController
  def downgrade
    current_user.standard!
    private_wikis = current_user.wikis.where(private: true)
    private_wikis.each do |wiki|
      wiki.update(private: false)
    end
    redirect_to root_path, notice: "You were successfully downgraded"
  end
end
