class ITunesOSAWrapper

  def sources
    app_reference.sources.select {|s|
      [OSA::ITunes::ESRC::LIBRARY, OSA::ITunes::ESRC::SHARED_LIBRARY].include? s.kind
    }
  rescue
    puts "Couldn't connect to iTunes."
    exit 1
  end

  def player_state
    case app_reference.player_state
    when OSA::ITunes::EPLS::STOPPED; :stopped
    when OSA::ITunes::EPLS::PLAYING; :playing
    when OSA::ITunes::EPLS::PAUSED;  :paused
    end
  end

  def stopped?; :stopped == player_state end
  def playing?; :playing == player_state end
  def paused?;  :paused  == player_state end

  private

  def app_reference
    OSA.utf8_strings = true
    @app_reference ||= OSA.app('iTunes')
  end

end