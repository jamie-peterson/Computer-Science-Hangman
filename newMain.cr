require "crsfml"

scale = 20


center = SF.vector2((40 / 2).to_i, (40 / 2).to_i)
window = SF::RenderWindow.new(
  SF::VideoMode.new(40*scale, 40*scale), "Hangman",
  settings: SF::ContextSettings.new(depth: 24, antialiasing: 8)
)
window.vertical_sync_enabled = true
while window.open?
    while event = window.poll_event()
      if (
        event.is_a?(SF::Event::Closed) ||
        (event.is_a?(SF::Event::KeyPressed) && event.code.escape?)
      )
        window.close()
      end
    end
  
    window.clear SF::Color::Black
  
    window.display()
  end