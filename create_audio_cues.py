#!/usr/bin/env python3
"""Create Popochiu audio cue resources"""

from pathlib import Path

# Music tracks
MUSIC = {
    "mx_adventure": {"file": "theme_adventure.wav", "loop": True, "bus": "Music"},
    "mx_tense": {"file": "theme_tense.wav", "loop": True, "bus": "Music"},
    "mx_peaceful": {"file": "theme_peaceful.wav", "loop": True, "bus": "Music"},
    "mx_space": {"file": "theme_space.wav", "loop": True, "bus": "Music"},
    "mx_caribbean": {"file": "theme_caribbean.wav", "loop": True, "bus": "Music"},
    "mx_airport": {"file": "theme_airport.wav", "loop": True, "bus": "Music"},
}

# Sound effects
SFX = {
    "sfx_click": {"file": "sfx_click.wav", "loop": False, "bus": "SFX"},
    "sfx_pickup": {"file": "sfx_pickup.wav", "loop": False, "bus": "SFX"},
    "sfx_door": {"file": "sfx_door.wav", "loop": False, "bus": "SFX"},
    "sfx_footstep": {"file": "sfx_footstep.wav", "loop": False, "bus": "SFX"},
    "sfx_splash": {"file": "sfx_splash.wav", "loop": False, "bus": "SFX"},
    "sfx_crash": {"file": "sfx_crash.wav", "loop": False, "bus": "SFX"},
    "sfx_wolf_howl": {"file": "sfx_wolf_howl.wav", "loop": False, "bus": "SFX"},
    "sfx_engine": {"file": "sfx_engine.wav", "loop": False, "bus": "SFX"},
}

MUSIC_TRES_TEMPLATE = '''[gd_resource type="Resource" script_class="AudioCueMusic" load_steps=3 format=3]

[ext_resource type="Script" path="res://addons/popochiu/engine/audio_manager/audio_cue_music.gd" id="1_script"]
[ext_resource type="AudioStreamWAV" path="res://assets/audio/music/{filename}" id="2_audio"]

[resource]
script = ExtResource("1_script")
audio = ExtResource("2_audio")
loop = {loop}
is_2d = false
can_play_simultaneous = false
pitch = 0.0
volume = -6.0
rnd_pitch = Vector2(0, 0)
rnd_volume = Vector2(0, 0)
max_distance = 2000
bus = "{bus}"
'''

SFX_TRES_TEMPLATE = '''[gd_resource type="Resource" script_class="AudioCueSound" load_steps=3 format=3]

[ext_resource type="Script" path="res://addons/popochiu/engine/audio_manager/audio_cue_sound.gd" id="1_script"]
[ext_resource type="AudioStreamWAV" path="res://assets/audio/sfx/{filename}" id="2_audio"]

[resource]
script = ExtResource("1_script")
audio = ExtResource("2_audio")
loop = false
is_2d = false
can_play_simultaneous = true
pitch = 0.0
volume = 0.0
rnd_pitch = Vector2(0, 0)
rnd_volume = Vector2(0, 0)
max_distance = 2000
bus = "{bus}"
'''

def main():
    base_path = Path("/home/alex/projects/balexbrownii/tank-adventure-godot")
    music_path = base_path / "game" / "audio" / "music"
    sfx_path = base_path / "game" / "audio" / "sfx"

    music_path.mkdir(parents=True, exist_ok=True)
    sfx_path.mkdir(parents=True, exist_ok=True)

    # Generate music cues
    print("Creating music cues...")
    music_entries = []
    music_const_lines = []
    music_var_lines = []
    music_get_lines = []

    for cue_name, data in MUSIC.items():
        tres_file = music_path / f"{cue_name}.tres"
        content = MUSIC_TRES_TEMPLATE.format(
            filename=data["file"],
            loop="true" if data["loop"] else "false",
            bus=data["bus"]
        )
        tres_file.write_text(content)
        print(f"  Created: {tres_file.name}")

        # For popochiu_data.cfg
        pascal_name = "".join(word.capitalize() for word in cue_name.split("_"))
        music_entries.append(f'{pascal_name}="res://game/audio/music/{cue_name}.tres"')

        # For a.gd
        music_const_lines.append(f'const AC{pascal_name} := preload("res://game/audio/music/{cue_name}.tres")')
        music_var_lines.append(f'var {pascal_name}: AC{pascal_name} : get = get_{pascal_name}')
        music_get_lines.append(f'func get_{pascal_name}() -> AC{pascal_name}: return get_runtime_cue("{pascal_name}")')

    # Generate SFX cues
    print("\nCreating SFX cues...")
    sfx_entries = []
    sfx_const_lines = []
    sfx_var_lines = []
    sfx_get_lines = []

    for cue_name, data in SFX.items():
        tres_file = sfx_path / f"{cue_name}.tres"
        content = SFX_TRES_TEMPLATE.format(
            filename=data["file"],
            bus=data["bus"]
        )
        tres_file.write_text(content)
        print(f"  Created: {tres_file.name}")

        # For popochiu_data.cfg
        pascal_name = "".join(word.capitalize() for word in cue_name.split("_"))
        sfx_entries.append(f'{pascal_name}="res://game/audio/sfx/{cue_name}.tres"')

        # For a.gd
        sfx_const_lines.append(f'const AC{pascal_name} := preload("res://game/audio/sfx/{cue_name}.tres")')
        sfx_var_lines.append(f'var {pascal_name}: AC{pascal_name} : get = get_{pascal_name}')
        sfx_get_lines.append(f'func get_{pascal_name}() -> AC{pascal_name}: return get_runtime_cue("{pascal_name}")')

    # Generate a.gd content
    a_gd_content = '''@tool
extends "res://addons/popochiu/engine/interfaces/i_audio.gd"

# cues ----
# Music cues
{music_const}

# SFX cues
{sfx_const}

# Music vars
{music_var}

# SFX vars
{sfx_var}
# ---- cues

# Music getters
{music_get}

# SFX getters
{sfx_get}
'''.format(
        music_const="\n".join(music_const_lines),
        sfx_const="\n".join(sfx_const_lines),
        music_var="\n".join(music_var_lines),
        sfx_var="\n".join(sfx_var_lines),
        music_get="\n\n".join(music_get_lines),
        sfx_get="\n\n".join(sfx_get_lines)
    )

    a_gd_path = base_path / "game" / "autoloads" / "a.gd"
    a_gd_path.write_text(a_gd_content)
    print(f"\nUpdated: {a_gd_path}")

    # Print config entries for manual addition
    print("\n" + "="*50)
    print("Add these to popochiu_data.cfg:")
    print("="*50)
    print("\n[music]\n")
    print("\n".join(music_entries))
    print("\n[sfx]\n")
    print("\n".join(sfx_entries))

if __name__ == "__main__":
    main()
