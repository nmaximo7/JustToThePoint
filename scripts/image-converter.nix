{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellScriptBin "image-converter" ''
  #!/bin/bash
  
  # Check if the input image path is provided as argument
  if [ $# -ne 2 ]; then
      echo "Usage: $0 <input_image> <directory>"
      exit 1
  fi

  mypath="$1"
  echo $mypath

  # Webp image quality
  quality="80"

  # Directory to save the files
  directory="$2"

  directoryFile="$HOME/Downloads/" # Directory where the file is in.
  website="justtothepoint"
  Destino="$HOME/$website/content/$directory/images"  
  CompartirMac="/home/nmaximo7/justtothepoint/public/"

  # Let's get filename and store in $filename variable
  file="$(basename $mypath)" 
  filename="$(basename $mypath | sed 's/\(.*\)\..*/\1/')"
  extension="''${file##*.}"

  echo "The scripts begins. First, it shows the file, its name and extension."
  echo $file
  echo $filename
  echo $extension

  # 1. Move to the image directory
  echo $directoryFile
  cd $directoryFile

  # 2. Compress the image using convert 
  ${pkgs.imagemagick}/bin/convert "''${filename}.''${extension}" -resize '1800x>' -quality 80 "''${filename}.''${extension}"
  ${pkgs.imagemagick}/bin/convert "''${filename}.''${extension}" -quality "$quality" "''${filename}.jpg"
  size=$(${pkgs.coreutils}/bin/stat -c%s "''${filename}.jpg")
  size_kb=$((size / 1024))
  if (( size_kb > 1024 )); then
      echo "File is very large, compression not working."
      exit 1
  fi

  # 3. Copy to its final destination.
  ${pkgs.coreutils}/bin/cp "''${filename}.jpg" $Destino  
  echo "Copy to its final destination."

  # 4. Compartir con Mac
  echo "Compartir con Mac if the extension is psd"
  echo $CompartirMac
  if [ -f "''${filename}.psd" ]; then
    ${pkgs.coreutils}/bin/cp "''${filename}.psd" $CompartirMac
  fi  

  # 5. Delete it
  cd $directoryFile
  ${pkgs.coreutils}/bin/rm $file

  if [ -f "''${filename}.psd" ]; then
    ${pkgs.coreutils}/bin/rm "''${filename}.psd"
  fi  

  # 6. Provide the shortcode 
  echo "![image info](../images/$filename.jpg)"
  echo "A shared psd file should be found /Principal/justtothepoint/website/public/. Copy it to /Principal/justtothepoint/images"
''
