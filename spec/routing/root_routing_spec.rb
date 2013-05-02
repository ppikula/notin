require "spec_helper"

describe "root route" do
  it "routes / to the notin#index" do
    get("/").should route_to("notin#index")
  end
end