class CorridasController < ApplicationController
  before_action :set_corrida, only: %i[ show edit update destroy ]

  # GET /corridas or /corridas.json
  def index
    @corridas = Corrida.includes(:usuario).recent
    @usuarios = Usuario.all.order(:nome)
  end

  # GET /corridas/1 or /corridas/1.json
  def show
  end

  # GET /corridas/new
  def new
    @corrida = Corrida.new
    @usuarios = Usuario.all.order(:nome)
  end

  # GET /corridas/1/edit
  def edit
    @usuarios = Usuario.all.order(:nome)
  end

  # POST /corridas or /corridas.json
  def create
    @usuarios = Usuario.all.order(:nome)
    @corrida = Corrida.new(corrida_params)

    respond_to do |format|
      if @corrida.save
        format.html { redirect_to @corrida, notice: "Corrida cadastrada com sucesso." }
        format.json { render :show, status: :created, location: @corrida }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @corrida.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /corridas/1 or /corridas/1.json
  def update
    respond_to do |format|
      if @corrida.update(corrida_params)
        format.html { redirect_to @corrida, notice: "Corrida atualizada com sucesso." }
        format.json { render :show, status: :ok, location: @corrida }
      else
        @usuarios = Usuario.all.order(:nome)
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @corrida.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /corridas/1 or /corridas/1.json
  def destroy
    @corrida.destroy!

    respond_to do |format|
      format.html { redirect_to corridas_path, status: :see_other, notice: "Corrida excluída com sucesso." }
      format.json { head :no_content }
    end
  end

  def filtrar_usuario
    if params[:usuario_id].present?
      @usuario = Usuario.find(params[:usuario_id])
      @corridas = @usuario.corridas.recent
      @usuarios = Usuario.all.order(:nome)
      render :index
    else
      redirect_to corridas_path, alert: 'Selecione um usuário para visualizar suas corridas.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to corridas_path, alert: 'Usuário não encontrado.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_corrida
      @corrida = Corrida.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def corrida_params
      params.require(:corrida).permit(:usuario_id, :endereco_partida, :endereco_destino, :valor_estimado)
    end
end
