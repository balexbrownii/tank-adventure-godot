#!/usr/bin/env python3
"""Generate placeholder background images and audio for Tank's Great Adventure"""

import os
import struct
import wave
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

# Room definitions with colors and themes
ROOMS = {
    "wanted_camp": {
        "name": "Wanted Camp",
        "colors": [(20, 30, 20), (40, 60, 30)],  # Dark forest green
        "desc": "Night Camp - Forest Clearing"
    },
    "werewolf_chase": {
        "name": "Werewolf Chase",
        "colors": [(10, 10, 20), (30, 20, 40)],  # Dark purple night
        "desc": "Dark Forest - Chase Scene"
    },
    "ditch_hideout": {
        "name": "Ditch Hideout",
        "colors": [(30, 25, 15), (50, 40, 25)],  # Earthy brown
        "desc": "Muddy Ditch - Hiding Spot"
    },
    "morning_miracle": {
        "name": "Morning Miracle",
        "colors": [(80, 60, 40), (150, 120, 80)],  # Dawn orange
        "desc": "Morning Ditch - Wake Up"
    },
    "poison_picnic": {
        "name": "Poison Picnic",
        "colors": [(40, 80, 40), (80, 120, 60)],  # Forest green
        "desc": "Forest Clearing - Picnic"
    },
    "road_monsters": {
        "name": "Road Monsters",
        "colors": [(60, 60, 60), (100, 90, 80)],  # Asphalt gray
        "desc": "Highway - Gas Station"
    },
    "space_drift": {
        "name": "Space Drift",
        "colors": [(5, 5, 20), (20, 10, 40)],  # Deep space blue
        "desc": "Space - Earth Below"
    },
    "reentry_fire": {
        "name": "Re-entry Fire",
        "colors": [(80, 30, 10), (180, 60, 20)],  # Fire orange
        "desc": "Atmosphere - Re-entry"
    },
    "pig_deer_crossing": {
        "name": "Pig Deer Crossing",
        "colors": [(80, 100, 60), (120, 140, 80)],  # Country road green
        "desc": "Road Crossing - Meet Companions"
    },
    "oak_tree_camp": {
        "name": "Oak Tree Camp",
        "colors": [(50, 70, 40), (90, 110, 60)],  # Evening forest
        "desc": "Oak Tree - Camp Site"
    },
    "brazil_edge_beach": {
        "name": "Brazil Edge Beach",
        "colors": [(60, 120, 140), (100, 160, 180)],  # Beach blue
        "desc": "Brazil Coast - Raft Prep"
    },
    "caribbean_raft": {
        "name": "Caribbean Raft",
        "colors": [(30, 80, 120), (50, 120, 160)],  # Ocean blue
        "desc": "Caribbean Sea - Raft Journey"
    },
    "puerto_rico": {
        "name": "Puerto Rico",
        "colors": [(140, 100, 70), (180, 140, 100)],  # Warm dock
        "desc": "Puerto Rico - Dock & Motel"
    },
    "florida_airport": {
        "name": "Florida Airport",
        "colors": [(180, 180, 180), (220, 220, 220)],  # Airport gray
        "desc": "Airport - Terminal"
    },
    "luggage_room": {
        "name": "Luggage Room",
        "colors": [(120, 110, 100), (160, 150, 140)],  # Baggage area
        "desc": "Airport - Luggage Area"
    },
    "plane_hold": {
        "name": "Plane Hold",
        "colors": [(80, 80, 90), (110, 110, 120)],  # Cargo hold
        "desc": "Airplane - Cargo Hold"
    },
    "brazil_forest": {
        "name": "Brazil Forest",
        "colors": [(30, 60, 30), (60, 100, 50)],  # Jungle green
        "desc": "Brazil - Dense Jungle"
    }
}

