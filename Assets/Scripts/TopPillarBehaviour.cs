using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class TopPillarBehaviour : MonoBehaviour {
	
	//public Rigidbody rb;
	//public GameObject topPillar;
	//public Transform topPillarTransform;
	public FMOD.Studio.EventInstance PlayFallingSound;
	public TextMeshPro numberText;
	public string number;
	
	// Use this for initialization
	void Start ()
	{
		//topPillar = this.gameObject;
		//rb = this.gameObject.GetComponent<Rigidbody>();
		PlayFallingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Environment/Pillars/Big Pillar Fall");
	}
	
	
	// Update is called once per frame
	/*void Update ()
	{
		//Debug.Log(transform.localEulerAngles);
		//if (gameObject.transform.localEulerAngles.x <= 0)
		{
			Debug.Log("x rotation is 0, setting rb to kinematic");
			this.gameObject.tag = "Fallen Pillar";
			gameObject.GetComponent<Rigidbody>().isKinematic = true;
		}
	}
	
	private void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.CompareTag("Ground") || other.gameObject.CompareTag("Lava"))
		{
			Debug.Log("Setting pillar tag");
			this.gameObject.tag = "Fallen Pillar";
			Debug.Log("Pillar touching ground");
			rb.isKinematic = true;
		}
	}*/

	void PlayPillarFallingSound()
	{
		PlayFallingSound.start();
	}
}
