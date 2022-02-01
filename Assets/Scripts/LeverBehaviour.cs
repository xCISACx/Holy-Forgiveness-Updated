using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LeverBehaviour : MonoBehaviour
{
	public Animator leverAnim;
	public bool isActivated;
	public GameObject leverTarget;

	// Use this for initialization
	void Start () {
		
		leverAnim = GetComponentInChildren<Animator>();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	private void OnCollisionStay(Collision other)
	{
		if (other.gameObject.CompareTag("Kuro"))
		{
			//Debug.Log("Touching Kuro");
			if (Input.GetButtonDown("R1") || Input.GetMouseButtonDown(0))
			{
				leverAnim.SetBool("activated", true);
				isActivated = true;
				if (leverTarget.GetComponent<DoorBehaviour>() != null)
					leverTarget.GetComponent<DoorBehaviour>().isActivated = true;
				
				if (leverTarget.GetComponent<BridgeBehaviour>() != null)
					leverTarget.GetComponent<BridgeBehaviour>().isActivated = true;
				
				if (leverTarget.GetComponent<HazardBehaviour>() != null)
					leverTarget.GetComponent<HazardBehaviour>().isActivated = true;
			}
		}
	}
}
