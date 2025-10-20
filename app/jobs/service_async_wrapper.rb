class ServiceAsyncWrapper < ApplicationJob
  def perform(service_class, *args, &block)
    if service_class.respond_to?(:call)
      service_class.call(*args, &block)
    else
      Rails.logger.error("[ServiceAsyncWrapperJob] #{service_class} does not implement .call")
    end
  end
end
