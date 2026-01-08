#!/usr/bin/env python3
"""Update room scenes to use the new background images"""

import re
from pathlib import Path

# Room to background mapping
ROOM_BACKGROUNDS = {
    "wanted_camp": "wanted_camp.png",
    "werewolf_chase": "werewolf_chase.png",
    "ditch_hideout": "ditch_hideout.png",
    "morning_miracle": "morning_miracle.png",
    "poison_picnic": "poison_picnic.png",
    "road_monsters": "road_monsters.png",
    "space_drift": "space_drift.png",
    "reentry_fire": "reentry_fire.png",
    "pig_deer_crossing": "pig_deer_crossing.png",
    "oak_tree_camp": "oak_tree_camp.png",
    "brazil_edge_beach": "brazil_edge_beach.png",
    "caribbean_raft": "caribbean_raft.png",
    "puerto_rico": "puerto_rico.png",
    "florida_airport": "florida_airport.png",
    "luggage_room": "luggage_room.png",
    "plane_hold": "plane_hold.png",
    "brazil_forest": "brazil_forest.png",
}

def update_room_scene(scene_path: Path, bg_filename: str):
    """Update a room's .tscn file to use the correct background"""

    content = scene_path.read_text()

    # Check if scene already has a background reference
    bg_pattern = r'\[ext_resource type="Texture2D" path="res://assets/images/backgrounds/[^"]+\.png" id="(\d+_background)"\]'

    # Find existing background ext_resource
    match = re.search(bg_pattern, content)

    if match:
        # Update existing background reference
        old_line = match.group(0)
        new_line = f'[ext_resource type="Texture2D" path="res://assets/images/backgrounds/{bg_filename}" id="{match.group(1)}"]'
        content = content.replace(old_line, new_line)
        print(f"  Updated existing background in {scene_path.name}")
    else:
        # Need to add background - find load_steps and increment
        load_steps_match = re.search(r'\[gd_scene load_steps=(\d+)', content)
        if load_steps_match:
            old_steps = int(load_steps_match.group(1))
            new_steps = old_steps + 1
            content = content.replace(f'load_steps={old_steps}', f'load_steps={new_steps}')

            # Find the last ext_resource to add after it
            ext_resources = list(re.finditer(r'\[ext_resource[^\]]+\]', content))
            if ext_resources:
                last_ext = ext_resources[-1]
                insert_pos = last_ext.end()

                # Create new ext_resource for background
                bg_id = f"{new_steps}_background"
                new_ext = f'\n[ext_resource type="Texture2D" path="res://assets/images/backgrounds/{bg_filename}" id="{bg_id}"]'
                content = content[:insert_pos] + new_ext + content[insert_pos:]

                # Check if Background node exists
                if '[node name="Background"' not in content:
                    # Find the root node to add Background after
                    root_match = re.search(r'\[node name="Room\w+" type="Node2D"\]\nscript = ExtResource\("[^"]+"\)', content)
                    if root_match:
                        insert_pos = root_match.end()
                        bg_node = f'\n\n[node name="Background" type="Sprite2D" parent="."]\nposition = Vector2(640, 360)\ntexture = ExtResource("{bg_id}")'
                        content = content[:insert_pos] + bg_node + content[insert_pos:]
                else:
                    # Update existing Background node
                    bg_node_pattern = r'(\[node name="Background"[^\]]*\])\ntexture = ExtResource\("[^"]+"\)'
                    if re.search(bg_node_pattern, content):
                        content = re.sub(
                            bg_node_pattern,
                            f'\\1\ntexture = ExtResource("{bg_id}")',
                            content
                        )

                print(f"  Added new background to {scene_path.name}")
            else:
                print(f"  Warning: No ext_resources found in {scene_path.name}")
        else:
            print(f"  Warning: No load_steps found in {scene_path.name}")

    scene_path.write_text(content)

def main():
    base_path = Path("/home/alex/projects/balexbrownii/tank-adventure-godot")
    rooms_path = base_path / "game" / "rooms"

    print("Updating room scenes with new backgrounds...")

    for room_name, bg_file in ROOM_BACKGROUNDS.items():
        room_dir = rooms_path / room_name
        scene_file = room_dir / f"room_{room_name}.tscn"

        if scene_file.exists():
            update_room_scene(scene_file, bg_file)
        else:
            print(f"  Warning: Scene not found: {scene_file}")

    print("\nDone!")

if __name__ == "__main__":
    main()
