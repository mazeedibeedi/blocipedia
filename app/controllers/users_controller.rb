class UsersController < ApplicationController
  def downgrade
    current_user.standard!
    current_user.wikis.update_all(private: false)
    redirect_to root_path, notice: "You were successfully downgraded"
  end
end
