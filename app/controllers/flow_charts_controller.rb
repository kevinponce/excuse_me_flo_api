# frozen_string_literal: true

# flow_charts_controller.rb
class FlowChartsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_flow_chart, only: %i[show update destroy]

  def index
    render json: Builders::Json::FlowCharts.new(current_user.flow_charts).build
  end

  def create
    flow_chart = current_user.flow_charts.new(flow_chart_params)
    if flow_chart.save
      render json: Builders::Json::FlowChart.new(flow_chart).build
    else
      render json: Builders::Json::Errors.new(flow_chart).build, status: 500
    end
  end

  def show
    render json: Builders::Json::FlowChart.new(@flow_chart).build
  end

  def update
    if @flow_chart.update_attributes(flow_chart_params)
      render json: Builders::Json::FlowChart.new(@flow_chart).build
    else
      render json: Builders::Json::Errors.new(@flow_chart).build, status: 500
    end
  end

  def destroy
    if @flow_chart.delete
      current_user.flow_charts.reload
      render json: Builders::Json::FlowCharts.new(current_user.flow_charts).build
    else
      render json: Builders::Json::Errors.new(@flow_chart).build, status: 400
    end
  end

  private

  def flow_chart_params
    params.required(:flow_chart).permit(:title, :markup)
  end

  def fetch_flow_chart
    @flow_chart = current_user.flow_charts.find_by(id: params[:id])
    render json: Builders::Json::NotFound.new('Flow chart').build, status: 500 unless @flow_chart
  end
end
