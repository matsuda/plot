class ArchivesController < ApplicationController
  def index
    @archives = Archives.archive
  end
end
