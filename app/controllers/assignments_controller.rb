class AssignmentsController < ApplicationController
  include Devise::Controllers::Helpers
  before_action :authenticate_user!, only: [:index, :new, :upload, :show, :destroy]

  def index
    @assignments = Assignment.all
  end

  def show
    @assignment = Assignment.find(params[:id]) # Ensure you're getting the correct assignment
    if current_user.admin?
      # Admin can view file upload details (and download it if needed)
      @uploaded_file = @assignment.uploads.first # Assuming only one file per assignment per user
    else
      # Non-admin users can't view the file, but we can show them if they've uploaded one
      @upload = @assignment.uploads.find_by(user: current_user)
    end
  end


  def new
    @assignment = current_user.assignments.build
  end

  def create
    @assignment = current_user.assignments.build(assignment_params)
    if @assignment.save
      redirect_to assignments_path, notice: "Assignment created successfully!"
    else
      render :new
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_path, notice: "Assignment was successfully deleted."
  end

  # POST method for uploading a file for an assignment
  def upload
    @assignment = Assignment.find(params[:id])

    if current_user.student? && @assignment.uploads.where(user: current_user).empty?
      # Ensure that the student can upload only one file per assignment
      if params[:upload][:file].present?
        @upload = @assignment.uploads.new(user: current_user, file: params[:upload][:file])
        if @upload.save
          redirect_to @assignment, notice: "File uploaded successfully!"
        else
          redirect_to @assignment, alert: "Failed to upload file."
        end
      else
        redirect_to @assignment, alert: "Please choose a file to upload."
      end
    else
      redirect_to @assignment, alert: "You can only upload one file per assignment."
    end
  end

  private

  def set_assignment
    @assignment = Assignment.find_by(id: params[:id])
    if @assignment.nil?
      redirect_to assignments_path, alert: "Assignment not found."
    end
  end

  def assignment_params
    params.require(:assignment).permit(:title, :description, :due_date)
  end
end
