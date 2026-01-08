# Tank's Great Adventure (Godot)

A point-and-click adventure game built with Godot 4 and Popochiu.

## Play Locally

1. Open project in Godot 4.x
2. Press F5 to run

## Deploy to Vercel

### First-time setup

1. Install Godot 4.x
2. Open project in Godot
3. Go to **Editor → Manage Export Templates → Download**
4. Connect repo to Vercel at vercel.com

### Deploy workflow

```bash
# Option A: Use export script
./export-web.sh
git add dist && git commit -m "Build web export" && git push

# Option B: Export from Godot UI
# 1. Project → Export → Web → Export Project
# 2. Save to dist/index.html
# 3. git add dist && git commit -m "Build web export" && git push
```

Vercel auto-deploys when you push.

## Project Structure

- `game/` - Game content (rooms, characters, items, dialogs)
- `dist/` - HTML5 export (served by Vercel)
- `addons/popochiu/` - Adventure game framework
