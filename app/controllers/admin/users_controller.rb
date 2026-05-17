class Admin::UsersController < Admin::BaseController
  def index
    @users = User.left_joins(:saved_locations)
      .group(:id)
      .select("users.*, COUNT(saved_locations.id) AS saved_count")
      .order(:email_address)
  end

  def update
    user = User.find(params[:id])
    redirect_to admin_users_path, alert: "You can't remove the admin role from yourself" if user == Current.user

    toggled_role = user.user? ? :admin : :user
    user.update!(role: toggled_role)
    redirect_to admin_users_path, notice: "#{user.email_address} is now #{toggled_role}"
  end

  def destroy
    user = User.find(params[:id])
    redirect_to admin_users_path, alert: "You can't delete yourself" if user == Current.user

    user.destroy!
    redirect_to admin_users_path, notice: "Deleted #{user.email_address}"
  end
end
