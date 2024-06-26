require 'rails_helper'

RSpec.describe Scientist do
  describe "relationships" do
    it {should belong_to :lab}
    it {should have_many :scientist_experiments}
    it {should have_many :experiments}
  end

  before(:each) do
    @lab1 = Lab.create!(name: "Fusion Lab")
    @lab2 = Lab.create!(name: "Fission Lab")
    @scientist1 = @lab1.scientists.create!(name: "Dr. Atom", specialty: "Atoms", university: "Atom University")
    @scientist2 = @lab1.scientists.create!(name: "Dr. Neutron", specialty: "Neutrons", university: "Neutron University")
    @scientist3 = @lab1.scientists.create!(name: "Dr. Neutrino", specialty: "Neutrinos", university: "Neutrino University")
    @scientist4 = @lab2.scientists.create!(name: "Dr. No", specialty: "Nil Values", university: "Nil University")
    @experiment1 = Experiment.create!(name: "Splitting the Atom", objective: "Split the atom", num_months: 12)
    @experiment2 = Experiment.create!(name: "Putting the Atom Back Together", objective: "Put the atom back together", num_months: 24)
    @experiment3 = Experiment.create!(name: "What is Life?", objective: "Discover the meaning of life", num_months: 100)
    @experiment1.scientists << @scientist1
    @experiment1.scientists << @scientist2
    @experiment1.scientists << @scientist3
    @experiment2.scientists << @scientist1
    @experiment2.scientists << @scientist3
    @experiment3.scientists << @scientist1
  end

  describe "instance methods" do
    describe ".experiments_count" do
      it "counts the number of experiments a scientist is on" do
        expect(@scientist1.experiments_count).to eq 3
        expect(@scientist2.experiments_count).to eq 1
        expect(@scientist3.experiments_count).to eq 2
      end
    end

    describe ".order_by_experiments" do
      it "orders scientists by experiment count (most to least)" do
        expected = [@scientist1, @scientist3, @scientist2]
        expect(Scientist.order_by_experiments).to eq(expected)
      end
    end
  end
end