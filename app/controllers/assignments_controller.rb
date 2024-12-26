class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assignment, only: [ :show, :destroy ]

  def index
    @assignments = Assignment.all
  end

  def show
    if current_user.admin?
      @uploaded_file = @assignment.mpeg_file.attached?
    else
      @uploaded_file = nil # Non-admin users can't view the file
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

  def upload
    @assignment = current_user.assignments.find(params[:id])

    if params[:assignment][:mpeg_file].present?
      @assignment.mpeg_file.attach(params[:assignment][:mpeg_file])
      redirect_to @assignment, notice: "File uploaded successfully!"
    else
      redirect_to @assignment, alert: "Please choose a file to upload."
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
