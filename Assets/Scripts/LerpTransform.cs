using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LerpTransform : MonoBehaviour
{
	private Vector3 initialPos;
	private float CurrentTime;
	private Quaternion initialRot;
	//public Transform InitalTransform;
	public Transform TargetTransform;

	private bool Lerp;
	public float Speed;
	// Use this for initialization
	void Start ()
	{
		initialPos = transform.position;
		initialRot = transform.rotation;
	}
	
	// Update is called once per frame
	void Update ()
	{
		if(Lerp)
			UpdateLerp();
	}

	public void StartLerp()
	{
		Lerp = true;
		CurrentTime = Time.time;
	}

	void UpdateLerp()
	{
		transform.position =
			Vector3.Lerp(initialPos, TargetTransform.position, (Time.time - CurrentTime) * Speed);
		
		transform.rotation =
			Quaternion.Lerp(initialRot, TargetTransform.rotation, (Time.time - CurrentTime) * Speed);
	}
}
