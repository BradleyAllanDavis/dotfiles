{
  # Dock
  system.defaults = {
    dock = {
      autohide = true;                                    # Automatically hide and show the Dock
      orientation = "bottom";                             # Dock position (left, bottom, right)
      mouse-over-hilite-stack = true;                     # Enable highlight hover effect for the grid view of a stack (Dock)
      # tilesize = 80;                                    # Set the icon size of Dock items
      # largesize = 85;                                   # Set dock tile large size"
      mineffect = "scale";                                # Change minimize/maximize window effect
      minimize-to-application = true;                     # Minimize windows into their application’s icon
      enable-spring-load-actions-on-all-items = true;     # Enable spring loading for all Dock items
      launchanim = true;                                  # Don’t animate opening applications from the Dock
      autohide-delay = 0.0;                               # Remove the auto-hiding Dock delay"
      autohide-time-modifier = 0.1;                       # Remove the animation when hiding/showing the Dock
      showhidden = true;                                  # Make Dock icons of hidden applications translucent
      # Hot Corners
      # Possible values:
      #  0: no-op
      #  2: Mission Control
      #  3: Show application windows
      #  4: Desktop
      #  5: Start screen saver
      #  6: Disable screen saver
      #  7: Dashboard
      # 10: Put display to sleep
      # 11: Launchpad
      # 12: Notification Center
      wvous-tl-corner = 5;                                # Hot corner: Top left - Start screensaver
      wvous-tr-corner = 2;                                # Hot corner: Top right - Mission control
      wvous-bl-corner = 4;                                # Hot corner: Bottom left - Show desktop
      wvous-br-corner = null;
    };
  };














}
