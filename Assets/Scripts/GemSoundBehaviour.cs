using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GemSoundBehaviour : MonoBehaviour
{
    public GemBehaviour gemBehaviour;
    public Animator gemAnim;
    public PuzzleSolution puzzleSolution;
    
    // Start is called before the first frame update
    void Start()
    {
        gemBehaviour = GetComponent<GemBehaviour>();
        gemAnim = GetComponent<Animator>();
        puzzleSolution = gemBehaviour.Puzzle;
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void CheckNumber()
    {
        if (gemAnim.GetBool("activated"))
        {
            if (gemBehaviour.gemNumber.ToString() == "1")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound 1", transform.position);
            }
        
            if (gemBehaviour.gemNumber.ToString() == "2")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound 2");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "3")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound 3");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "4")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound 4");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "5")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound 5");
            }
        }
    }
    
    public void CheckDeactivatedNumber()
    {
        if (gemAnim.GetBool("activated") == false && !puzzleSolution.gemsReset)
        {
            if (gemBehaviour.gemNumber.ToString() == "1")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound Deactivation 1", transform.position);
                //Debug.Log("playing deac sound");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "2")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound Deactivation 2");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "3")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound Deactivation 3");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "4")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound Deactivation 4");
            }
        
            if (gemBehaviour.gemNumber.ToString() == "5")
            {
                FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Gems/Gem Sound Deactivation 5");
            }
        }
    }
}
