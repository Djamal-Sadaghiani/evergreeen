# frozen_string_literal: true

class IncomeStatementsController < ApplicationController
  before_action :set_income_statement, only: %i[show edit update destroy]

  # GET /income_statements
  # GET /income_statements.json
  def index
    @income_statements = IncomeStatement.all
  end

  # GET /income_statements/1
  # GET /income_statements/1.json
  def show; end

  # GET /income_statements/new
  def new
    @income_statement = IncomeStatement.new
  end

  # GET /income_statements/1/edit
  def edit; end

  # POST /income_statements
  # POST /income_statements.json
  def create
    @income_statement = IncomeStatement.new(income_statement_params)

    respond_to do |format|
      if @income_statement.save
        format.html { redirect_to @income_statement, notice: 'Income statement was successfully created.' }
        format.json { render :show, status: :created, location: @income_statement }
      else
        format.html { render :new }
        format.json { render json: @income_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /income_statements/1
  # PATCH/PUT /income_statements/1.json
  def update
    respond_to do |format|
      if @income_statement.update(income_statement_params)
        format.html { redirect_to @income_statement, notice: 'Income statement was successfully updated.' }
        format.json { render :show, status: :ok, location: @income_statement }
      else
        format.html { render :edit }
        format.json { render json: @income_statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /income_statements/1
  # DELETE /income_statements/1.json
  def destroy
    @income_statement.destroy
    respond_to do |format|
      format.html { redirect_to income_statements_url, notice: 'Income statement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_income_statement
    @income_statement = IncomeStatement.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def income_statement_params
    params.require(:income_statement).permit(:period, :date, :total_revenue, :cost_of_revenue, :gross_profit,
                                             :operating_expense, :operating_income, :net_non_operating_interest_income_expense, :other_income_expense, :pretax_income, :tax_provision, :net_income_common_stockholders, :diluted_ni_available_to_com_stockholders, :basic_eps, :diluted_eps, :basic_average_shares, :diluted_average_shares, :total_operating_income_as_reported, :total_expenses, :net_income_from_continuing_and_discontinued_operation, :normalized_income, :interest_income, :interest_expense, :net_interest_income, :ebit, :ebitda, :reconciled_cost_of_revenue, :reconciled_depreciation, :net_income_from_continuing_operation_net_minority_interest, :normalized_ebitda, :tax_rate_for_calcs, :tax_effect_of_unusual_items)
  end
end