# Audio definitions
MUSIC_TRACKS = {
    "theme_adventure": {"freq": 440, "duration": 5, "desc": "Adventure Theme"},
    "theme_tense": {"freq": 220, "duration": 5, "desc": "Tense Chase"},
    "theme_peaceful": {"freq": 330, "duration": 5, "desc": "Peaceful Scene"},
    "theme_space": {"freq": 160, "duration": 5, "desc": "Space Ambient"},
    "theme_caribbean": {"freq": 392, "duration": 5, "desc": "Caribbean"},
    "theme_airport": {"freq": 277, "duration": 5, "desc": "Airport Bustle"},
}

SFX = {
    "sfx_click": {"freq": 800, "duration": 0.1, "desc": "UI Click"},
    "sfx_pickup": {"freq": 600, "duration": 0.2, "desc": "Item Pickup"},
    "sfx_door": {"freq": 200, "duration": 0.5, "desc": "Door Open"},
    "sfx_footstep": {"freq": 150, "duration": 0.15, "desc": "Footstep"},
    "sfx_splash": {"freq": 300, "duration": 0.4, "desc": "Water Splash"},
    "sfx_crash": {"freq": 100, "duration": 1.0, "desc": "Crash Sound"},
    "sfx_wolf_howl": {"freq": 350, "duration": 1.5, "desc": "Wolf Howl"},
    "sfx_engine": {"freq": 120, "duration": 0.8, "desc": "Engine Sound"},
}

def create_gradient_background(colors, width=1280, height=720):
    """Create a vertical gradient background"""
    img = Image.new('RGB', (width, height))
    draw = ImageDraw.Draw(img)

    r1, g1, b1 = colors[0]
    r2, g2, b2 = colors[1]

    for y in range(height):
        ratio = y / height
        r = int(r1 + (r2 - r1) * ratio)
        g = int(g1 + (g2 - g1) * ratio)
        b = int(b1 + (b2 - b1) * ratio)
        draw.line([(0, y), (width, y)], fill=(r, g, b))

    return img

def add_text_overlay(img, room_name, description):
    """Add room name as text overlay for identification"""
    draw = ImageDraw.Draw(img)

    # Try to load a font, fall back to default
    try:
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 32)
        small_font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 18)
    except:
        font = ImageFont.load_default()
        small_font = font

    # Add room name (bottom center)
    text = room_name.upper()
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    x = (img.width - text_width) // 2
    y = img.height - 80

    # Draw shadow
    draw.text((x+2, y+2), text, fill=(0, 0, 0, 180), font=font)
    # Draw text
    draw.text((x, y), text, fill=(255, 255, 255, 230), font=font)

    # Add description (smaller, above)
    bbox2 = draw.textbbox((0, 0), description, font=small_font)
    text_width2 = bbox2[2] - bbox2[0]
    x2 = (img.width - text_width2) // 2
    draw.text((x2+1, y-25+1), description, fill=(0, 0, 0, 150), font=small_font)
    draw.text((x2, y-25), description, fill=(200, 200, 200, 200), font=small_font)

    return img

