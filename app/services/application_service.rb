class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def self.async_call(*args, &block)
    ServiceAsyncWrapper.perform_later(self.name.constantize, *args, &block)
  end
end
