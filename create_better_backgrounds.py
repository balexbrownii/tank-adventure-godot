#!/usr/bin/env python3
"""Create visible placeholder backgrounds for Tank's Great Adventure"""

from PIL import Image, ImageDraw
from pathlib import Path

ROOMS = {
    "wanted_camp": {"name": "WANTED CAMP", "bg": (30, 50, 30), "fg": (60, 100, 60), "accent": (200, 100, 50)},
    "brazil_forest": {"name": "BRAZIL FOREST", "bg": (20, 60, 20), "fg": (40, 100, 40), "accent": (100, 200, 100)},
    "werewolf_chase": {"name": "WEREWOLF CHASE", "bg": (20, 20, 40), "fg": (40, 40, 80), "accent": (150, 150, 200)},
    "ditch_hideout": {"name": "DITCH HIDEOUT", "bg": (40, 30, 20), "fg": (80, 60, 40), "accent": (150, 120, 80)},
    "road_monsters": {"name": "ROAD MONSTERS", "bg": (50, 50, 50), "fg": (80, 80, 80), "accent": (255, 200, 0)},
    "space_drift": {"name": "SPACE DRIFT", "bg": (5, 5, 20), "fg": (20, 20, 60), "accent": (100, 100, 255)},
    "reentry_fire": {"name": "REENTRY FIRE", "bg": (60, 20, 10), "fg": (120, 40, 20), "accent": (255, 150, 50)},
    "pig_deer_crossing": {"name": "PIG DEER CROSSING", "bg": (40, 60, 30), "fg": (80, 120, 60), "accent": (200, 180, 100)},
    "oak_tree_camp": {"name": "OAK TREE CAMP", "bg": (30, 50, 25), "fg": (60, 100, 50), "accent": (139, 90, 43)},
    "morning_miracle": {"name": "MORNING MIRACLE", "bg": (60, 50, 40), "fg": (120, 100, 80), "accent": (255, 220, 150)},
    "poison_picnic": {"name": "POISON PICNIC", "bg": (30, 50, 30), "fg": (60, 100, 60), "accent": (150, 50, 150)},
    "brazil_edge_beach": {"name": "BRAZIL BEACH", "bg": (40, 60, 80), "fg": (80, 120, 160), "accent": (255, 220, 150)},
    "caribbean_raft": {"name": "CARIBBEAN RAFT", "bg": (20, 60, 100), "fg": (40, 120, 200), "accent": (255, 255, 200)},
    "puerto_rico": {"name": "PUERTO RICO", "bg": (60, 80, 60), "fg": (120, 160, 120), "accent": (255, 200, 150)},
    "florida_airport": {"name": "FLORIDA AIRPORT", "bg": (60, 60, 70), "fg": (120, 120, 140), "accent": (200, 200, 220)},
    "luggage_room": {"name": "LUGGAGE ROOM", "bg": (50, 50, 60), "fg": (100, 100, 120), "accent": (180, 150, 100)},
    "plane_hold": {"name": "PLANE HOLD", "bg": (40, 45, 50), "fg": (80, 90, 100), "accent": (150, 150, 170)},
}

