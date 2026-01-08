#!/usr/bin/env python3
"""Create Godot import files for audio assets"""

from pathlib import Path
import uuid

IMPORT_TEMPLATE = '''[remap]

importer="wav"
type="AudioStreamWAV"
uid="uid://{uid}"
path="res://.godot/imported/{filename}.sample"

[deps]

source_file="res://{source_path}"
dest_files=["res://.godot/imported/{filename}.sample"]

[params]

force/8_bit=false
force/mono=false
force/max_rate=false
force/max_rate_hz=44100
edit/trim=false
edit/normalize=false
edit/loop_mode=0
edit/loop_begin=0
edit/loop_end=-1
compress/mode=0
'''

def generate_uid():
    """Generate a Godot-style UID"""
    # Godot UIDs are base62 encoded
    chars = "0123456789abcdefghijklmnopqrstuvwxyz"
    import random
    return ''.join(random.choice(chars) for _ in range(12))

def main():
    base_path = Path("/home/alex/projects/balexbrownii/tank-adventure-godot")

    # Find all WAV files in assets/audio
    audio_path = base_path / "assets" / "audio"
    wav_files = list(audio_path.rglob("*.wav"))

    print(f"Creating import files for {len(wav_files)} audio files...")

    for wav_file in wav_files:
        import_file = wav_file.with_suffix(wav_file.suffix + ".import")

        # Get relative path from project root
        rel_path = wav_file.relative_to(base_path)
        source_path = str(rel_path).replace("\\", "/")

        uid = generate_uid()

        content = IMPORT_TEMPLATE.format(
            uid=uid,
            filename=wav_file.stem,
            source_path=source_path
        )

        import_file.write_text(content)
        print(f"  Created: {import_file.name}")

    # Also create import files for background images
    bg_path = base_path / "assets" / "images" / "backgrounds"
    png_files = list(bg_path.glob("*.png"))

    print(f"\nCreating import files for {len(png_files)} background images...")

    PNG_IMPORT_TEMPLATE = '''[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://{uid}"
path="res://.godot/imported/{filename}.ctex"
metadata={{
"vram_texture": false
}}

[deps]

source_file="res://{source_path}"
dest_files=["res://.godot/imported/{filename}.ctex"]

[params]

compress/mode=0
compress/high_quality=false
compress/lossy_quality=0.7
compress/hdr_compression=1
compress/normal_map=0
compress/channel_pack=0
mipmaps/generate=false
mipmaps/limit=-1
roughness/mode=0
roughness/src_normal=""
process/fix_alpha_border=true
process/premult_alpha=false
process/normal_map_invert_y=false
process/hdr_as_srgb=false
process/hdr_clamp_exposure=false
process/size_limit=0
detect_3d/compress_to=1
'''

    for png_file in png_files:
        import_file = png_file.with_suffix(png_file.suffix + ".import")
        if import_file.exists():
            continue

        rel_path = png_file.relative_to(base_path)
        source_path = str(rel_path).replace("\\", "/")

        uid = generate_uid()

        content = PNG_IMPORT_TEMPLATE.format(
            uid=uid,
            filename=png_file.stem,
            source_path=source_path
        )

        import_file.write_text(content)
        print(f"  Created: {import_file.name}")

    # Create import files for character sprites
    char_path = base_path / "assets" / "images" / "characters"
    char_files = list(char_path.glob("*.png"))

    print(f"\nCreating import files for {len(char_files)} character sprites...")

    for png_file in char_files:
        import_file = png_file.with_suffix(png_file.suffix + ".import")
        if import_file.exists():
            continue

        rel_path = png_file.relative_to(base_path)
        source_path = str(rel_path).replace("\\", "/")

        uid = generate_uid()

        content = PNG_IMPORT_TEMPLATE.format(
            uid=uid,
            filename=png_file.stem,
            source_path=source_path
        )

        import_file.write_text(content)
        print(f"  Created: {import_file.name}")

    print("\nDone!")

if __name__ == "__main__":
    main()
