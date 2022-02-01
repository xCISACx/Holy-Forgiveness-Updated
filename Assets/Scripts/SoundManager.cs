using System.Collections;
using System.Collections.Generic;
using FMODUnity;
using UnityEngine;

public class SoundManager : MonoBehaviour
{
    public FMOD.Studio.EventInstance PlayBGM;
    public FMOD.Studio.EventInstance PlayLavaBubbling;
    public FMOD.Studio.EventInstance PlayLever;
    
    // Start is called before the first frame update
    void Start()
    {
        PlayBGM = FMODUnity.RuntimeManager.CreateInstance("event:/BGM/BGM");
        PlayLavaBubbling = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Environment/Lava/Lava Bubbling");
        PlayLever = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Environment/Lever/Lever");
        PlayBGM.start();
        PlayLavaBubbling.start();
    }

    public void PlaySmallPillarFallingSound()
    {
        FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Pillars/Pillar Fall");
    }
    
    public void PlayPillarSplashingSound()
    {
        FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Lava/Lava Splash");
    }

    public void PlayLeverSound()
    {
        FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Lever/Lever");
    }
}
