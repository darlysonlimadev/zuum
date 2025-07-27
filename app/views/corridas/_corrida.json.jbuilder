json.extract! corrida, :id, :usuario_id, :endereco_partida, :endereco_destino, :valor_estimado, :created_at, :updated_at
json.url corrida_url(corrida, format: :json)
