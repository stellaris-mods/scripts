# Stellaris Scripts

Mostly a collection of garbage that I use to manage my Stellaris addons.
Patches welcome. But the scripts are monsters that I don't expect anyone else will ever use.
They obviously work, though.

They do all the heavy lifting for me, in the sense that:
*  I can decouple my git repositories from the Stellaris mod folder
   (by which I mean the actual addon repositories are in ~/Projects, for example)
*  Automatically tags and makes releases in the github repository
*  Creates a zip of the releases (for github - the launcher makes it for the workshop)
*  Transpiles the steam workshop description "bbcode" to Markdown - well, it's a crappy transpiler but it tries
*  Handles the symbolic links of local repositories to the Stellaris mod folder
*  Updates the .mod file from the info in modinfo.lua

Frankly, the main problem with the workflow is that the Stellaris launcher does not support uploading addons from symbolic links. So `stlrel` is actually incredibly destructive, because it first nukes the mod entirely from the mod folder, then copies the entire working folder over, then waits for you to manually open the Stellaris launcher and upload the mod, then deletes it again, and finally runs `stlrel`.

It's not a problem in any real sense. It just annoys me that the launcher uploading doesn't work with symbolic links.

The main reason the modinfo is a lua file is because the launcher includes that in the workshop ZIP.

For anything to work,
*  Both `linkstl` and `stlrel` need to be in your `$PATH`.
*  You need to set `$STELLARIS_MOD_FOLDER` and `$STELLARIS_GIT_USER`

And you need these dependencies
*  https://github.com/folknor/luash (probably works with the original as well)
*  https://github.com/whiteinge/ok.sh
*  http://keplerproject.github.io/luafilesystem/
*  zip, jq, curl, and obviously git, and GNU coreutils

`linkstl` is mostly invoked from `stlrel`, but I also use it when I create a new addon, for example.

## Help output from `stlrel`

Remember you can use --steam and --git at the same time.

It's probably important to note that --steam does not sanity checks between steps 3 and 7, which is a sequence of rm + mkdir + cp -R + wait + rm + ln -s. But it works for me. It's safe to run it if the mod doesn't exist in `STELLARIS_MOD_FOLDER`, then the rm in step #3 will just silently do nothing.

```
Stellaris Mod Release Script
version %d - https://github.com/stellaris-mods/scripts
by folk@folk.wtf, licensed CC-BY-SA 4.0

Remember to set up ~/.netrc, read more at https://github.com/whiteinge/ok.sh.

--git:
  1. Update the .mod file in $STELLARIS_MOD_FOLDER based on the contents of modinfo.lua
  2. If info.steambb has changed since the previous git tag, transliterate the BBcode to Markdown and update info.readme
  3. Pushes a new tag in the format 19701230, appended by -HHMM if it already exists
  4. Creates a new release on github from the created tag, with a changelog
  5. Creates a ZIP with the mod contents + .mod file and adds it to the release

--steam:
  1. Updates the .mod file in $STELLARIS_MOD_FOLDER based on the contents of modinfo.lua
  2. If info.steambb has changed since the previous git tag, transliterate the BBcode to Markdown and update info.readme
  3. Deletes the mod folder from STELLARIS_MOD_FOLDER entirely
  4. Copies the contents of the current folder to STELLARIS_MOD_FOLDER/modinfo.path
  5. Waits for you to do a release
  6. Does #3 again
  7. Runs linkstl

  --steam runs even if the mod is not in git. So then it skips some parts of #2.
  I need --steam because the Stellaris launcher can not upload content from symbolic links.
  And yes, --steam is potentially destructive if $STELLARIS_MOD_FOLDER is incorrectly set, for example.

--help: This text.
--dry: git commands are ignored, for safe offline testing.
--force: Ignore untracked files or unstaged changes.
```
