using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class PitBehaviour : MonoBehaviour
{

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	private void OnTriggerEnter(Collider other)
	{
		if (other.CompareTag("Box"))
		{
			this.GetComponent<OffMeshLink>().activated = true;
			GameObject box = other.gameObject;
			box.isStatic = false;
			box.transform.position = new Vector3(box.transform.position.x, box.transform.position.y, 16.18f);
			box.GetComponent<Rigidbody>().isKinematic = true;
		}
	}

	private void OnTriggerStay(Collider other)
	{
		if (other.CompareTag("Box"))
		{
			GameObject box = other.gameObject;
			Vector3 wantedPosition = new Vector3(2.1f, -1f, 16.18f);
			if (box.transform.position != wantedPosition)
			{
				Vector3.MoveTowards(box.transform.position, wantedPosition, 0.1f);
			}
		}
	}
}
