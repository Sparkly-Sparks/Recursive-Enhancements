#Creates upscaled copies of all png files in 1x (will replace anything already in 2x)
#Place file next to assets folder and run to use

from PIL import Image
import os

os.chdir(os.path.dirname(os.path.abspath(__file__)))

try:
    os.listdir("assets/2x")
except:
    os.mkdir("assets/2x")

files=os.listdir("assets/1x")
for i in files:
    if ".png" in i:
        image=Image.open("assets/1x/"+i)
        size=image.size
        enhanced = Image.new( 'RGBA', (size[0]*2,size[1]*2), (0,0,0,0))
        pixels=enhanced.load()
        image=image.load()
        for x in range(size[0]):
            for y in range(size[1]):
                pixels[x*2,y*2]=image[x,y]
                pixels[x*2+1,y*2]=image[x,y]
                pixels[x*2,y*2+1]=image[x,y]
                pixels[x*2+1,y*2+1]=image[x,y]
        enhanced.save("assets/2x/"+i)
