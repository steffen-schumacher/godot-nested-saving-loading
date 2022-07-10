<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading">
    <img src="icon.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Godot 3.5 nested saving and Loading plugin</h3>

  <p align="center">
    This plugin implements saving and loading of Nodes with the possibility of having nested persistent Nodes which each have their own distinct state.
    <br />
    <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading/issues">Report Bug</a>
    ·
    <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading/issues">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Scene saving and loading system for the Godot Engine 3 with the possibility of saving nested Nodes, each with its own state.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

The addon is made 100% in gdscript.

<a href="https://godotengine.org/">
  <img src="https://godotengine.org/themes/godotengine/assets/press/logo_large_monochrome_light.png" height="200px" />
</a>

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This plugin adds an autoload singleton called <strong>Persistence</strong>. You can save a scene by calling `save_scene` with the tree of the scene and a path. You can load this state into the scene again by calling `load_scene` with the same parameters.

Example call that saves the current scene:
```GDScript
   save_scene(get_tree(), "user://savegame.save")
```
Example call that loads the state into the current scene:
```GDScript
   load_scene(get_tree(), "user://savegame.save") 
```
To make Nodes in the scene persistent, add them to the group `"Persist"`. The position and rotation of all members of the group will be saved on the `save_scene` call.


### Prerequisites

The plugin is made for Godot 3.4.x and 3.5.x

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo
   ```sh
   git clone https://github.com/steffen-schumacher/godot-nested-saving-loading
   ```
2. Copy the 'addons' folder into your project root
3. In the Godot Editor go to Project -> Project Settings -> Plugins and check the 'Enable' button

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Steffen Schumacher - steffenschumacher7@gmail.com

Project Link: [https://github.com/steffen-schumacher/godot-nested-saving-loading](https://github.com/steffen-schumacher/godot-nested-saving-loading)

<p align="right">(<a href="#top">back to top</a>)</p>

