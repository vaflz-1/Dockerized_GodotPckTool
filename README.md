# Dockerized GodotPckTool

## Description
This project provides a Docker environment for the [GodotPckTool](https://github.com/hhyyrylainen/GodotPckTool/tree/master), a tool used for managing Godot PCK files. The tool is encapsulated in a Docker image based on Ubuntu, ensuring compatibility and ease of use.

## Installation
Before starting, ensure Docker is installed on your system. Follow the official guides to install Docker on [Windows](https://docs.docker.com/docker-for-windows/install/), [Mac](https://docs.docker.com/docker-for-mac/install/), or [Linux](https://docs.docker.com/engine/install/).

### Steps:
1. **Clone the Repository**
   ```bash
   git clone https://github.com/vaflz-1/Dockerized_GodotPckTool.git
   ```
2. **Navigate to the Directory**
   ```bash
   cd Dockerized_GodotPckTool
   ```
3. **Build the Docker Image**
   ```bash
   docker build -t godotpcktool-image .
   ```
4. **Run the Container**
   ```bash
   docker run -it -v "${HOME}/Path/to/*.pck/folder":/app godotpcktool-image
   ```
<br><br><br>

### How to use GodotPckTool (from original Readme.md):
### Listing contents

Lists the files inside a pck file.

```sh
godotpcktool Thrive.pck
```

Long form:

```sh
godotpcktool --pack Thrive.pck --action list
```

### Extracting contents

Extracts the contents of a pck file.

```sh
godotpcktool Thrive.pck -a e -o extracted
```

Long form:

```sh
godotpcktool --pack Thrive.pck --action extract --output extracted
```

### Adding content

Adds content to an existing pck or creates a new pck. When creating a
new pck you can specify which Godot version the pck file says it is
packed with using the flag `set-godot-version`.

```sh
godotpcktool Thrive.pck -a a extracted --remove-prefix extracted
```

Long form:

```sh
godotpcktool --pack Thrive.pck --action add --remove-prefix extracted --file extracted
```

### Filters

Filters can be used to only act on a subset of files in a pck file, or
from the filesystem.

#### Min size

Specify the minimum size under which files are excluded:

```sh
godotpcktool --min-size-filter 1000
```

This will exclude files with size 999 bytes and below.

### Max size

Specify the maximum size above which files are excluded:

```sh
godotpcktool --max-size-filter 1000
```

NOTE: if you use max size to compliment min size extraction, you
should subtract one from the size, otherwise you'll operate on the
same files twice.

However if you want to work on exactly some size files you can specify the same size twice:
```sh
godotpcktool --min-size-filter 1 --max-size-filter 1
```

#### Include by name

The option to include files can be given a list of regular expressions that select only files
that match at least one of them to be processed. For example, you can list all files containing
"po" in their names with:
```sh
godotpcktool --include-regex-filter po
```

Or if you want to require that to be the file extension (note that different shells require
different escaping):
```sh
godotpcktool -i '\.po'
```

Multiple regular expressions can be separated by comma, or specified by giving the option
multiple times:
```sh
godotpcktool -i '\.po,\.txt'
godotpcktool -i '\.po' -i '\.txt'
```

If no include filter is specified, all files pass through it. So not specifying an include
filter means "process all files".

Note that filtering is case-sensitive.

#### Exclude by name

Files can also be excluded if they match a regular expression:
```sh
godotpcktool --exclude-regex-filter txt
```

If both include and exclude filters are specified, then first the include filter is applied,
after that the exclude filter is used to filter out files that passed the first filter.
For example to find files containing "po" but no "zh":
```sh
godotpcktool -i '\.po' -e 'zh'
```

#### Overriding filters

If you need more complex filtering you can specify regular expressions with
`--include-override-filter` which makes any file matching any of those
regular expression be included in the operation, even if another filter
would cause the file to be excluded. For example you can use this to set
file size limits and then override those for specific type:
```sh
godotpcktool --min-size-filter 1000 --include-override-filter '\.txt'
```

### Advanced Options

#### Specifying Engine Version

When creating a .pck file it is possible to specify the Godot engine
version the .pck says it is created with:

```sh
godotpcktool NewPack.pck -a a some_file.txt --set-godot-version 3.5.0
```

Note that this approach **does not** override the engine version number in existing .pck
files. This currently only applies to new .pck files.

### General info

In the long form multiple files may be included like this:
```sh
godotpcktool ... --file firstfile,secondfile
```

Make sure to use quoting if your files contain spaces, otherwise the
files will be interpreted as other options.

In the short form the files can just be listed after the other
commands. If your file begins with a `-` you can prevent it from being
interpreted as a parameter by adding `--` between the parameters and
the list of files.
<br><br><br><br>

## Troubleshooting on macOS
If you encounter the error `ERROR: creating target directory ("extracted/.import"): filesystem error: cannot create directories: Operation not permitted [extracted/.import]`, adjust your Docker settings as follows:

- Open **Docker Desktop**.
- Navigate to **Preferences > Resources > File Sharing**.
- Add the **Applications** folder to the list to enable file sharing between your container and the host system.
