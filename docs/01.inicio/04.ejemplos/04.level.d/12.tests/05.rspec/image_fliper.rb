class ImageFlipper
  def initialize(image_processor)
    @image_processor = image_processor
  end

  def flip(file_name)
   @image_processor.flip(file_name)
 end
end
