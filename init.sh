#!/bin/bash
# Tank's Great Adventure - Environment Validation Script

echo "=== Tank's Great Adventure - Init Check ==="
echo ""

# Check we're in the right directory
if [ ! -f "project.godot" ]; then
    echo "ERROR: Not in Godot project root. Run from tank-adventure-godot/"
    exit 1
fi
echo "✓ In correct directory"

# Check Godot version
if command -v godot &> /dev/null; then
    GODOT_VERSION=$(godot --version 2>/dev/null | head -1)
    echo "✓ Godot found: $GODOT_VERSION"
else
    echo "⚠ Godot not in PATH (may need to run from GUI)"
fi

# Check key files exist
echo ""
echo "Checking key files..."

FILES=(
    "project.godot"
    "game/popochiu_data.cfg"
    "game/autoloads/game_state.gd"
    "game/characters/tank/character_tank.tscn"
    "game/rooms/brazil_forest/room_brazil_forest.tscn"
    "docs/puzzle_bible.md"
    "docs/gameplay_systems.md"
    "docs/episode_structure.md"
    "feature_list.json"
)

for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✓ $file"
    else
        echo "✗ MISSING: $file"
    fi
done

# Check for orphaned autoload (known issue)
echo ""
echo "Checking for known issues..."
if grep -q "GameManager=" project.godot; then
    if [ ! -f "game/autoloads/game_manager.gd" ]; then
        echo "⚠ ISSUE: GameManager autoload registered but file missing (F001)"
    else
        echo "✓ GameManager file exists"
    fi
fi

# Check GameState autoload registration
if grep -q "GameState=" project.godot; then
    echo "✓ GameState autoload registered"
else
    echo "⚠ GameState autoload NOT registered (F002)"
fi

# Summary of feature status
echo ""
echo "=== Feature Status Summary ==="
if [ -f "feature_list.json" ]; then
    TOTAL=$(grep -c '"id":' feature_list.json)
    PASSING=$(grep -c '"passes": true' feature_list.json)
    echo "Features: $PASSING / $TOTAL passing"

    echo ""
    echo "Next features to implement:"
    # Show first 3 non-passing features
    grep -B2 '"passes": false' feature_list.json | grep '"name"' | head -3 | sed 's/.*"name": "\([^"]*\)".*/  - \1/'
fi

echo ""
echo "=== Init Complete ==="
