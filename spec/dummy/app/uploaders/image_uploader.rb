require 'image_processing/vips'

class ImageUploader < Shrine
  DERIVATIVE_SIZES = {
    jpg_small: { size: [100, 100], type: 'jpg' }
  }

  Attacher.derivatives do |original|
    vips = ImageProcessing::Vips.source(original)

    DERIVATIVE_SIZES.reduce({}) do |derivatives_hash, (name, derivative_info)|
      derivatives_hash[name] = vips.convert(derivative_info[:type]).resize_to_limit!(
        *derivative_info[:size]
      )
      derivatives_hash
    end
  end
end
