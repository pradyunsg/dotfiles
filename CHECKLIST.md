# Checklist for OS upgrade/change

## Data

Have at least 3 copies of all the data.

**DO NOT PROCEED UNTIL AT LEAST 3 COPIES OF YOUR DATA EXIST**
<h3>DO NOT PROCEED UNTIL AT LEAST 3 COPIES OF YOUR DATA EXIST</h3>
<h2>DO NOT PROCEED UNTIL AT LEAST 3 COPIES OF YOUR DATA EXIST</h2>
<h1>DO NOT PROCEED UNTIL AT LEAST 3 COPIES OF YOUR DATA EXIST</h1>


## SSH Keys

### Ubuntu
Backup:

```sh
mkdir ${BACKUP_PATH}/gpg
cp ~/.ssh ${BACKUP_PATH}/ssh
```

Restore:

```sh
cp ${BACKUP_PATH}/ssh ~/.ssh
```

## GPG keys

### Ubuntu
Backup:

```sh
mkdir ${BACKUP_PATH}/gpg
cp ~/.gnupg/pubring.gpg ${BACKUP_PATH}/gpg
cp ~/.gnupg/secring.gpg ${BACKUP_PATH}/gpg
gpg --export-ownertrust > ${BACKUP_PATH}/gpg/ownertrust-gpg.txt
```

Restore:

```sh
cp ${BACKUP_PATH}/gpg/*.gpg ~/.gnupg/
gpg --import-ownertrust chrisroos-ownertrust-gpg.txt
```
