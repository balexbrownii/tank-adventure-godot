#!/bin/bash
# Export Godot project to HTML5 for Vercel deployment

GODOT_PATH="${GODOT_PATH:-godot}"

echo "Exporting to HTML5..."
$GODOT_PATH --headless --export-release "Web" dist/index.html

if [ $? -eq 0 ]; then
    echo "Export complete! Files in dist/"
    echo "Run 'git add dist && git commit && git push' to deploy to Vercel"
else
    echo "Export failed. Make sure Godot is installed and Web export templates are downloaded."
    echo "In Godot: Editor → Manage Export Templates → Download"
fi
