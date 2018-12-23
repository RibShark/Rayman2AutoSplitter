state("Rayman2")
{
    string8 levelID      : "Rayman2.exe", 0x10039F;
    float posX           : "Rayman2.exe", 0x100578, 0x4, 0x0, 0x1C;
    float posY           : "Rayman2.exe", 0x100578, 0x4, 0x0, 0x20;
    byte finalBossHealth : "Rayman2.exe", 0x102D64, 0xE4, 0x0, 0x4, 0x741;
    bool isLoading       : "Rayman2.exe", 0x11663C;
}

init
{
   vars.scanForBossHealth = false;
}

update
{
    if (!vars.scanForBossHealth && current.levelID.ToLower() == "rhop_10" && current.finalBossHealth == 24)
        vars.scanForBossHealth = true;
    //print("levelID: " + current.levelID);
    //print("posX: " + current.posX);
    //print("posY: " + current.posY);
    //print("finalbossHealth: " + current.finalBossHealth);
    //print("scanForBossHealth: " + vars.scanForBossHealth);
}

start
{
    if (current.levelID.ToLower() == "jail_20" && old.levelID.ToLower() == "jail_20" && !old.isLoading &&
        (Math.Abs(current.posX - old.posX) > 0.1 ||
        (Math.Abs(current.posY - old.posY) > 0.1)))
        return true; // X/Y position changed
}

reset
{
    return current.levelID.ToLower() == "jail_10" &&
        old.levelID.ToLower() != "jail_10";
}

isLoading
{
    return current.isLoading;
}

split
{
    if (current.levelID.ToLower() == "mapmonde" && old.levelID.ToLower() != "mapmonde" && old.levelID.ToLower() != "menu")
        return true; // map screen entered

    if (vars.scanForBossHealth && current.levelID.ToLower() == "rhop_10" && current.finalBossHealth == 0)
    {
        vars.scanForBossHealth = false;
        return true; // final boss health 0
    }
    return false;
}
