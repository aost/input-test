class InputTest < Game
  PENDING = C['#555']
  PASS = C['#ffa']

  def setup
    display.text_font = Font['open-sans.ttf']
    display.text_size = 16

    @keys_pressed = Hash[Keyboard::KEYS.map { |k| [k, false] }]
    @buttons_pressed = Hash[Mouse::BUTTONS.map { |k| [k, false] }]
  end

  def update(elapsed)
    display.fill_color = C['#4a6']
    display.clear

    @keys_pressed.each_with_index do |value, i|
      key, pressed = value

      @keys_pressed[key] = pressed = true if keyboard.pressing? key

      display.fill_color = pressed ? PASS : PENDING
      x = (i * 32 / (display.height - 32)).floor * 108 + 32
      y = (i * 32) % (display.height - 32) + 32
      display.fill_text(key, V[x, y])
    end

    @buttons_pressed.each_with_index do |value, i|
      button, pressed = value

      @buttons_pressed[button] = pressed = true if mouse.pressing? button

      display.fill_color = pressed ? PASS : PENDING
      x = display.width * 0.7
      y = (i * 32) % (display.height - 32) + 96
      display.fill_text("mouse #{button}", V[x, y])
    end

    @mouse_moved = true if @last_mouse_pos && @last_mouse_pos != mouse.position

    display.fill_color = @mouse_moved ? PASS : PENDING
    display.fill_text("(#{mouse.x}, #{mouse.y})",
                      V[display.width * 0.7, display.height * 0.5])

    @last_mouse_pos = mouse.position
  end
end
