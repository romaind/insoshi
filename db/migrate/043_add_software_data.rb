class AddSoftwareData < ActiveRecord::Migration
  def self.up
    Software.delete_all
    Software.create(:name => "3d canvas")
    Software.create(:name => "3D game studio")
    Software.create(:name => "3dsmax")
    Software.create(:name => "AAA Logo")
    Software.create(:name => "Adesign")
    Software.create(:name => "Adobe Creative Suite 3 Design")
    Software.create(:name => "Adobe Creative Suite 3 Master Collection ")
    Software.create(:name => "Adobe Creative Suite 3 Web ")
    Software.create(:name => "Adobe Illustrator")
    Software.create(:name => "Adobe Indesign")
    Software.create(:name => "Adobe Photoshop")
    Software.create(:name => "Alias Studio Tools")
    Software.create(:name => "Amapi")
    Software.create(:name => "Ams draw")
    Software.create(:name => "Art of illusion")
    Software.create(:name => "Artrage")
    Software.create(:name => "Artweaver")
    Software.create(:name => "Auto CAD")
    Software.create(:name => "Blender 3D")
    Software.create(:name => "Bryce")
    Software.create(:name => "Carrara Studio")
    Software.create(:name => "Cinema 4D")
    Software.create(:name => "ColorVision Spyder2 Express ")
    Software.create(:name => "ColorVision Spyder2 Suite")
    Software.create(:name => "Cool 3D")
    Software.create(:name => "Corel Draw Essential")
    Software.create(:name => "Corel Paint shop pro")
    Software.create(:name => "DarkBasic")
    Software.create(:name => "Deep Paint 3D")
    Software.create(:name => "Director MX")
    Software.create(:name => "Dreamweaver")
    Software.create(:name => "DVD & CD PictureLab")
    Software.create(:name => "E-paint")
    Software.create(:name => "Eve")
    Software.create(:name => "Expression Design")
    Software.create(:name => "Faceworx")
    Software.create(:name => "Fireworks")
    Software.create(:name => "Flash")
    Software.create(:name => "FontAgent Pro")
    Software.create(:name => "Freehand MX")
    Software.create(:name => "Frontpage")
    Software.create(:name => "Gimp")
    Software.create(:name => "Gmax")
    Software.create(:name => "Go live")
    Software.create(:name => "Graphex 3")
    Software.create(:name => "GraphicConverter")
    Software.create(:name => "Hexagon")
    Software.create(:name => "Hot Door CADpatterns")
    Software.create(:name => "Hot Door Perspective")
    Software.create(:name => "HotDoor CADtools")
    Software.create(:name => "Houdini")
    Software.create(:name => "Illustrator")
    Software.create(:name => "ImageModeler")
    Software.create(:name => "Inkscape")
    Software.create(:name => "iView MediaPro")
    Software.create(:name => "K-3D")
    Software.create(:name => "KpovModeler")
    Software.create(:name => "Lightwave 3D")
    Software.create(:name => "LogoMaker")
    Software.create(:name => "Markzware FlightCheck Designer")
    Software.create(:name => "Maya")
    Software.create(:name => "MediaStudio Pro")
    Software.create(:name => "Mediator")
    Software.create(:name => "Milkshape 3D")
    Software.create(:name => "ModelMagic 3D")
    Software.create(:name => "Movie 2")
    Software.create(:name => "Multigen-creator")
    Software.create(:name => "Opencascade")
    Software.create(:name => "OpenFx")
    Software.create(:name => "Paint")
    Software.create(:name => "Painter X")
    Software.create(:name => "Photo Filtre")
    Software.create(:name => "Photo Plus")
    Software.create(:name => "Photoshop Element")
    Software.create(:name => "Pinnacle Studio")
    Software.create(:name => "Pixel32")
    Software.create(:name => "Pixia")
    Software.create(:name => "Poser")
    Software.create(:name => "Pov-Ray")
    Software.create(:name => "Premiere")
    Software.create(:name => "Qcad")
    Software.create(:name => "QuarkXPress")
    Software.create(:name => "RealFlow")
    Software.create(:name => "Rhino 3D")
    Software.create(:name => "ShowFoto")
    Software.create(:name => "SketchUp")
    Software.create(:name => "Sodipodi")
    Software.create(:name => "Softimage XSI")
    Software.create(:name => "Strata 3D")
    Software.create(:name => "Studio 9")
    Software.create(:name => "Terragen")
    Software.create(:name => "Truespace 3.2")
    Software.create(:name => "Twisted Brush")
    Software.create(:name => "Ulead PhotoImpact")
    Software.create(:name => "Ultimate Paint")
    Software.create(:name => "Vector Studio")
    Software.create(:name => "Video Studio")
    Software.create(:name => "Videowave")
    Software.create(:name => "Vincent Draw")
    Software.create(:name => "Virtual Dub")
    Software.create(:name => "Vue d'esprit")
    Software.create(:name => "Web design studio")
    Software.create(:name => "WebExpert")
    Software.create(:name => "Wings 3D")
    Software.create(:name => "Xara lx")
    Software.create(:name => "XSI")
    Software.create(:name => "Zbrush")
  end

  def self.down
    Software.delete_all
  end
end
