# mozc-ut-builder

A builder of Mozc with UT dictionary (mozc-ut)

## Summary

This software builds Mozc with [UT dictionary (mozcdic-ut)](https://github.com/utuhiro78/merge-ut-dictionaries).
This software uses [mozcdic-ut-builder](https://github.com/soltia48/mozcdic-ut-builder) to build the dictionary.

## Dependencies

### Docker

```
curl --proto '=https' --tlsv1.2 -sSf https://get.docker.com | sh
```

## Configuration

### Dictionary

Please refer to [mozcdic-ut-builder/README.md](https://github.com/soltia48/mozcdic-ut-builder/blob/main/README.md) for information on configuration related to building the dictionary.

## Usage

### Clone this software and into the directory

```
git clone --recursive https://github.com/soltia48/mozc-ut-builder.git
cd ./mozc-ut-builder/
```

### Build mozc-ut

```
./build.sh
```

The output will be placed in `./{distrinution-base}/dist.{distribution}/`.

### Install mozc-ut

You can skip to run `build.sh` manually before this operation.

```
./install.sh
```

## List of supported distribution

- Debian
- Ubuntu

## Authors

- soltia48

## Thanks

- [utuhiro78](https://github.com/utuhiro78) - Author of merge-ut-dictionaries

## License

[MIT](https://opensource.org/licenses/MIT)

Copyright (c) 2024 soltia48
