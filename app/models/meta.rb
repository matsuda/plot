class Meta < Hash
  def initialize(meta = {})
    meta.each do |key, value|
      self.update(key.to_s => value)
    end
  end

  private
  def method_missing(method_id, *args, &block)
    if self[method_id.to_s].present?
      self[method_id.to_s]
    else
      super
    end
  end
end
