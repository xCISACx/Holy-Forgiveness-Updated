using System.Collections;
using System.Collections.Generic;
using FMODUnity;
using UnityEngine;

public class DoorBehaviour : MonoBehaviour
{

	public bool isActivated;
	public bool isUnlockable;
	public Animator doorAnim;
	public bool canPlayUnlockSound;
	public bool EndLevelDoor;
	
	public FMOD.Studio.EventInstance PlayOpeningSound;

	// Use this for initialization
	void Start ()
	{
		doorAnim = GetComponentInChildren<Animator>();
		PlayOpeningSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Environment/Door/Door Opening 2");
	}
	
	// Update is called once per frame
	void Update () 
	{
		if (isActivated)
		{
			OpenDoor();
		}	
	}

	public void OpenDoor()
	{
		//Debug.Log("Door activated");
		doorAnim.SetBool("activated", true);
	}
	
	private void OnTriggerStay(Collider other)
	{
		if (other.gameObject.CompareTag("Kuro") && other.GetComponent<KuroPlayerBehaviour>().hasKey)
		{
			// Debug.Log("Kuro has the key and is touching the unlockable door");
			
			if (Input.GetButtonDown("R1"))
			{
				if (isUnlockable)
				{
					canPlayUnlockSound = true;
					//Debug.Log("Pressed R1");
					if (canPlayUnlockSound)
					{
						FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Kuro/Key Using 2");	
					}
					canPlayUnlockSound = false;
					isActivated = true;
					GameManager.instance.key.SetActive(false);
					GameManager.instance.KuroHasKey = false;
					GameManager.instance.key.GetComponent<KeyBehaviour>().pickedUp = false;
				}
				else if (!isUnlockable)
				{
					FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Kuro/Kuro Grunt");
					//Debug.Log("This door is not unlockable.");
				}
			}	
		}
	}

	public void PlayDoorOpeningSound()
	{
		PlayOpeningSound.start();
	}
	
	public void StopDoorOpeningSound()
	{
		PlayOpeningSound.stop(FMOD.Studio.STOP_MODE.ALLOWFADEOUT);
	}
}
