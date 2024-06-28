# app/controllers/metrics_controller.rb
class MetricsController < ApplicationController
    def index
      metrics = Prometheus::Client.registry.metrics.map do |metric|
        metric_values = metric.values
        metric_values.map do |labels, value|
          label_str = labels.map { |k, v| "#{k}=\"#{v}\"" }.join(',')
          "#{metric.name}{#{label_str}} #{value}\n"
        end.join("\n")
      end.join("\n")

      render plain: metrics
    end
  end
