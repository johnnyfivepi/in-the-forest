# In the forest 

_last updated: December 1, 2024_

## Screen
<img src="https://github.com/johnnyfivepi/in-the-forest/blob/main/forest.png" alt="in the forest" width="300"/><br>

demo: [Listen on SoundCloud](https://soundcloud.com/shiny-water6821/in_the_forest)<br>
*(please excuse the static)*

## About
A simple Lua script for Norns that creates a tranquil forest atmosphere at night, featuring generative, peaceful sounds and subtle environmental variations. The script incorporates the phrase 'with the light of a billion brilliant stars,' inspired by Kamala Harris' speech on November 6, 2024. I hope you find this calming!

Have fun experimenting with it!

## Requirements
- Norns
- PolyPerc engine (which should already be installed)

## Features
- Generates calming ambient sounds reminiscent of a forest at night
- Gradually evolving soundscape with subtle variations in pitch, timing, and volume
- Phrase repetition for relaxation and immersive experience
- Plays in a continuous loop
- Twinkling stars

## Customization
This script includes a range of customizable parameters. Open the script in [Maiden](https://monome.org/docs/norns/maiden/), the Norns editor, to adjust the following parameters:

- **Scale**: Change the musical scale to create different moods or tonalities. Uncomment the line for the scale you want to use, and comment out others.
- **Number of Stars**: Adjust the "stars" variable to increase or decrease the number of stars visible in the forest atmosphere. By default, there are 30.
- **Additional Parameters**: Explore the parameters to tweak the effects and sounds, such as the reverb, delay, release time, etc.

## Installation
- Copy the `in_the_forest.lua` file to the Norns `dust/code` directory.
- Load the script through the Norns interface.

## Contributing
I welcome contributions! Whether you want to enhance the soundscapes, add new customization options, or refine existing features, your ideas and improvements are appreciated.

To contribute:
1. **Fork** this repository.
2. Make your changes in a new branch.
3. Submit a **pull request** with a description of your changes and why they improve the script.

Feel free to open issues for bug reports, feature suggestions, or questions!

## To do
- Fix the errors shown in Maiden when PARAMS are adjusted.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
