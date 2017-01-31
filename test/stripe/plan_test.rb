require File.expand_path('../../test_helper', __FILE__)

module Stripe
  class PlanTest < Test::Unit::TestCase
    FIXTURE = API_FIXTURES.fetch(:plan)

    should "be listable" do
      plans = Stripe::Plan.list
      assert_requested :get, "#{Stripe.api_base}/v1/plans"
      assert plans.data.kind_of?(Array)
      assert plans.data[0].kind_of?(Stripe::Plan)
    end

    should "be retrievable" do
      plan = Stripe::Plan.retrieve(FIXTURE[:id])
      assert_requested :get, "#{Stripe.api_base}/v1/plans/#{FIXTURE[:id]}"
      assert plan.kind_of?(Stripe::Plan)
    end

    should "be creatable" do
      _ = Stripe::Plan.create(:metadata => {})
      assert_requested :post, "#{Stripe.api_base}/v1/plans"
    end

    should "be saveable" do
      plan = Stripe::Plan.retrieve(FIXTURE[:id])
      plan.metadata['key'] = 'value'
      plan.save
      assert_requested :post, "#{Stripe.api_base}/v1/plans/#{FIXTURE[:id]}"
    end

    should "be updateable" do
      _ = Stripe::Plan.update(FIXTURE[:id], metadata: {foo: 'bar'})
      assert_requested :post, "#{Stripe.api_base}/v1/plans/#{FIXTURE[:id]}"
    end

    should "be deletable" do
      plan = Stripe::Plan.retrieve(FIXTURE[:id])
      plan.delete
      assert_requested :delete, "#{Stripe.api_base}/v1/plans/#{FIXTURE[:id]}"
    end
  end
end