def add_visual_elements(img, room_key):
    """Add simple visual elements based on room type"""
    draw = ImageDraw.Draw(img)
    width, height = img.size

    # Add stars for space
    if room_key == "space_drift":
        import random
        random.seed(42)
        for _ in range(100):
            x = random.randint(0, width)
            y = random.randint(0, height - 100)
            size = random.randint(1, 3)
            brightness = random.randint(150, 255)
            draw.ellipse([x, y, x+size, y+size], fill=(brightness, brightness, brightness))

    # Add waves for water scenes
    elif room_key in ["caribbean_raft", "brazil_edge_beach"]:
        for i in range(0, width, 80):
            y_base = height - 150
            draw.arc([i, y_base, i+80, y_base+40], 0, 180, fill=(100, 150, 180), width=2)

    # Add road lines for road scenes
    elif room_key in ["road_monsters", "pig_deer_crossing"]:
        # Dashed center line
        for i in range(0, width, 60):
            draw.rectangle([i, height//2, i+30, height//2+5], fill=(255, 255, 200))

    # Add fire glow for reentry
    elif room_key == "reentry_fire":
        for i in range(20):
            alpha = 255 - i * 10
            draw.ellipse([width//2-200-i*5, height-300-i*3,
                         width//2+200+i*5, height+50],
                        outline=(255, 150, 50, alpha), width=3)

    return img

def generate_simple_tone(filename, frequency=440, duration=1.0, sample_rate=44100, volume=0.3):
    """Generate a simple tone as a WAV file"""
    import numpy as np

    # Generate samples
    t = np.linspace(0, duration, int(sample_rate * duration), False)

    # Generate tone with envelope
    envelope = np.ones_like(t)
    fade_samples = int(sample_rate * 0.05)  # 50ms fade
    envelope[:fade_samples] = np.linspace(0, 1, fade_samples)
    envelope[-fade_samples:] = np.linspace(1, 0, fade_samples)

    # Generate waveform
    tone = np.sin(frequency * 2 * np.pi * t) * volume * envelope

    # Add harmonics for richer sound
    tone += np.sin(frequency * 2 * 2 * np.pi * t) * volume * 0.3 * envelope
    tone += np.sin(frequency * 3 * 2 * np.pi * t) * volume * 0.1 * envelope

    # Normalize
    tone = tone / np.max(np.abs(tone)) * 0.8

    # Convert to 16-bit integers
    audio_data = (tone * 32767).astype(np.int16)

    # Write WAV file
    with wave.open(filename, 'w') as wav_file:
        wav_file.setnchannels(1)
        wav_file.setsampwidth(2)
        wav_file.setframerate(sample_rate)
        wav_file.writeframes(audio_data.tobytes())

def main():
    base_path = Path("/home/alex/projects/balexbrownii/tank-adventure-godot")

    # Create directories
    bg_path = base_path / "assets" / "images" / "backgrounds"
    music_path = base_path / "assets" / "audio" / "music"
    sfx_path = base_path / "assets" / "audio" / "sfx"

    bg_path.mkdir(parents=True, exist_ok=True)
    music_path.mkdir(parents=True, exist_ok=True)
    sfx_path.mkdir(parents=True, exist_ok=True)

    # Generate backgrounds
    print("Generating backgrounds...")
    for room_key, room_data in ROOMS.items():
        filename = bg_path / f"{room_key}.png"
        if filename.exists() and room_key == "forest-interactive":
            continue  # Don't overwrite existing

        img = create_gradient_background(room_data["colors"])
        img = add_visual_elements(img, room_key)
        img = add_text_overlay(img, room_data["name"], room_data["desc"])
        img.save(filename)
        print(f"  Created: {filename.name}")

    # Generate music
    print("\nGenerating music tracks...")
    for track_name, track_data in MUSIC_TRACKS.items():
        filename = music_path / f"{track_name}.wav"
        generate_simple_tone(
            str(filename),
            frequency=track_data["freq"],
            duration=track_data["duration"],
            volume=0.2
        )
        print(f"  Created: {filename.name} ({track_data['desc']})")

    # Generate SFX
    print("\nGenerating sound effects...")
    for sfx_name, sfx_data in SFX.items():
        filename = sfx_path / f"{sfx_name}.wav"
        generate_simple_tone(
            str(filename),
            frequency=sfx_data["freq"],
            duration=sfx_data["duration"],
            volume=0.4
        )
        print(f"  Created: {filename.name} ({sfx_data['desc']})")

    print("\nAll assets generated!")
    print(f"\nBackgrounds: {len(ROOMS)} files in {bg_path}")
    print(f"Music: {len(MUSIC_TRACKS)} files in {music_path}")
    print(f"SFX: {len(SFX)} files in {sfx_path}")

if __name__ == "__main__":
    main()
