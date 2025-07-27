module UsuariosHelper
  def formatar_cpf(cpf)
    cpf = cpf.to_s.gsub(/\D/, '')
    return cpf unless cpf.length == 11

    cpf.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end

  def formatar_telefone(telefone)
    telefone = telefone.to_s.gsub(/\D/, '')

    if telefone.length == 10
      telefone.gsub(/(\d{2})(\d{4})(\d{4})/, '(\1) \2-\3')
    elsif telefone.length == 11
      telefone.gsub(/(\d{2})(\d{5})(\d{4})/, '(\1) \2-\3')
    else
      telefone
    end
  end
end
