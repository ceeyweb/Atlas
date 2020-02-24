namespace :data do
  namespace :load do
    desc "Load 'Mobility Percentages' table"
    task mobility_percentages: :environment do
      print "Loading `kpis_mobility_percentages`..."
      MobilityPercentagesLoader.load
      puts " complete!"
    end
  end
end
