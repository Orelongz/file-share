class DocumentsController < ApplicationController
  before_action :set_document, only: :destroy

  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    if document_params[:files].present? && @document.save
      flash[:success] = 'File successfully saved'
      redirect_to documents_path
    else
      flash[:danger] = 'Error occured while performing action. Please try again'
      render 'new'
    end
  end

  def destroy
    if @document.files.length == 1
      @document.destroy      
    else
      selected_file = @document.files.find{ |file| file.id.to_s == params[:file_id] }
      selected_file.purge
    end

    if @document.destroyed? || selected_file.destroyed?
      flash[:success] = 'File deleted successfully'
    else
      flash[:danger] = 'Error occured while performing action. Please try again'
    end

    redirect_to root_path
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:description, files: [])
    end
end
