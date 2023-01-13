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
    <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading"><strong>探索文档 »</strong></a>
    <br />
    <br />
    <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading/issues">提交BUG</a>
    ·
    <a href="https://github.com/steffen-schumacher/godot-nested-saving-loading/issues">请求功能</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->

<details>
  <summary>目录</summary>
  <ol>
    <li>
      <a href="#关于项目">关于项目</a>
      <ul>
        <li><a href="#技术栈">技术栈</a></li>
      </ul>
    </li>
    <li>
      <a href="#开始">开始</a>
      <ul>
        <li><a href="#安装">安装</a></li>
      </ul>
    </li>
    <li><a href="#用法">用法</a></li>
    <li><a href="#贡献">贡献</a></li>
    <li><a href="#许可协议">许可协议</a></li>
    <li><a href="#联系我">联系我</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## 关于项目

Nested saving and loading 插件是为Godot 3.5 制作的一个小型库（只有 131 行代码），它实现了保存和加载嵌套节点的可能性，并且每个节点都有自己独特的状态。

<p align="right">（<a href="#top">返回顶部</a>）</p>

### 技术栈

100% 使用 GDScript。

<a href="https://godotengine.org/">
  <img src="https://godotengine.org/themes/godotengine/assets/press/logo_large_monochrome_light.png" height="200px" />
</a>

<p align="right">（<a href="#top">返回顶部</a>）</p>

<!-- GETTING STARTED -->

## 开始

这个插件为 Godot3.4.x 和 Godot3.5.x 制作。

### 安装

1. 克隆仓库
   
   ```sh
   git clone https://github.com/steffen-schumacher/godot-nested-saving-loading
   ```

2. 复制 “addons” 文件夹到你的项目根目录。

3. 在 Godot 编辑器中选择 -> 项目设置 -> 插件（Plugins），然后找到此插件并勾选启用按钮。

<p align="right">（<a href="#top">返回顶部</a>）</p>

<!-- USAGE -->

## 用法

这个插件添加了一个叫 `Persistence` 的自动加载单例。

使用 `save_scene` 函数来保存场景，参数是包含当前场景的场景树和保存路径。

使用 `load_scene` 函数来加载场景，需要传入同样的参数。

| 属性                   | 类型      | 描述         | 默认值    |
|:--------------------:|:-------:|:----------:|:------:|
| `default_properties` | `Array` | 要保存的默认属性。  | `[]`   |
| `save_position`      | `bool`  | 是否要保存位置。   | `true` |
| `save_rotation`      | `bool`  | 是否要保存旋转角度。 | `true` |

保存当前场景示例：

```GDScript
   Persistence.save_scene(get_tree(), "user://savegame.save")
```

加载当前场景示例：

```GDScript
   Persistence.load_scene(get_tree(), "user://savegame.save") 
```

<strong>要使场景中的节点持久化，请添加节点到 `Persist` 组中。</strong> 默认情况下， Spatial节点和Node2D以及他们的扩展节点的位置和旋转将被保存和加载。如果节点没有扩展这些类中的一个，只有额外的值将被保存。你可以给你的持久化节点添加一个叫做 `_save()` 的函数，来保存额外的值。当加载场景时，这些值将被分配给具有匹配键的属性。

保存持久化 Spatial 或 Node2D 的可见性的函数示例：

```GDScript
   func _save():
      return {
      "visible": visible
   }
```

另一种保存额外值的方法是将你想要保存的属性的名称添加到 `Persistence.default_properties` 中。你可以通过 GDScript 或者在检查器中修改 `addons/nested-saving/Persistence.tscn` 的属性来设置。

保存所有持久化节点的的可见性的函数示例：

```GDScript
   Persistence.default_properties = ['visible']
```

<strong>如果你想保存嵌套的多层节点，你必须使根持久化节点和子节点之间的每一个节点都是持久化的，这样加载系统才能正确处理通往父节点的路径。</strong>

<strong>对的：</strong>
<br />
<img src="https://i.imgur.com/antvmaZ.png" />

<strong>错的：</strong>
<br />
<img src="https://i.imgur.com/d52gR9E.png" />

<!-- CONTRIBUTING -->

## 贡献

贡献使开源社区成为一个学习、激发灵感与创造的绝佳场所。我们非常感谢您的任何贡献。

如果你有什么建议可以让此插件变得更好，请 Fork 该版本并创建一个 Pr 。你也可以简单地用 "enhancement" 的标签在 issue 开一个问题。
不要忘了给这个项目 Star ！

1. Fork 这个项目。
2. 创建你的功能分支。 （`git checkout -b feature/AmazingFeature`）
3. Commit 你的修改。（`git commit -m 'Add some AmazingFeature'`）
4. 推送分支。 （`git push origin feature/AmazingFeature`）
5. Pr。

<p align="right">（<a href="#top">返回顶部</a>）</p>

<!-- LICENSE -->

## 许可协议

本项目使用MIT许可证。更多信息见 `LICENSE.txt` 。

<p align="right">（<a href="#top">返回顶部</a>）</p>

<!-- CONTACT -->

## 联系

Steffen Schumacher - steffenschumacher7@gmail.com

项目链接： [https://github.com/steffen-schumacher/godot-nested-saving-loading](https://github.com/steffen-schumacher/godot-nested-saving-loading)

<p align="right">（<a href="#top">返回顶部</a>）</p>
