# frozen_string_literal: true

json.topics do
  json.array! @topics do |topic|
    json.name(topic.name)
    json.image(topic.image.filename)
  end
end
