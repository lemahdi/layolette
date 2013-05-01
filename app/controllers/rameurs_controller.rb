class RameursController < ApplicationController
  before_action :set_rameur,       only: [:show, :edit, :update, :destroy]
  
  before_filter :signed_in_rameur, only: [:index, :edit, :update]
  before_filter :correct_rameur,   only: [:edit, :update]

  # GET /rameurs
  # GET /rameurs.json
  def index
    @rameurs = Rameur.all
  end

  # GET /rameurs/1
  # GET /rameurs/1.json
  def show
  end

  # GET /rameurs/new
  def new
    @rameur = Rameur.new
  end

  # GET /rameurs/1/edit
  def edit
    set_rameur
  end

  # POST /rameurs
  # POST /rameurs.json
  def create
    @rameur = Rameur.new(rameur_params)

    respond_to do |format|
      if @rameur.save
        sign_in @rameur
        format.html { redirect_to @rameur, notice: 'Vous êtes membre, félicitations!' }
        format.json { render action: 'show', status: :created, location: @rameur }
      else
        format.html { render action: 'new' }
        format.json { render json: @rameur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rameurs/1
  # PATCH/PUT /rameurs/1.json
  def update
    respond_to do |format|
      if @rameur.update(rameur_params)
        sign_in @rameur
        format.html { redirect_to @rameur, notice: 'Profil mis à jour avec succès' }
        format.json { render action: 'show', status: :updated, location: @rameur }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rameur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rameurs/1
  # DELETE /rameurs/1.json
  def destroy
    @rameur.destroy
    respond_to do |format|
      format.html { redirect_to rameurs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rameur
      @rameur = Rameur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rameur_params
      params.require(:rameur).permit(:nom, :prenom, :email, :password, :password_confirmation)
    end

    def signed_in_rameur
      unless signed_in?
        store_location
        respond_to do |format|
          format.html { redirect_to signin_url, notice: 'Merci de bien vouloir vous identifier' }
          format.json { render 'index', status: :unauthorized }
        end
      end
    end

    def correct_rameur
      set_rameur
      unless current_rameur?(@rameur)
        respond_to do |format|
          format.html { redirect_to root_url }
          format.json { render 'index', status: :unauthorized }
        end
      end
    end
end
