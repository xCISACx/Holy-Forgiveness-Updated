using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PillarBehaviour : MonoBehaviour
{
	//public Rigidbody rb;
	//public float pushForce = 10;
	//public Vector3 pushOffset;
	public bool isPushable = false;
	public GameObject topPillar;
	public Animator topPillarAnim;
	public Material breakablePillarMaterial;
	public Material normalPillarMaterial;
	public YuutaPlayerBehaviour Yuuta;
	public bool canPlayGrunt;
	//public TextMeshPro infoTextMesh;
	public GameObject infoTextObject;
	public TextMeshPro numberText;
	public string number;

	public Color32 defaultColour;
	public Color32 flashingColour;
	public bool canFlash;
	public float timer;
	public float WaitTime;
	public float ResetTime;
	public bool Pushed;

	// Use this for initialization
	void Start ()
	{
		//rb = transform.GetComponent<Rigidbody>();
		topPillarAnim = topPillar.GetComponent<Animator>();
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
		numberText = GetComponentInChildren<TextMeshPro>();
		if (numberText && number.Length != 0)
		{
			numberText.text = number;
		}

		ResetTime = WaitTime * 2;
		//infoTextMesh = GameObject.FindGameObjectWithTag("InfoText").GetComponent<TextMeshPro>();
	}
	
	// Update is called once per frame
	void Update ()
	{
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();

		if (isPushable)
		{
			timer += Time.deltaTime;
 
			if(timer < WaitTime)
			{
				topPillar.GetComponent<MeshRenderer>().material.color = Color.white;
			}
 
			if(timer > WaitTime)
			{
				topPillar.GetComponent<MeshRenderer>().material.color = flashingColour;
			}
 
			if(timer > ResetTime)
			{
				timer = 0;
			}
		}
		
		if (Pushed)
		{
			topPillar.GetComponent<MeshRenderer>().material.color = Color.white;
		}
	}

	private void OnCollisionStay(Collision other)
	{
		if (other.gameObject.CompareTag("Yuuta"))
		{
			Debug.Log("Touching Yuuta");
			if (Input.GetButtonDown("R1") || Input.GetMouseButtonDown(1))
			{
				Debug.Log("R1 pressed");
				if (isPushable)
				{
					//topPillar.GetComponent<LerpTransform>().StartLerp();
					topPillarAnim.SetBool("pushed", true);
					Yuuta.GetComponent<Animator>().SetBool("pushed", true);
					StartCoroutine(WaitBeforeChangingAnimation());
					Pushed = true;
					//rb.isKinematic = false;
					//rb.gameObject.transform.position = rb.gameObject.transform.position + pushOffset;
					//rb.AddForce(other.transform.forward * pushForce);	
				}
				else if (!isPushable)
				{
					canPlayGrunt = true;
					StartCoroutine(PlayGruntSound());
					StartCoroutine(DisplayMessage());
				}
			}
		}
	}

	private void OnCollisionEnter(Collision other)
	{
		if (other.gameObject.CompareTag("Projectile"))
		{
			if (!isPushable)
			{
				FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Kari/Arrow Explosion", transform.position);
			}
			isPushable = true;
		}
	}
	
	IEnumerator WaitBeforeChangingAnimation()
	{
		yield return new WaitForSeconds(0.8f);
		Yuuta.GetComponent<Animator>().SetBool("pushed", false);
	}
	
	IEnumerator PlayGruntSound()
	{
		FMODUnity.RuntimeManager.PlayOneShot("event:/SFX/Characters/Yuuta/Yuuta Grunt", transform.position);
		canPlayGrunt = false;
		yield return new WaitForSeconds(1);
	}

	IEnumerator DisplayMessage()
	{
		//infoTextMesh.gameObject.SetActive(true);
		infoTextObject.SetActive(true);
		yield return new WaitForSeconds(3f);
		//infoTextObject.SetActive(false);
		//infoTextObject.GetComponent<TextMeshProUGUI>().CrossFadeAlpha(0, 1.0f, false);
		//yield return new WaitForSeconds(2f);
		infoTextObject.SetActive(false);
		//infoTextMesh.gameObject.SetActive(false);
	}
}
