#!/usr/bin/env python3
"""Create placeholder character sprites for Tank's Great Adventure"""

from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

# Character definitions
CHARACTERS = {
    "tank": {
        "color": (180, 100, 80),  # Tan/peach
        "accent": (50, 50, 50),   # Dark (black belt)
        "width": 64,
        "height": 128,
        "label": "TANK"
    },
    "pig": {
        "color": (255, 180, 180),  # Pink
        "accent": (139, 90, 43),   # Brown (cowboy hat)
        "width": 48,
        "height": 80,
        "label": "PIG"
    },
    "mr_snuggles": {
        "color": (160, 130, 100),  # Brown/tan (deer)
        "accent": (80, 60, 40),    # Dark brown
        "width": 80,
        "height": 80,
        "label": "DEER"
    }
}

def create_character_sprite(name: str, data: dict, output_dir: Path):
    """Create a simple character sprite with idle/walk/talk frames"""
    width = data["width"]
    height = data["height"]
    color = data["color"]
    accent = data["accent"]
    label = data["label"]

    # Create base sprite
    def draw_character(img, offset_y=0):
        draw = ImageDraw.Draw(img)

        # Body
        body_top = 30 + offset_y
        body_bottom = height - 10
        draw.rectangle([10, body_top, width-10, body_bottom], fill=color, outline=accent, width=2)

        # Head
        head_size = min(width-20, 30)
        head_x = (width - head_size) // 2
        draw.ellipse([head_x, 5+offset_y, head_x+head_size, 5+offset_y+head_size], fill=color, outline=accent, width=2)

        # Eyes
        eye_y = 12 + offset_y
        draw.ellipse([head_x+5, eye_y, head_x+10, eye_y+5], fill=(255, 255, 255))
        draw.ellipse([head_x+head_size-10, eye_y, head_x+head_size-5, eye_y+5], fill=(255, 255, 255))
        draw.ellipse([head_x+6, eye_y+1, head_x+9, eye_y+4], fill=(0, 0, 0))
        draw.ellipse([head_x+head_size-9, eye_y+1, head_x+head_size-6, eye_y+4], fill=(0, 0, 0))

        # Accent (belt for Tank, hat for Pig, antlers for deer)
        if name == "tank":
            # Black belt
            belt_y = body_top + (body_bottom - body_top) // 2
            draw.rectangle([10, belt_y-3, width-10, belt_y+3], fill=accent)
        elif name == "pig":
            # Cowboy hat
            draw.polygon([head_x-5, 8, head_x+head_size+5, 8, head_x+head_size, 15+offset_y, head_x, 15+offset_y], fill=accent)
            draw.rectangle([head_x+2, 2, head_x+head_size-2, 8], fill=accent)
        elif name == "mr_snuggles":
            # Antlers
            draw.line([head_x+5, 8+offset_y, head_x-5, 0], fill=accent, width=2)
            draw.line([head_x+head_size-5, 8+offset_y, head_x+head_size+5, 0], fill=accent, width=2)

        return img

    # Create sprite sheet (4 frames: idle, walk1, walk2, talk)
    sheet_width = width * 4
    sheet = Image.new('RGBA', (sheet_width, height), (0, 0, 0, 0))

    # Frame 1: Idle
    frame1 = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    frame1 = draw_character(frame1, 0)
    sheet.paste(frame1, (0, 0))

    # Frame 2: Walk 1 (slight bob down)
    frame2 = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    frame2 = draw_character(frame2, 2)
    sheet.paste(frame2, (width, 0))

    # Frame 3: Walk 2 (slight bob up)
    frame3 = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    frame3 = draw_character(frame3, -2)
    sheet.paste(frame3, (width*2, 0))

    # Frame 4: Talk (mouth open)
    frame4 = Image.new('RGBA', (width, height), (0, 0, 0, 0))
    frame4 = draw_character(frame4, 0)
    draw = ImageDraw.Draw(frame4)
    # Add open mouth
    head_size = min(width-20, 30)
    head_x = (width - head_size) // 2
    mouth_y = 20
    draw.ellipse([head_x+8, mouth_y, head_x+head_size-8, mouth_y+8], fill=(80, 30, 30))
    sheet.paste(frame4, (width*3, 0))

    # Save sprite sheet
    output_file = output_dir / f"{name}.png"
    sheet.save(output_file)
    print(f"  Created: {output_file.name} ({sheet_width}x{height})")

    # Also save single frame for character scene
    single_output = output_dir / f"{name}_single.png"
    frame1.save(single_output)
    print(f"  Created: {single_output.name} ({width}x{height})")

def main():
    base_path = Path("/home/alex/projects/balexbrownii/tank-adventure-godot")
    sprites_path = base_path / "assets" / "images" / "characters"
    sprites_path.mkdir(parents=True, exist_ok=True)

    print("Creating character sprites...")
    for char_name, char_data in CHARACTERS.items():
        create_character_sprite(char_name, char_data, sprites_path)

    print("\nDone! Sprites saved to:", sprites_path)

if __name__ == "__main__":
    main()
