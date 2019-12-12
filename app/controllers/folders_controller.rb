class FoldersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @folders = Folder.tree
  end
end
