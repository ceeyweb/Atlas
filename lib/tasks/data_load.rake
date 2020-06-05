namespace :data do
  namespace :load do
    desc "Load all data from csv files"
    task :all => %w[mobility_percentages upward_mobility_indicators]

    desc "Load 'Mobility Percentages' table"
    task mobility_percentages: :environment do
      print "Loading `kpis_mobility_percentages`..."
      MobilityPercentagesLoader.load
      puts " complete!"
    end

    desc "Load 'Upward Mobility Indicators' table"
    task upward_mobility_indicators: :environment do
      print "Loading `upward_mobility_indicators`..."
      UpwardMobilityLoader.load
      puts " complete!"
    end
  end
end
