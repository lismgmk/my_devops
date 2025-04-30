GPG commit signature verification

1 Check for existing GPG keys
## смотрим есть ли ключи на машине, если нет то генерим
gpg --list-secret-keys --keyid-format=long
## экспорта публичного GPG-ключа для вставки в гит
gpg --armor --export key
2 Generate a new GPG key
## генерим ключ
gpg --full-generate-key


3 Add a GPG key to your GitHub account
## юай настройка
In the upper-right corner of any page on GitHub, click your profile photo, then click  Settings.
In the "Access" section of the sidebar, click  SSH and GPG keys.
Next to the "GPG keys" header, click New GPG key.
In the "Title" field, type a name for your GPG key.
In the "Key" field, paste the GPG key you copied when you generated your GPG key.
Click Add GPG key.
If prompted, authenticate to your GitHub account to confirm the action.

4 Tell Git about your signing key
git config --global user.signingkey ключ

## что бы в терминале можно было вводить секретную фразу
[ -f ~/.bashrc ] && echo -e '\nexport GPG_TTY=$(tty)' >> ~/.bashrc

5 Sign commits
## комитим с опцией S
git commit -S -m "YOUR_COMMIT_MESSAGE"
6 Sign tags
## добавляем тэг с опцией s
git tag -s MYTAG
