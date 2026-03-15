# Un stub es solo un método con una respuesta enlatada,
# no le importa el comportamiento.

RSpec.describe "Stub example" do
  it "calls the stub method" do
    stub = double("json")
    allow(stub).to receive(:response) do
      {"blog"=>"rubyguides.com", "rating"=>"5/5"}.to_json
    end
  end
end

# El método allow es lo que el stub.
# Permitimos que nuestro objeto de prueba double("json")
# reciba y responda a este método,
# pero no verificamos si se está llamando.
