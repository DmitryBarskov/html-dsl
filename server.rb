require 'sinatra'

require_relative './html/html.rb'

def current_date_html
  Html::Element.new(:div) do
    time class: ['time', 'blue-text'] do
      text Date.today
    end
  end
end

get '/' do
  document = Html::Document.new do
    html lang: "en" do
      head do
        meta charset: "UTF-8"
        meta "http-equiv": "X-UA", content: "IE=edge"
        meta name: "viewport", content: "width=device-width, initial-scale=1.0"
        title { text "Document" }

        style do
          text <<~CSS
          .green-text {
            color: green;
          }

          .blue-text {
            color: blue;
          }

          .time {
            font-family: monospace;
          }
          CSS
        end
      end

      body do
        article do
          section do
            h1 style: { 'text-decoration': 'underline', color: :red } do
              text "Document example"
            end


            input type: "number", min: 1, max: 5, disabled: false

            ul do
              5.times do |i|
                li class: { 'green-text': i % 2 == 0 } do
                  text i
                end
              end
            end
            p class: "green-text", data: { 'remote-url': 'google.com', id: 2 } do
              text "This is how to use Html::Dsl"
            end

            append_child current_date_html
          end
        end
      end
    end
  end

  document.to_s.tap { |response| puts response }
end
