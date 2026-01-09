#!/usr/bin/env python3
"""Generate AI backgrounds using Maginary API"""

import requests
import time
from pathlib import Path
from PIL import Image
from io import BytesIO

API_BASE = "https://app.maginary.ai/api/gens/"
API_KEY = "b81aeee427cea7ca89d9d287df4a0b78"

HEADERS = {
    'Authorization': f'Bearer {API_KEY}',
    'Content-Type': 'application/json'
}

# Style suffix for all prompts (Monkey Island aesthetic)
STYLE_SUFFIX = ", 1990s LucasArts adventure game style, Monkey Island Special Edition aesthetic, hand-painted 2D illustration, warm saturated colors, painterly details, 16:9 aspect ratio, high quality"

# Room prompts based on ai_art_generation_guide.md
ROOM_PROMPTS = {
    "wanted_camp": "Hand-painted 2D background, nighttime forest clearing, crackling campfire casting warm orange glow, dense Brazilian rainforest surrounding a small clearing, sleeping bag and backpack near fire, tall tropical trees with hanging vines, moonlight filtering through canopy, mysterious shadows at edges",

    "werewolf_chase": "Hand-painted 2D background, dark menacing forest at night, twisted trees with gnarled branches, thick underbrush, narrow winding path disappearing into darkness, shafts of pale moonlight, mist hovering at ground level, sense of pursuit and danger, Brazilian jungle vegetation, eerie but cartoonish not horror",

    "ditch_hideout": "Hand-painted 2D background, looking up from inside a muddy forest ditch, roots and vines hanging down, small patch of pre-dawn sky visible above, leaf litter and debris at bottom, cozy cramped hiding spot, morning light just starting to peek through, intimate low-angle composition, warm earth tones",

    "morning_miracle": "Hand-painted 2D background, forest clearing at sunrise, golden morning light streaming through trees, dew on grass and leaves, peaceful awakening scene, warm orange and pink sky, mist dissipating, birds silhouettes, hopeful atmosphere",

    "poison_picnic": "Hand-painted 2D background, sunny forest clearing with picnic setup, checkered blanket on grass, suspicious purple spotted mushrooms nearby, tall trees providing dappled shade, peaceful but slightly ominous, bright cheerful colors with hints of danger",

    "road_monsters": "Hand-painted 2D background, Brazilian rural highway, retro gas station with colorful signage, old-fashioned gas pumps, small convenience store, cars and trucks on road, tropical roadside vegetation, bright sunny day, heat shimmer effect on asphalt, vibrant saturated colors, nostalgic small-town feel",

    "space_drift": "Hand-painted 2D background, view of Earth from low orbit, curvature of planet visible, wispy atmosphere layer, scattered clouds below, vast starfield, absurdist comedic tone, warm glow from sun at edge, slightly cartoonish planet, cosmic vista",

    "reentry_fire": "Hand-painted 2D background, atmospheric reentry scene, flames and heat surrounding viewpoint, Earth below through fire, dramatic orange and red glow, streaking motion lines, intense but cartoonish danger, comedic space adventure feel",

    "pig_deer_crossing": "Hand-painted 2D background, quiet Brazilian country road intersection, hand-painted wooden signpost with multiple directions, large shady oak tree to side, motorcycle parked nearby, grassy roadside, rolling hills in distance, late afternoon golden hour lighting, peaceful pastoral scene, warm inviting colors",

    "oak_tree_camp": "Hand-painted 2D background, campsite under massive oak tree at dusk, small campfire, sleeping bags arranged, Brazilian countryside in background, stars beginning to appear, warm firelight contrasting cool evening sky, cozy adventure camp atmosphere",

    "brazil_edge_beach": "Hand-painted 2D background, Brazilian coastline beach, palm trees swaying, raft under construction on sand, turquoise ocean water, sunset colors in sky, tropical paradise feel, adventure departure point, warm golden light",

    "caribbean_raft": "Hand-painted 2D background, view from small wooden raft on open ocean, endless turquoise Caribbean sea, dramatic clouds on horizon, small makeshift sail, supplies tied down on raft, sparkling sunlight on water, sense of vast isolation, romantic adventure feel, rich blue-green palette",

    "puerto_rico": "Hand-painted 2D background, colorful Caribbean harbor dock, pastel-painted buildings, fishing boats moored at wooden pier, palm trees, locals going about business, vibrant market stalls, tropical sunshine, Puerto Rican architectural style, bustling but friendly atmosphere, rich saturated colors",

    "florida_airport": "Hand-painted 2D background, retro-styled airport terminal interior, departure boards with flip displays, rows of seats, large windows showing planes on tarmac, security checkpoint visible in distance, 1970s-80s airport aesthetic, slightly run-down but charming, fluorescent lighting, comedic mundane setting",

    "luggage_room": "Hand-painted 2D background, airport luggage handling area, conveyor belts with suitcases, industrial lighting, workers moving bags, stacks of luggage, large open warehouse space, behind-the-scenes airport feel, muted industrial colors with colorful luggage accents",

    "plane_hold": "Hand-painted 2D background, cramped airplane cargo hold interior, stacked suitcases and crates, cargo netting, dim emergency lighting, curved fuselage walls, luggage compartment doors, slightly claustrophobic, rumbling atmosphere implied, industrial but with adventure game charm, muted colors with dramatic lighting",
}

