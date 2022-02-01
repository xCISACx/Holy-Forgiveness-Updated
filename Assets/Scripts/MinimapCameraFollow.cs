using UnityEngine;
using System.Collections;

public class MinimapCameraFollow : MonoBehaviour
{

	public GameObject target;

	public Vector3 offset;

	// Use this for initialization
	void Start()
	{
	}

	void Update()
	{
	}
	
	// LateUpdate is called after Update each frame
	void LateUpdate () 
	{
		// Set the position of the camera's transform to be the same as the target's.
		transform.position = target.transform.position + offset;
	}
}
