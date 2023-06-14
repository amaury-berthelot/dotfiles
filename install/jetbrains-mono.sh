wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip -d JetBrainsMono-2.304 JetBrainsMono-2.304.zip
mkdir -p ~/.local/share/fonts/
mv JetBrainsMono-2.304/fonts/ttf/* ~/.local/share/fonts/
rm -r JetBrainsMono-2.304.zip JetBrainsMono-2.304
