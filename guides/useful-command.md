# Images
## REMOVING METADATA
`mat2 * --inplace`


## ROTATING ALL IMAGES -> need imagemagick
```sh
for photo in *.jpg ;do
    convert $photo -rotate 90 $photo;
done
```


## COMPRESSING PHOTO
`jpegoptim *`


## IMAGE DOWNLOAD AND RESIZING
```sh
curl "link" --output "name";
convert -resize <size> "name" "name";
```


# PDF
## COMPRESSING PDF -> need ghostscript
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -dColorImageResolution=150 -sOutputFile=output.pdf 17_grafi_albero_minimo_ricoprente.pdf


## BATCH RENAMING
```sh
i=1
for fi in *.jpg; do
    mv "$fi" "$(printf "book-v1-p%03d.jpg" "$i")"
    i=$((i+1))
done
```


## Concat
pdftk input.pdf cat 2-4 output out1.pdf


## SPLITTING PDF (2x2) -> need mupdf-tools
* mutool poster -x 2 -y 2 input.pdf output.pdf
* convert -quality 100 -density 300 a.pdf +repage -crop 2x2@  +repage b.pdf

# Git
## Git filter
install `git-filter-repo` then use as:
git filter-repo --path FOLDER_TO_REMOVE  --invert-paths
