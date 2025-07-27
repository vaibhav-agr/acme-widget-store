class Offer
  def apply(items)
    raise NotImplementedError, "#{self.class} must implement apply method"
  end
end
