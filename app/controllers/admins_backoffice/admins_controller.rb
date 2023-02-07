class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :password_verify, only: %i[update]
  before_action :set_admin, only: %i[edit update]

  def index
    @admins = Admin.all
  end

  def edit; end

  def update
    if @admin.update(admin_params)
      redirect_to admins_backoffice_admins_path, notice: 'Administrador alterado com sucesso'
    else
      render :edit
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def password_verify
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end
end
