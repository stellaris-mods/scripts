-- This file is just for reference.
return {
	-- These fields are mandatory
	name = "Folk Test: Foo bar",
	path = "folk_testmodlulz",
	-- tags = {}, -- Can be an empty table, but not false or nil
	tags = { "Buildings", "Technologies" },
	picture = "thumb.png",
	--picture = false, -- Ignored, not written to .mod file by stlrel
	supported_version = "1.7.*",
	remote_file_id = 123457890,
	--remote_file_id = false, -- Ignored, not written to .mod file by stlrel

	-- These two fields are optional, but .steambb requires .readme
	readme = "test-readme.md", -- best named README.md or readme.md
	steambb = "test.bbcode", -- I usually call it steam.bbcode, but whatever you want
}

-- path:
-- Should be the same string you enter in the stellaris launchers mod tools as
-- "Directory:", the second text field under Create Mod.
-- In a local mods .mod file, this usually looks like path="mod/mymoddirectory",
-- which means you should set path = "mymoddirectory" in this file.

-- steambb:
-- This file should contain the bbcode for the addons steam workshop description,
-- if you want this to be added to the readme file automatically.
-- Note that we don't support nested [list] or [olist] within themselves, because
-- the parser is stupid at the moment.

-- readme:
-- The file stlrel should update when steambb has changed since the
-- last pushed tag.
-- Content from the steambb file will be translated to markdown and inserted
-- between these markers in the readme:
-- [//]: # (start)
-- [//]: # (stop)
-- Please make sure there is a clear newline before, between, and after both.
