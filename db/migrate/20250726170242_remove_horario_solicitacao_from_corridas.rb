class RemoveHorarioSolicitacaoFromCorridas < ActiveRecord::Migration[8.0]
  def change
    remove_column :corridas, :horario_solicitacao, :datetime
  end
end
