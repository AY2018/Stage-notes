# Note du jour - Wed 10 April

## Things to do :

- MIT cours, understand how image work + how to use Julia
- Apply what I've learned to create polygons on imgages (parsing with xml) using the library Julia Images

### MIT

Learnt:

How to use Pluto docs 

#### (Module 1)[https://computationalthinking.mit.edu/Fall22/images_abstractions/images/]

##### Images are arrays of colors

- Download/Load images
- Modify images pixels = We can inspect and modify arrays using indexing
- What broadcast is
  `Brodcast` allows you to apply a function/assign a variable to each element of an object (kind of an alternative to for loops for better readability)
- What the `: operator` does = basically selects a range between two number (1:3 = 1, 2, 3). If nothing is specified, then it means take all numbers available.
- What an `array comprehension` is : d = [i*j for i=1:3, j=1:10] => creates an array that apply multplication between the two indexes so d[3,5] = 3\*5=15. Basically a replacement of a nested for loop
  Retour sur le broadcat avec cet exemple, si d^2 mutliply la matrice par elle même != d.^2 qui met chaque élément à son carré.

##### What `abstraction` is :

First notion = apply functions to arrays regardless of the type ?

**Convolution**

Blur = for each pixel, change it's rgb value to the average of its surrounding pixels

Convolution = operation that takes in one function (`input function`) which is affected by the second function (`transformation function`) which results in a third function (`output function`).

The kernel (a matrix or function that defines how to mix the local neighborhood pixels) traverses the image.
At each position in the image, a new pixel is calculated as a weighted sum of the original pixel values overlapped by the kernel.
This operation transforms the original image (input function) into a modified image (output function) through the process defined by the kernel (transformation function).

SO When blurring an image:

Kernel Selection (Item B): Choose a blur filter (like the average filter shown).
Apply Kernel to Image (Item A to Item C): For each pixel in the original image (Item A), apply the kernel in such a way that the new image (Item C) at each pixel is the average of the original pixel and its neighbors as defined by the kernel.

## Résumé 

J'ai pu apprendre quelques bases en traitement d'Image, mais je ne m'attendais pas à être si lent. 