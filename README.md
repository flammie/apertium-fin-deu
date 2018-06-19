# apertium-fin-deu

Apertium bilingual data for Finnish–German machine translation. Most of the
data comes from en.wiktionary.org and/or my (Flammie’s) head.

[![Build Status](https://travis-ci.org/apertium/apertium-fin-deu.svg?branch=master)](https://travis-ci.org/apertium/apertium-fin-deu)

## Installation

Standard GNU compilation as:

```
./autogen.sh
./configure
make
sudo make install
```

Or via your package manager where available.

## Usage

Use via apertium like:

```
apertium deu-fin < texts/tarina.deu.text
```


## Cite as

**Tommi Pirinen** (2018):
*Rule-based machine-translation between Finnish and German* in
[DGfS 2018: 40. Jahrestagung der Deutschen Gesellschaft für Sprachwissenschaft,
CL-Postersession](https://www.dgfs2018.uni-stuttgart.de/DGfS_2018_booklet_ONLINE_FINAL.pdf).

```bibtex
@misc{
    author = {Tommi A Pirinen},
    year = {2018},
    title = {Rule-based machine-translation between Finnish and German},
    booktitle = {DGfS 2018: 40. Jahrestagung der Deutschen Gesellschaft für
        Sprachwissenschaft},
    url =
    {https://www.dgfs2018.uni-stuttgart.de/DGfS_2018_booklet_ONLINE_FINAL.pdf},
    pages = {337}
}
```

A TeX source and author's draft version can be found in [Flammie's academic
publications repository](https://flammie.github.io/purplemonkeydishwasher).
