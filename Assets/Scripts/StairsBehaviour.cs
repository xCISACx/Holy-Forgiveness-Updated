using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StairsBehaviour : MonoBehaviour
{
	public Vector3 velocity;
	public Vector3 newVelocity;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	private void OnCollisionStay(Collision other)
	{
		Vector3 normal = other.contacts[0].normal; 
		float constantSpeed = 10f;
		other.rigidbody.velocity = new Vector3(other.rigidbody.velocity.x, 0, other.rigidbody.velocity.z);
		//velocity = other.rigidbody.velocity.normalized;
		newVelocity = constantSpeed * (other.rigidbody.velocity.normalized);
		other.rigidbody.velocity = newVelocity;
		Debug.Log(other.gameObject);
		Debug.Log(other.rigidbody.velocity);
	}
}
