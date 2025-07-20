local nfs = NFS or assert(require("nativefs"), "NativeFS not found. Ensure you are on a platform that supports it.")
local jej = assert(SMODS.current_mod, "JEJ ran outside of modloading process")
JEJ = jej
local jejpath = jej.path
for _, file in pairs(nfs.getDirectoryItems(jejpath.."/content")) do
    assert(SMODS.load_file("content/"..file))()
end