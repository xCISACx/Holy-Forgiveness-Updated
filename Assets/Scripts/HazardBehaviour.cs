using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HazardBehaviour : MonoBehaviour
{

	public GameManager gameManager;
	public bool isActivated;
	private Animator anim;

	// Use this for initialization
	void Start ()
	{
		anim = GetComponent<Animator>();
	}
	
	// Update is called once per frame
	void Update () {
		
		if (gameManager == null)
		{
			gameManager = FindObjectOfType<GameManager>();
		}

		if (isActivated)
		{
			GetComponent<Rigidbody>().isKinematic = false;
			anim.SetBool("rising", true);
		}
	}

	private void OnTriggerEnter(Collider other)
	{		
		switch (other.tag)
		{
			case "Kuro":
				FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Kuro/Kuro Grunt");
				gameManager.KillKuro();
				break;
			
			case "Yuuta":
				FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Yuuta/Yuuta Grunt");
				gameManager.KillYuuta();
				break;
			
			case "Kari":
				FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Kari/Kari Grunt");
				gameManager.KillKari();
				break;
		}
	}
}
