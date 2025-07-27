# config/initializers/field_with_errors.rb

# Este código customiza o comportamento do Rails para campos de formulário com erros,
# tornando-o compatível com o framework Semantic UI.
#
# Em vez de envolver o campo em uma <div class="field_with_errors">,
# ele adiciona a classe 'error' à div pai com a classe 'field'.
# Isso ativa a estilização de erro nativa do Semantic UI sem quebrar o layout.

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  # Transforma a string de tag HTML em um objeto Nokogiri para fácil manipulação
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input, textarea, select')

  if field
    # Adiciona a classe 'error' ao elemento pai que contém a classe 'field'.
    # É assim que o Semantic UI espera que os erros sejam sinalizados.
    error_class = 'error'
    
    # CORREÇÃO: Usamos .ancestors('.field').first para encontrar o primeiro ancestral com a classe 'field'
    field_parent = field.ancestors('.field').first

    if field_parent
      field_parent.add_class(error_class)

      # Constrói a mensagem de erro para ser exibida
      error_message = instance.error_message
      if error_message.is_a?(Array)
        error_message = error_message.to_sentence
      end
      
      # Adiciona a mensagem de erro logo após o campo, dentro de uma div de erro do Semantic UI.
      # Isso garante que a mensagem de erro também seja estilizada corretamente.
      error_html = <<~HTML
        <div class="ui basic red pointing prompt label transition visible">
          #{error_message}
        </div>
      HTML
      
      # Insere a mensagem de erro após o container do input (ex: div.ui.input)
      field.parent.add_next_sibling(error_html)
    end
  end
  
  # Retorna o HTML modificado
  fragment.to_html.html_safe
end