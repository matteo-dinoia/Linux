# Useful Commands
## Media
### REMOVING METADATA
```sh
mat2 * --inplace
```
### ROTATING ALL IMAGES
```sh
for photo in *.jpg ;do
    convert $photo -rotate 90 $photo;
done
```
### Compressing photo
```sh
jpegoptim *
```
### Batch Renaming
```sh
i=1
for fi in *.jpg; do
    mv "$fi" "$(printf "book-v1-p%03d.jpg" "$i")"
    i=$((i+1))
done
```

### Image downloading and resizing
```sh
curl "link" --output "name";
convert -resize <size> "name" "name";
```
