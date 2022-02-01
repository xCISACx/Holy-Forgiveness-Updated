using System;
using System.Collections;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Assertions.Must;
using UnityEngine.Networking;

public class PlayerShadowBehaviour : MonoBehaviour
{
	[SerializeField] private GameObject kuroShadow;
	[SerializeField] private GameObject yuutaShadow;
	[SerializeField] private GameObject kariShadow;
	[SerializeField] public KuroPlayerBehaviour Kuro;
	[SerializeField] public YuutaPlayerBehaviour Yuuta;
	[SerializeField] public KariPlayerBehaviour Kari;
	public float radiusScaleRate;
	public float currentRadius;
	public float targetRadius;
	public float maxScale = 0.5f;
	public float minScale = 0.25f;
	public float offset;
	public float CurrentTime;
	public bool Lerp;
	public float kuroDistanceToGround;
	public float yuutaDistanceToGround;
	public float kariDistanceToGround;
	public GameObject kuroGroundCheck;
	public GameObject yuutaGroundCheck;
	public GameObject kariGroundCheck;
	//[SerializeField] private Vector3 shadowScale;
	//private KuroPlayerBehaviour kuroPlayerBehaviourScript;
	//private YuutaPlayerBehaviour yuutaPlayerBehaviourScript;
	//private KariPlayerBehaviour kariPlayerBehaviourScript;
	// Use this for initialization
	private void Awake()
	{
		Kuro = FindObjectOfType<KuroPlayerBehaviour>();
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
		Kari = FindObjectOfType<KariPlayerBehaviour>();

		kuroShadow = GameObject.FindGameObjectWithTag("Kuro Shadow");
		yuutaShadow = GameObject.FindGameObjectWithTag("Yuuta Shadow");
		kariShadow = GameObject.FindGameObjectWithTag("Kari Shadow");
		
		kuroGroundCheck = GameObject.FindGameObjectWithTag("Kuro Ground Check");
		yuutaGroundCheck = GameObject.FindGameObjectWithTag("Yuuta Ground Check");
		kariGroundCheck = GameObject.FindGameObjectWithTag("Kari Ground Check");
		
		currentRadius = kuroShadow.transform.localScale.x / 2;
	}

	// Update is called once per frame
	void Update()
	{
		if (!Kuro)
		{
			Kuro = FindObjectOfType<KuroPlayerBehaviour>();
			kuroShadow = GameObject.FindGameObjectWithTag("Kuro Shadow");
			kuroGroundCheck = GameObject.FindGameObjectWithTag("Kuro Ground Check");
		}
		
		if (!Yuuta)
		{
			Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
			yuutaShadow = GameObject.FindGameObjectWithTag("Yuuta Shadow");
			yuutaGroundCheck = GameObject.FindGameObjectWithTag("Yuuta Ground Check");
		}
		
		if (!Kari)
		{
			Kari = FindObjectOfType<KariPlayerBehaviour>();
			kariShadow = GameObject.FindGameObjectWithTag("Kari Shadow");
			kariGroundCheck = GameObject.FindGameObjectWithTag("Kari Ground Check");
		}

		currentRadius = kuroShadow.transform.localScale.x / 2;
		
		RaycastHit kuroHit = new RaycastHit();
		if (Physics.Raycast (kuroGroundCheck.transform.position, -Vector3.up, out kuroHit)) 
		{
			kuroDistanceToGround = kuroHit.distance;
			Vector3 down = transform.TransformDirection(Vector3.down) * kuroHit.distance;
			Debug.DrawRay(kuroGroundCheck.transform.position, down, Color.green);
		}
		
		RaycastHit yuutaHit = new RaycastHit();
		if (Physics.Raycast (yuutaGroundCheck.transform.position, -Vector3.up, out yuutaHit)) 
		{
			yuutaDistanceToGround = yuutaHit.distance;
			Vector3 down = transform.TransformDirection(Vector3.down) * yuutaHit.distance;
			Debug.DrawRay(yuutaGroundCheck.transform.position, down, Color.green);
		}
		
		RaycastHit kariHit = new RaycastHit();
		if (Physics.Raycast (kariGroundCheck.transform.position, -Vector3.up, out kariHit)) 
		{
			kariDistanceToGround = kariHit.distance;
			Vector3 down = transform.TransformDirection(Vector3.down) * kariHit.distance;
			Debug.DrawRay(kariGroundCheck.transform.position, down, Color.green);
		}
		
		kuroShadow.transform.position = new Vector3(Kuro.transform.position.x, kuroHit.point.y - offset, Kuro.transform.position.z);
		yuutaShadow.transform.position = new Vector3(Yuuta.transform.position.x, yuutaHit.point.y - offset, Yuuta.transform.position.z);
		kariShadow.transform.localPosition = new Vector3(Kari.transform.localPosition.x, kariHit.point.y - offset, Kari.transform.localPosition.z);
		
		kuroShadow.transform.localScale = new Vector3(Mathf.Clamp(1f/kuroDistanceToGround, minScale, maxScale), kuroShadow.transform.localScale.y, 
			Mathf.Clamp(1f/kuroDistanceToGround, minScale, maxScale));
		yuutaShadow.transform.localScale = new Vector3(Mathf.Clamp(1f/yuutaDistanceToGround, minScale, maxScale), yuutaShadow.transform.localScale.y, 
			Mathf.Clamp(1f/yuutaDistanceToGround, minScale, maxScale));
		kariShadow.transform.localScale = new Vector3(Mathf.Clamp(1f/kariDistanceToGround, minScale, maxScale), kariShadow.transform.localScale.y, 
			Mathf.Clamp(1f/kariDistanceToGround, minScale, maxScale));
		
		float angle = Vector3.Angle(kuroHit.normal, transform.up);
		// Debug.Log("angle between shadow normal and surface normal: " + angle);
		// Debug.Log(kuroHit.normal.x);
		if (kuroHit.normal.x > 0)
		{
			kuroShadow.transform.rotation = new Quaternion(angle, kuroShadow.transform.rotation.y, kuroShadow.transform.rotation.z, 1); 
		}
		else
		{
			kuroShadow.transform.rotation = new Quaternion(-angle, kuroShadow.transform.rotation.y, kuroShadow.transform.rotation.z, 1); 
		}
		// Debug.Log("shadow rotation: " + kuroShadow.transform.rotation.x + "; angle: " + angle);

		//makes the shadow follow the player while keeping its y
		/*

		shadowScale = Shadow.transform.lossyScale;

		Shadow.transform.localScale = new Vector3(currentRadius * 2, Shadow.transform.localScale.y, currentRadius * 2);
		
		if (Lerp)
			UpdateLerp();

		if (!kuroPlayerBehaviourScript.canJump && !kuroPlayerBehaviourScript.isGrounded)
		{
			currentRadius = 0.5f;
			targetRadius = 0.25f;
			StartLerp();
		}

		if (kuroPlayerBehaviourScript.canJump && kuroPlayerBehaviourScript.isGrounded)
		{
			targetRadius = 0.5f;
		}*/
	}

	/*public void StartLerp()
	{
		Lerp = true;
		CurrentTime = Time.time;
	}

	public void UpdateLerp()
	{
		//Debug.Log("Updating Lerp");
		var newScale = Vector3.Lerp(new Vector3(currentRadius, Shadow.transform.localScale.y, currentRadius),
													new Vector3(targetRadius, Shadow.transform.localScale.y, targetRadius),
														(Time.time - CurrentTime) * radiusScaleRate);

		Shadow.transform.localScale = newScale;
		
		Lerp = false;
	}*/
}