def create_background(name: str, data: dict, output_dir: Path):
    """Create a visible placeholder background"""
    width, height = 1280, 720
    bg = data["bg"]
    fg = data["fg"]
    accent = data["accent"]

    img = Image.new("RGB", (width, height), bg)
    draw = ImageDraw.Draw(img)

    # Draw gradient sky/background (top third)
    for y in range(height // 3):
        factor = y / (height // 3)
        r = int(bg[0] + (fg[0] - bg[0]) * factor)
        g = int(bg[1] + (fg[1] - bg[1]) * factor)
        b = int(bg[2] + (fg[2] - bg[2]) * factor)
        draw.line([(0, y), (width, y)], fill=(r, g, b))

    # Draw ground (bottom half) - slightly different shade
    ground_color = (fg[0] - 10, fg[1] - 10, fg[2] - 10)
    draw.rectangle([0, height // 2, width, height], fill=ground_color)

    # Draw some simple shapes based on room type
    if "forest" in name or "camp" in name or "tree" in name:
        # Trees
        for x in [100, 300, 500, 800, 1000, 1150]:
            tree_h = 200 + (x % 100)
            # Trunk
            draw.rectangle([x-10, height//2-tree_h, x+10, height//2+50], fill=(60, 40, 20))
            # Foliage
            draw.ellipse([x-60, height//2-tree_h-80, x+60, height//2-tree_h+40], fill=(30, 80, 30))
            draw.ellipse([x-50, height//2-tree_h-120, x+50, height//2-tree_h], fill=(40, 100, 40))

    elif "beach" in name or "raft" in name or "caribbean" in name:
        # Water waves
        for y in range(height // 2, height, 30):
            wave_color = (20 + (y % 40), 80 + (y % 60), 150 + (y % 50))
            draw.arc([0, y-15, width, y+15], 0, 180, fill=wave_color, width=3)
        # Sun
        draw.ellipse([width-150, 50, width-50, 150], fill=(255, 220, 100))

    elif "space" in name:
        # Stars
        import random
        random.seed(42)
        for _ in range(200):
            x, y = random.randint(0, width), random.randint(0, height)
            size = random.randint(1, 3)
            brightness = random.randint(150, 255)
            draw.ellipse([x, y, x+size, y+size], fill=(brightness, brightness, brightness))
        # Earth
        draw.ellipse([width//2-100, height-150, width//2+100, height+50], fill=(50, 100, 200))
        draw.ellipse([width//2-80, height-130, width//2+60, height], fill=(80, 150, 80))

    elif "fire" in name or "reentry" in name:
        # Flames
        for i in range(20):
            x = 100 + i * 60
            flame_h = 100 + (i % 5) * 30
            draw.polygon([
                (x, height - 100),
                (x - 30, height - 100 + flame_h),
                (x + 30, height - 100 + flame_h)
            ], fill=(255, 150 - i*5, 50))

    elif "road" in name:
        # Road
        draw.rectangle([0, height//2, width, height//2 + 150], fill=(60, 60, 60))
        # Road lines
        for x in range(0, width, 100):
            draw.rectangle([x, height//2 + 70, x+50, height//2 + 80], fill=(255, 255, 200))

    elif "airport" in name:
        # Building
        draw.rectangle([200, 200, 1000, height//2 + 100], fill=(150, 150, 160))
        # Windows
        for x in range(250, 950, 80):
            for y in range(250, height//2, 60):
                draw.rectangle([x, y, x+40, y+30], fill=(100, 150, 200))

    elif "luggage" in name or "hold" in name:
        # Boxes/luggage
        for i in range(8):
            x = 100 + i * 150
            y = height // 2 + 50
            color = [(180, 100, 80), (100, 100, 180), (100, 180, 100), (180, 180, 100)][i % 4]
            draw.rectangle([x, y, x+100, y+80], fill=color, outline=(50, 50, 50), width=2)

    # Draw room name as simple rectangles (since no fonts)
    # Create a banner at the bottom
    draw.rectangle([0, height - 80, width, height], fill=(0, 0, 0, 128))

    # Draw accent color bar
    draw.rectangle([0, height - 82, width, height - 78], fill=accent)

    output_path = output_dir / f"{name}.png"
    img.save(output_path)
    print(f"  Created: {output_path.name}")

def main():
    base_path = Path("/home/alex/projects/balexbrownii/tank-adventure-godot")
    output_dir = base_path / "assets" / "images" / "backgrounds"
    output_dir.mkdir(parents=True, exist_ok=True)

    print("Creating better placeholder backgrounds...")
    for room_name, room_data in ROOMS.items():
        create_background(room_name, room_data, output_dir)

    print("\nDone!")

if __name__ == "__main__":
    main()
