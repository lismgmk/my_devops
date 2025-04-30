# Настройка SSH и Git для работы с GitHub

## 1. Генерация SSH-ключа на сервере

Чтобы создать SSH-ключ на сервере, выполните следующую команду:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Скопируйте публичный ключ и добавьте его в GitHub (Настройки → SSH):

```bash
cat ~/.ssh/id_ed25519.pub
```

## 2. Настройка автора и его email в Git

Настройте глобальные параметры Git:

```bash
git config --global user.name "Ваше Имя"
git config --global user.email "your_email@example.com"
```

Проверьте настройки:

```bash
git config --global --list
```

## 3. Основные команды для публикации кода в GitHub


### Добавление изменений в репозиторий

```bash
# Добавить файлы в индекс
git add .

# Зафиксировать изменения с комментарием
git commit -m "Описание изменений"
```

### Отправка изменений в удалённый репозиторий

```bash
git push --set-upstream origin main	# Замените main на нужную ветку, если требуется, используем --set-upstream если на ориджине еще нет ветки локальной
```
 
### Обновление локального репозитория

```bash
git pull origin main
```

### Создание новой ветки и переключение на неё

```bash
git checkout -b new-branch
```

### Слияние ветки в `main`

```bash
git checkout main
git merge new-branch
```

### Удаление ветки

Локально:

```bash
git branch -d new-branch
```

На GitHub:

```bash
git push origin --delete new-branch
```


