# Image Quilting for Texture Synthesis and Transfer

> This project implements a texture synthesis and transfer technique as described in the paper - [Image Quilting for Texture Synthesis and Transfer](https://people.eecs.berkeley.edu/~efros/research/quilting/quilting.pdf) by Alexei A. Efros and Willian T. Freeman

You may want to check out the [presentation.pdf](/docs/presentation.pdf) file for more details on this project. It was made as the final project for CS 663 - **Digital Image Processing** course in Autumn 2018 at Indian Institute of Technology (IIT) Bombay, India.

## Getting Started

Follow the instructions below to get our project running on your local machine.

1. Run `/src/synthesis.m` file for texture synthesis and `/src/transfer.m` file for texture transfer.
2. Replace the first line/lines with respective input image paths to generate the output images.

## Results

### Synthesis

| Input Texture                              | Output (Quilted Texture)                    | Input Texture                              | Output (Quilted Texture)                    |
| ------------------------------------------ | ------------------------------------------- | ------------------------------------------ | ------------------------------------------- |
| ![apples.png](inputs/synthesis/apples.png) | ![apples.png](outputs/synthesis/apples.png) | ![bricks.png](inputs/synthesis/bricks.png) | ![bricks.png](outputs/synthesis/bricks.png) |
| ![cans.png](inputs/synthesis/cans.png) | ![cans.png](outputs/synthesis/cans.png) | ![chocolate.png](inputs/synthesis/chocolate.png) | ![chocolate.png](outputs/synthesis/chocolate.png) |
| ![jute.png](inputs/synthesis/jute.png) | ![jute.png](outputs/synthesis/jute.png) | ![mat.png](inputs/synthesis/mat.png) | ![mat.png](outputs/synthesis/mat.png) |
| ![rice.png](inputs/synthesis/rice.png) | ![rice.png](outputs/synthesis/rice.png) | ![spots.png](inputs/synthesis/spots.png) | ![spots.png](outputs/synthesis/spots.png) |
| ![stones.png](inputs/synthesis/stones.png) | ![stones.png](outputs/synthesis/stones.png) | ![text.png](inputs/synthesis/text.png) | ![text.png](outputs/synthesis/text.png) |
| ![tomatoes.png](inputs/synthesis/tomatoes.png) | ![tomatoes.png](outputs/synthesis/tomatoes.png) | ![windows.png](inputs/synthesis/windows.png) | ![windows.png](outputs/synthesis/windows.png) |

### Transfer

| Input Texture | Input Image | Output |
| ---------------------------------------------------- | -------------------------------------------------- | -------------------------------------------------------- |
| ![rice.png](inputs/transfer/rice.png)                                                    | ![bill.png](inputs/transfer/bill.png)                                                  | ![bill-rice.png](outputs/transfer/bill-rice.png)                                                        |
| ![fabric.png](inputs/transfer/fabric.png)                                                    | ![girl.png](inputs/transfer/girl.png)                                                  | ![girl-fabric.png](outputs/transfer/girl-fabric.png)                                                        |
| ![orange.png](inputs/transfer/orange.png)                                                    | ![potato.png](inputs/transfer/potato.png)                                                  | ![potato-orange.png](outputs/transfer/potato-orange.png)                                                        |


## Authors

* **Vamsi Krishna Reddy Satti** - [vamsi3](https://github.com/vamsi3)
* Vighnesh Reddy Konda - [scopegeneral](https://github.com/scopegeneral)
* Suraj Soni

## Acknowledgements

- **[Prof. Alexei A. Efros](https://people.eecs.berkeley.edu/~efros/)** for the amazing database of test images found [here](https://people.eecs.berkeley.edu/~efros/research/quilting/figs/).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

