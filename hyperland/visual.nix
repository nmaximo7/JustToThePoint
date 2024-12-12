{ }:

''
# General Settings
general {
        gaps_in = 6 # These settings control the spacing between windows. gaps_in defines the space within the workspace, while gaps_out sets the space around the workspace.
        gaps_out = 8 # This specifies the thickness of the window borders.
        border_size = 2
        layout = dwindle # The dwindle layout is a dynamic tiling layout that allows windows to resize and move based on their current state.
        resize_on_border = true)$ # It allows you to resize windows by dragging their borders, which can enhance usability.
        }
        
# Input Settings        
input {
  	kb_layout = es, us #  This defines the keyboard layouts in use. Here, both Spanish (es) and U.S. English (us) layouts are configured, allowing for quick switching.
    	kb_options = "grp:alt_shift_toggle,caps:super" # The options specify how to toggle keyboard layouts (alt_shift_toggle) and set the Caps Lock key to act as a Super key
    	sensitivity = 0.0 # Setting the sensitivity to 0.0 might indicate that you want to disable any pressure sensitivity for input devices, such as touchpads or styluses.
    	accel_profile = "flat" # This setting indicates a linear acceleration profile for mouse movement, providing consistent pointer speed, which can be beneficial for precision tasks.
      }
      
      
# Misc settings
misc {
        initial_workspace_tracking = 0 # This controls the initial tracking of the workspace. A value of 0 may mean no initial tracking is set, allowing for a fresh start.
        mouse_move_enables_dpms = true # Setting this to true means that moving the mouse will enable Display Power Management Signaling (DPMS), which can help save energy when the display is not in use.
        key_press_enables_dpms = false # This setting disables DPMS activation on key presses, which can prevent the screen from waking unnecessarily when typing.
      }

''
