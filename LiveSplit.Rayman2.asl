state("Rayman2")
{
    string8 levelID      : "Rayman2.exe", 0x10039F;
    bool isCutscene      : "Rayman2.exe", 0xB7304, 0x17E;
    byte finalBossHealth : "Rayman2.exe", 0x102D64, 0xE4, 0x0, 0x4, 0x741;
    
}

init
{
   vars.cutsceneCounter = 0;
   vars.scanForBossHealth = false;
}

update
{
    if (current.levelID == "jail_20" && old.levelID == "jail_20" && old.isCutscene && !current.isCutscene)
        vars.cutsceneCounter++;
    if (!vars.scanForBossHealth && current.levelID == "Rhop_10" && current.finalBossHealth == 24)
        vars.scanForBossHealth = true;
    /*print("LevelID: " + current.levelID);
    print("isCutscene: " + current.isCutscene);
    print("finalbossHealth: " + current.finalBossHealth);
    print("cutsceneCounter: " + vars.cutsceneCounter);
    print("scanForBossHealth: " + vars.scanForBossHealth);*/
}

start
{
    if (vars.cutsceneCounter == 2) 
    {
        vars.cutsceneCounter = 0;
        return true;
    }
    return false;
}

reset
{
    return current.levelID == "jail_10";
}

isLoading
{
    // return current.isLoading;
}

split
{
    if (current.levelID == "mapmonde" && old.levelID != "mapmonde" && old.levelID != "menu")
        return true;
    if (vars.scanForBossHealth && current.levelID == "Rhop_10" && current.finalBossHealth == 0)
    {
        vars.scanForBossHealth = false;
        return true;
    }
    return false;
}
