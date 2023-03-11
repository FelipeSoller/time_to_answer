class UsersBackoffice::ProfileController < UsersBackofficeController
  before_action :password_verify, only: %i[update]
  before_action :set_user

  def edit
    @user.build_user_profile if @user.user_profile.blank?
  end

  def update
    if @user.update(params_user)
      bypass_sign_in(@user)
      redirect_to users_backoffice_profile_path, notice: 'Usuário alterado com sucesso'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def params_user
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, user_profile_attributes: [:id, :address, :gender, :birth_date])
  end

  def password_verify
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end
