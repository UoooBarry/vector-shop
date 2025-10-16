class ServiceAsyncWrapper < ApplicationJob
  def perform(service_class, *args)
    if service_class.respond_to?(:call)
      service_class.call(*args)
    else
      Rails.logger.error("[ServiceAsyncWrapperJob] #{service_class_name} does not implement .call")
    end
  end
end
