class ConfidentialHerpesReport
  
  # ---------------------------------------------------------------------------
  # Setup state info to hydrate the map
  def self.us_propagation
    data = {}
    us_states.each_pair do |id, name|
      value    = rand(99)
      data[id] = { 
        :name   => name, 
        :hover  => "Herpes cases [#{value}]", 
        :url    => "javascript:window.alert( \"Hoy! You have clicked on #{name}\");",
        :data   => value 
      }
    end
    data
  end
  
  # ===========================================================================
  private

    # Probably would come for your db somewhere...
    def self.us_states  
      @us_states ||= { 
        :AL => 'Alabama',
        :AK => 'Alaska',
        :AZ => 'Arizona',
        :AR => 'Arkansas',
        :CA => 'California',
        :CO => 'Colorado',
        :CT => 'Connecticut', 
        :DE => 'Delaware',
        :DC => 'District Of Columnbia',
        :FL => 'Florida',
        :GA => 'Georgia',
        :HI => 'Hawaii',
        :ID => 'Idaho',
        :IL => 'Illinois',
        :IN => 'Indiana',
        :IA => 'Iowa',
        :KS => 'Kansas',
        :KY => 'Kentucky',
        :LA => 'Louisiana',
        :ME => 'Maine',
        :MD => 'Maryland',
        :MA => 'Massachusetts',
        :MI => 'Michigan',
        :MN => 'Minnesota',
        :MS => 'Mississippi',
        :MO => 'Missouri',
        :MT => 'Montana',
        :NE => 'Nebraska',
        :NV => 'Nevada',
        :NH => 'New Hampshire',
        :NJ => 'New Jersey',
        :NM => 'New Mexico',
        :NY => 'New York',
        :NC => 'North Carolina',
        :ND => 'North Dakota',
        :OH => 'Ohio',
        :OK => 'Oklahoma',
        :OR => 'Oregon',
        :PA => 'Pennsylvania',
        :RI => 'Rhode Island',
        :SC => 'South Carolina',
        :SD => 'South Dakota',
        :TN => 'Tennessee',
        :TX => 'Texas',
        :UT => 'Utah',
        :VT => 'Vermont',
        :VA => 'Virgina',
        :WA => 'Washington',
        :WV => 'West Virginia',
        :WI => 'Wisconsin',
        :WY => 'Wyoming'
      }
    end  
end