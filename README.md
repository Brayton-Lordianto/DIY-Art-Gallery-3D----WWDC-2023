# Description

The main flow and idea of the playground app is as follows. Users can draw their own paintings on a built-in canvas and can then save that drawing (currently temporarily for simplicity) to an associated 3D frame. After deciding on a 3D frame, they will choose the title of the painting, which can be automatically detected if any text is in the drawing. They can add as many paintings as they want. They can view their painting images in simplistic form through a list of paintings, or can view them as a sort of Do-It-Yourself 3D art gallery. In this 3D art gallery, they will see their images pasted onto the frame, and they can move the paintings to a desired position, and relish at the magic of seeing their drawings take on a 3D form wherever they are.

For the best experience, fix on a landscape orientation. Additionally, draw only symmetric drawings for those using the rectangular frame, but draw any image using the circular frame.

# Tools Used

I used RealityKit for the Augmented Reality (AR) features. Main features include automatically positioning the 3D models and rendering images as textures on top of existing 3D models and loading them asynchronously. 

I also used PencilKit for the drawing of the paintings. I only used built-in tools for simplicity; the image in the painting is then saved and associated with the painting objects.

Furthermore, I used Swift's Vision API to create a simple text recognizing model that recognizes the text of images. This is then used to detect images in the drawings to automatically provide it's title (which can be changed by the user).

# References

There are two 3D models I used which are publicly available. 

One of them (titled "rectangular-frame.usdz") originated from "Fred Drabble"'s "PICTURE FRAME 15*20 dimensions", which is available in https://sketchfab.com/3d-models/picture-frame-1520-dimensions-2a75286422e64948b1d6626bc9c6d47d. 

The other (titled "circular-frame.usdz" in the app) originated from "mfb64"'s "John William Godward . Violets, Sweet Violet", which is publicly available in https://sketchfab.com/3d-models/john-william-godward-violets-sweet-violet-852a6e9f9eb64054b2d66f1e385194ae.

The main flow and idea of the playground app is as follows. Users can draw their own paintings on a built-in canvas and can then save that drawing (currently temporarily for simplicity) to an associated 3D frame. After deciding on a 3D frame, they will choose the title of the painting, which can be automatically detected if any text is in the drawing. They can add as many paintings as they want. They can view their painting images in simplistic form through a list of paintings, or can view them as a sort of Do-It-Yourself 3D art gallery. In this 3D art gallery, they will see their images pasted onto the frame, and they can move the paintings to a desired position, and relish at the magic of seeing their drawings take on a 3D form wherever they are.

For the best experience, fix on a landscape orientation. Additionally, draw only symmetric drawings for those using the rectangular frame, but draw any image using the circular frame.

