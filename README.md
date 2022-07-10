<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading">
    <img src="icon.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Nested saving and loading plugin for Godot 3.5</h3>

  <p align="center">
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
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Nested saving and loading plugin for Godot 3.5 is a small library (only 131 lines of code) which implements saving and loading with the possibility of saving nested Nodes, which each have their own distinct state.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

The addon is made 100% in GDScript.

<a href="https://godotengine.org/">
  <img src="https://godotengine.org/themes/godotengine/assets/press/logo_large_monochrome_light.png" height="200px" />
</a>

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

The plugin is made for Godot 3.4.x and 3.5.x

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/steffen-schumacher/godot-nested-saving-loading
   ```
2. Copy the 'addons' folder into your project root
3. In the Godot Editor go to Project -> Project Settings -> Plugins and check the 'Enable' button

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE -->
## Usage

This plugin adds an autoload singleton called `Persistence`. Save a scene by calling `save_scene` with the tree of the scene and a path. Load the saved state back into the scene by calling `load_scene` with the same parameters.

| Property | Type | Description | Default value
| :---: | :---: | :---: | :---: |
| `default_properties` | `Array` | Default properties to save | `[]`
| `save_position` | `bool` | Should the position be saved | `true`
| `save_rotation` | `bool` | Should the rotation be saved | `true`

Example call that saves the current scene:
```GDScript
   Persistence.save_scene(get_tree(), "user://savegame.save")
```
Example call that loads the state into the current scene:
```GDScript
   Persistence.load_scene(get_tree(), "user://savegame.save") 
```
<strong>To make Nodes in the scene persistent, add them to the group `Persist`.</strong> By default, the position and the rotation of Spatial and Node2D extending Nodes will be saved and loaded. If the Node does not extend one of these Classes, only additional Values will be saved. You can add a function called `_save()` to your persistent Node, to save additional values. These will get assigned each to the property with a matching key when loading the scene.

Example function that saves the visibility of the persistent Spatial or Node2D:   
```GDScript
   func _save():
      return {
      "visible": visible
   }
```
Another way of saving additional values is adding the names of the properties, you want to save, to `Persistence.default_properties`. You can set these via GDScript or in the inspector by modifying the `addons/nested-saving/Persistence.tscn`.

Example configuration that saves the visibility of all persistent Nodes:
```GDScript
   Persistence.default_properties = ['visible']
```
<strong>If you want to save nested Nodes, you have to make every Node between the root persistent Node and the child persistent, so the loading system can process the path to the parent Nodes correctly. Also must have a valid</strong>

<strong>Right:</strong>
<br />
<img src="https://i.imgur.com/antvmaZ.png" />

<strong>Wrong:</strong>
<br />
<img src="https://i.imgur.com/d52gR9E.png" />



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

