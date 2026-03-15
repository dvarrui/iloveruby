# Un mock espera que se llame a los métodos,
# si no se llaman, la prueba fallará.

require_relative "image_fliper"

RSpec.describe "ImageFlipper" do
  it "calls the flip method with the correct arguments" do
    mock = double("mini_magick")
    expect(mock).to receive(:flip).with("ruby.jpg")
    img = ImageFlipper.new(mock)
    img.flip("ruby.jpg")
  end
end
