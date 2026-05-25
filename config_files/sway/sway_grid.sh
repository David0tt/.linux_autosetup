#!/bin/bash
##############################################################################################
# A script to arrange windows in a grid layout in sway
# Note, that the windows can arbitrarily reordered when running this
##############################################################################################

set -euo pipefail


SWAYMSG=${SWAYMSG:-swaymsg}

WORKSPACE=$($SWAYMSG -t get_workspaces | jq -r '.[] | select(.focused == true).name')

# # Get list of window IDs
# readarray -t WINDOWS < <($SWAYMSG -t get_tree | jq -r \
#   '.. | select(.type? == "workspace" and .name == "'"$WORKSPACE"'") | recurse(.nodes[]) | select(.type? == "con" and .window != null) | .id')


# # Get list of window IDs from the current workspace
# readarray -t WINDOWS < <($SWAYMSG -t get_tree | jq -r \
#   --arg workspace "$WORKSPACE" \
#   '.. | select(.type? == "workspace" and .name == $workspace) | 
#    .. | select(.type? == "con" and .window? != null) | .id')


readarray -t WINDOWS < <($SWAYMSG -t get_tree | jq -r \
  --arg workspace "$WORKSPACE" \
    '..
     | select(.type? == "workspace" and .name == $workspace)
     | (.nodes + .floating_nodes)
     | ..
     | select(.pid? != null or .window? != null)
     | .id')


NUM_WINDOWS=${#WINDOWS[@]}

# # Main execution
# if [ $NUM_WINDOWS -eq 0 ]; then
#     # echo "No windows found in current workspace"
#     exit 1
# fi

# Calculate grid size
NUM_COLS=$(echo "scale=10; sqrt($NUM_WINDOWS)" | bc)
NUM_COLS=$(echo "($NUM_COLS+0.999999999)/1" | bc)

NUM_ROWS=$(echo "scale=10; $NUM_WINDOWS / $NUM_COLS" | bc)
NUM_ROWS=$(echo "($NUM_ROWS+0.999999999)/1" | bc)



# Function to arrange windows in a grid layout
#     1. First Column Creation: Takes the first num_rows windows and places them vertically (each below the previous one)
#     2. Horizontal Placement: For each row, starting from the first column window, places additional windows to the right until the row is full or we run out of windows
#     3. Grid Completion: Continues this process for all rows until all windows are placed

arrange_windows_grid() {
    local num_windows=$1
    local num_cols=$2
    local num_rows=$3

    if [ $num_windows -eq 0 ]; then
        # echo "No windows to arrange"
        return
    fi
    
    # echo "Arranging $num_windows windows in ${num_rows}x${num_cols} grid"
    
    # echo "Building first column with $num_rows windows"
    

    # Mark the target window (first window -> top-left corner)
    $SWAYMSG "[con_id=${WINDOWS[0]}] mark --add target"
    # Split the target vertically (for "below")
    $SWAYMSG "[con_id=${WINDOWS[0]}] focus; split v"

    # Place windows vertically in the first column by adding them to the target container
    for (( i=1; i<num_rows; i++ )); do
        # echo "Placing window ${WINDOWS[$i]}"

        # Move the window into the marked container
        $SWAYMSG "[con_id=${WINDOWS[$i]}] move to mark target"
        # Make the new window in the column the new target (to always append at the bottom)
        $SWAYMSG "[con_id=${WINDOWS[$i]}] mark --replace target"

    done

    # Now place remaining windows horizontally
    local remaining_windows=$((num_windows - num_rows))
    local current_window_idx=$num_rows
    
    # echo "Placing $remaining_windows remaining windows horizontally"
    
    # For each row
    for (( row=0; row<num_rows && current_window_idx<num_windows; row++ )); do
        local row_start_window=${WINDOWS[$row]}
        local windows_in_this_row=1  # We already have the first column window
        
        # select this row's container as target:
        # Mark the target window
        $SWAYMSG "[con_id=$row_start_window] mark --replace target"
        # Split the target horizontally (for "right")
        $SWAYMSG "[con_id=$row_start_window] focus; split h"


        # Place windows to the right in this row
        while [ $windows_in_this_row -lt $num_cols ] && [ $current_window_idx -lt $num_windows ]; do
            # Place the window into the marked container
            # Move the second window into the marked container
            $SWAYMSG "[con_id=${WINDOWS[$current_window_idx]}] move to mark target"
            # Make the new window in the row the new target (to always append at the right)
            $SWAYMSG "[con_id=${WINDOWS[$current_window_idx]}] mark --replace target"

            current_window_idx=$((current_window_idx + 1))
            windows_in_this_row=$((windows_in_this_row + 1))
        done
    done
}

# echo "Found $NUM_WINDOWS windows in workspace $WORKSPACE"
# echo "Arranging in grid with $NUM_COLS columns and $NUM_ROWS rows"

arrange_windows_grid $NUM_WINDOWS $NUM_COLS $NUM_ROWS
