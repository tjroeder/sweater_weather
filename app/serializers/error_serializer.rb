class ErrorSerializer
  def self.serialize(errors, status, source)
    return if errors.nil?

    json = {}
    new_hash = errors.to_hash.map do |type, messages|
      messages.map do |msg|
        { 
          status: status,
          source: { pointer: source },
          id: type, 
          title: "#{type.to_s.humanize} #{msg.to_s}"
        }
      end
    end.flatten
    json[:errors] = new_hash
    json
  end
end