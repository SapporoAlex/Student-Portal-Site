class UploadsController < ApplicationController
  before_action :set_assignment, only: [:new, :create]
  before_action :authenticate_user!
  before_action :authorize_admin, only: :index

  # GET /assignments/:assignment_id/uploads/new
  def new
    @upload = @assignment.uploads.new
  end

  # POST /assignments/:assignment_id/uploads
  def create
    @upload = @assignment.uploads.new(upload_params)
    @upload.user = current_user

    if @upload.save
      redirect_to assignment_path(@assignment), notice: "File uploaded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /uploads
  def index
    @uploads = Upload.includes(:user, :assignment).all
  end

  private

  def set_assignment
    @assignment = Assignment.find(params[:assignment_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to assignments_path, alert: "Assignment not found."
  end
  

  def upload_params
    params.require(:upload).permit(:file)
  end

  def authorize_admin
    redirect_to root_path, alert: "Not authorized" unless current_user.admin?
  end
end
