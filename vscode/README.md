# VSCode

## Extensões

Pra atualizar a lista:

```bash
code --list-extensions > extensions.txt
```

Pra instalar as extensões:

```bash
cat extensions.txt | xargs -n 1 code --install-extension
```
