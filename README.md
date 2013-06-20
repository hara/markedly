# Markedly

[![Build Status](https://travis-ci.org/hara/markedly.png)](https://travis-ci.org/hara/markedly)

Markedly is live-reloadable markdown previewer.

Markedly converts markdown document and opens it with default browser.
Browser automatically reloads using WebSocket when you modify the document.

## Installation

```
$ gem install markedly
```

## Usage

Preview using default github css:

```
$ markedly README.md
```

Preview using custom css:

```
$ markedly README.md -c /path/to/custom.css
$ markedly README.md -c http://example.com/custom.css
```

Show options:

```
$ markedly -h
```

## Special Thanks

* [Github Markdown CSS](https://gist.github.com/andyferra/2554919)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
