using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BridgeBehaviour : MonoBehaviour
{
    public bool isActivated;
    public Animator bridgeAnim;

    // Use this for initialization
    void Start ()
    {
        bridgeAnim = GetComponent<Animator>();
    }
	
    // Update is called once per frame
    void Update () 
    {
        if (isActivated)
        {
            //Debug.Log("Bridge activated");
            bridgeAnim.SetBool("activated", true);
        }	
    }

    public void PlayBridgeSound()
    {
        FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Environment/Bridge/Bridge");
    }
}
