## Bravado Client

If using Python you can use the [bravado](https://github.com/Yelp/bravado) package to reference the `swagger.yaml` specification directly instead of generating a seperate client in Python.

### Setup with virtualenv (Python 2 or 3)

```
virtualenv -p /PATH/TO/PYTHON venv
source venv/bin/activate
pip install bravado
python bravado-example.py
```

## Local development

The defaults for the `swagger.yml` specification may need to be updated in order to accomodate being run in a local development environment.

### http

If running in a local development environment you will want to verify both the **host:** and **scheme:** settings of the `specification/swagger.yml` file.

- use **localhost:5000**
- use **http** scheme (and not https)

From: `specification/swagger.yml`


```yaml
...
host: 'localhost:5000'
basePath: /v1
schemes:
  - http
...
```