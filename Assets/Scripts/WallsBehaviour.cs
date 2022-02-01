using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WallsBehaviour : MonoBehaviour
{

	public Rigidbody wallRB;

	// Use this for initialization
	void Awake ()
	{
		wallRB = this.GetComponent<Rigidbody>();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	private void OnCollisionEnter(Collision other)
	{
		if (other.gameObject.CompareTag("Yuuta") || other.gameObject.CompareTag("Kuro") || other.gameObject.CompareTag("Kari"))
		{
			other.rigidbody.isKinematic = true;
		}
	}
}
