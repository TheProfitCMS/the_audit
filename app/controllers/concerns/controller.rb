module TheAudit
  module Controller
    extend ActiveSupport::Concern

    included do
      before_action :set_audit, only: [:show, :edit, :update, :destroy]
    end
      
    def index
      #TODO constrain for fast refresh while development
      # @audits = Audit.all
      @audits = Audit.last 20
    end

    def show; end

    def edit; end

    def update
      respond_to do |format|
        if @audit.update(audit_params)
          format.html { redirect_to admin_audit_path(@audit), notice: 'Audit was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @audit.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @audit.destroy
      respond_to do |format|
        format.html { redirect_to admin_audits_url }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit
      @audit = Audit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audit_params
      params.require(:audit).permit(:user_id, :obj_id, :obj_type, :controller_name, :action_name, :ip, :remote_ip, :fullpath, :referer, :user_agent, :remote_addr, :remote_host, :data)
    end
  end
end