def generate_image(prompt: str, room_name: str) -> str:
    """Submit generation request and return UUID"""
    full_prompt = prompt + STYLE_SUFFIX
    print(f"  Generating: {room_name}")
    print(f"    Prompt: {full_prompt[:80]}...")

    response = requests.post(
        API_BASE,
        json={'prompt': full_prompt},
        headers=HEADERS
    )

    if response.status_code != 200 and response.status_code != 201:
        print(f"    ERROR: {response.status_code} - {response.text}")
        return None

    data = response.json()
    uuid = data.get('uuid')
    print(f"    UUID: {uuid}")
    return uuid

def wait_for_generation(uuid: str, max_wait: int = 120) -> dict:
    """Poll until generation is complete"""
    print(f"    Waiting for generation...")
    start_time = time.time()

    while time.time() - start_time < max_wait:
        response = requests.get(f"{API_BASE}{uuid}/", headers=HEADERS)
        if response.status_code != 200:
            print(f"    Poll error: {response.status_code}")
            time.sleep(2)
            continue

        data = response.json()
        status = data.get('processing_state', 'unknown')

        if status == 'done':
            print(f"    Completed!")
            return data
        elif status == 'failed':
            print(f"    Generation failed!")
            return None

        print(f"    Status: {status}...")
        time.sleep(3)

    print(f"    Timeout waiting for generation")
    return None

def download_and_resize(image_url: str, output_path: Path) -> bool:
    """Download image and resize to 1280x720"""
    try:
        response = requests.get(image_url)
        if response.status_code != 200:
            print(f"    Download error: {response.status_code}")
            return False

        img = Image.open(BytesIO(response.content))

        # Resize to 1280x720 (crop if needed to maintain aspect)
        target_w, target_h = 1280, 720
        target_ratio = target_w / target_h
        img_ratio = img.width / img.height

        if img_ratio > target_ratio:
            # Image is wider - scale by height and crop width
            new_h = target_h
            new_w = int(img.width * (target_h / img.height))
            img = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
            left = (new_w - target_w) // 2
            img = img.crop((left, 0, left + target_w, target_h))
        else:
            # Image is taller - scale by width and crop height
            new_w = target_w
            new_h = int(img.height * (target_w / img.width))
            img = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
            top = (new_h - target_h) // 2
            img = img.crop((0, top, target_w, top + target_h))

        img.save(output_path, quality=95)
        print(f"    Saved: {output_path.name} ({output_path.stat().st_size // 1024}KB)")
        return True
    except Exception as e:
        print(f"    Error: {e}")
        return False

def main():
    output_dir = Path("assets/images/backgrounds")
    output_dir.mkdir(parents=True, exist_ok=True)

    print("=" * 60)
    print("Generating AI backgrounds using Maginary API")
    print("=" * 60)

    success_count = 0

    for room_name, prompt in ROOM_PROMPTS.items():
        print(f"\n[{room_name}]")

        # Generate
        uuid = generate_image(prompt, room_name)
        if not uuid:
            continue

        # Wait for completion
        result = wait_for_generation(uuid)
        if not result:
            continue

        # Get first image URL from processing_result.slots
        processing_result = result.get('processing_result', {})
        slots = processing_result.get('slots', [])
        if not slots:
            print(f"    No images in result")
            continue

        # Find first successful slot
        image_url = None
        for slot in slots:
            if slot.get('status') == 'success':
                image_url = slot.get('url')
                break

        if not image_url:
            print(f"    No successful image URL")
            continue

        # Download and resize
        output_path = output_dir / f"{room_name}.png"
        if download_and_resize(image_url, output_path):
            success_count += 1

    print("\n" + "=" * 60)
    print(f"Generated {success_count}/{len(ROOM_PROMPTS)} backgrounds")
    print("=" * 60)

if __name__ == "__main__":
    main()
