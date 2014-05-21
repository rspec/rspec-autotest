describe "autotest/discover.rb" do
  it "adds 'rspec' to the list of discoveries" do
    expect(Autotest).to receive(:add_discovery)
    load File.expand_path("../../../lib/autotest/discover.rb", __FILE__)
  end
end
