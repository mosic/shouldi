defmodule ContextMatcherTest do
  use ShouldI
  import ShouldI.Matchers.Context

  setup context do
    assign context,
      one: 1,
      tuple: {:ok, :works},
      tuple_one: {:ok, 2}
  end

  should_assign_key one: 1
  should_have_key :one
  should_not_have_key :two
  should_match_key tuple: {:ok, _}
  should_match_key tuple_one: {:ok, ^(context[:one] + context[:one])}

  with "another level" do
    setup context do
      assign context,
        two: 2
    end

    should_assign_key two: 2
    should_assign_key one: 1
    should_have_key :one
  end

  with "an overwritten key" do
    setup context do
      assign context,
        one: "one"
    end

    should_assign_key one: "one"
  end


end
