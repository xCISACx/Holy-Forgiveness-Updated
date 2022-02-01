using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
	
	[Header("Game Manager")]
	public static GameManager instance;
	
	[Header("Spawn Points")]
	public Transform KuroSpawnPoint;
	public Transform KuroKeySpawnPoint;
	public Transform YuutaSpawnPoint;
	public Transform KariSpawnPoint;

	[Header("Prefabs")]
	public GameObject kuroPrefab;
	public GameObject KeyPrefab;
	public GameObject yuutaPrefab;
	public GameObject kariPrefab;
	
	[Header("Characters")]
	public KuroPlayerBehaviour Kuro;
	public YuutaPlayerBehaviour Yuuta;
	public KariPlayerBehaviour Kari;
	
	[Header("Colliders")]
	private CapsuleCollider kuroCollider;
	private CapsuleCollider yuutaCollider;
	private CapsuleCollider kariCollider;
	
	[Header("Scripts")]
	KuroPlayerBehaviour kuroPlayerBehaviour;
	YuutaPlayerBehaviour yuutaPlayerBehaviour;
	KariPlayerBehaviour kariPlayerBehaviour;
	KeyBehaviour keyBehaviour;
	
	[Header("Default Scales")]
	public Vector3 kuroDefaultScale;
	public Vector3 yuutaDefaultScale;
	public Vector3 kariDefaultScale;
	
	[Header("Scales")]
	Vector3 kuroScale;
	Vector3 yuutaScale;
	Vector3 kariScale;

	[Header("Game Objects")]
	public GameObject key;
	public Vector3 keyDefaultPosition;
	public GameObject[] entranceGems;
	public GameObject lava;

	public bool controller;
	public bool risingBool;
	public bool lavaRaised = false;
	public bool KuroHasKey;
	public Transform KuroHand;
	
	// Use this for initialization
	void Start ()
	{
		key = GameObject.FindWithTag("Key");
		keyBehaviour = key.GetComponent<KeyBehaviour>();
		keyDefaultPosition = key.transform.position;
	}

	// Update is called once per frame
	void Update () 
	{
		if (!Kuro)
		{
			Kuro = FindObjectOfType<KuroPlayerBehaviour>();
			kuroCollider = Kuro.GetComponent<CapsuleCollider>();
			kuroPlayerBehaviour = Kuro.GetComponent<KuroPlayerBehaviour>();
			KuroHand = GameObject.FindWithTag("KuroHand").transform;
		}

		if (!Yuuta)
		{
			Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
			yuutaCollider = Yuuta.GetComponent<CapsuleCollider>();
			yuutaPlayerBehaviour = Yuuta.GetComponent<YuutaPlayerBehaviour>();
		}

		if (!Kari)
		{
			Kari = FindObjectOfType<KariPlayerBehaviour>();
			kariCollider = Kari.GetComponent<CapsuleCollider>();
			kariPlayerBehaviour = Kari.GetComponent<KariPlayerBehaviour>();
		}

		CheckGems();
	}

	private void Awake()
	{
		if (instance == null)
		{
			instance = this;
		}

		Kuro = FindObjectOfType<KuroPlayerBehaviour>();
		Yuuta = FindObjectOfType<YuutaPlayerBehaviour>();
		Kari = FindObjectOfType<KariPlayerBehaviour>();

		kuroScale = Kuro.transform.localScale;
		yuutaScale = Yuuta.transform.localScale;
		kariScale = Kari.transform.localScale;
		
		kuroCollider = Kuro.GetComponent<CapsuleCollider>();
		yuutaCollider = Yuuta.GetComponent<CapsuleCollider>();
		kariCollider = Kari.GetComponent<CapsuleCollider>();
		
		kuroPlayerBehaviour = Kuro.GetComponent<KuroPlayerBehaviour>();
		yuutaPlayerBehaviour = Yuuta.GetComponent<YuutaPlayerBehaviour>();
		kariPlayerBehaviour = Kari.GetComponent<KariPlayerBehaviour>();

		KuroHand = GameObject.FindWithTag("KuroHand").transform;
	}
	
	public void RespawnKuro()
	{
		Instantiate(kuroPrefab, KuroSpawnPoint.position, KuroSpawnPoint.rotation); //instantiating the player prefab and enabling the collider and behaviour script since they are disabled by default.
		kuroPrefab.transform.localScale = kuroDefaultScale; //we set the player's scale to a preset scale so that the player won't spawn facing the opposite direction.
		kuroCollider.enabled = true;
		kuroPlayerBehaviour.enabled = true;
	}
	
	public void RespawnYuuta()
	{
		Instantiate(yuutaPrefab, YuutaSpawnPoint.position, YuutaSpawnPoint.rotation); //instantiating the player prefab and enabling the collider and behaviour script since they are disabled by default.
		yuutaPrefab.transform.localScale = yuutaDefaultScale; //we set the player's scale to a preset scale so that the player won't spawn facing the opposite direction.
		yuutaCollider.enabled = true;
		yuutaPlayerBehaviour.enabled = true;
	}
	
	public void RespawnKari()
	{
		Instantiate(kariPrefab, KariSpawnPoint.position, KariSpawnPoint.rotation); //instantiating the player prefab and enabling the collider and behaviour script since they are disabled by default.
		kariPrefab.transform.localScale = kariDefaultScale; //we set the player's scale to a preset scale so that the player won't spawn facing the opposite direction.
		kariCollider.enabled = true;
		kariPlayerBehaviour.enabled = true;
	}

	public void KillKuro()
	{
		if (KuroHasKey)
		{
			KuroSpawnPoint = KuroKeySpawnPoint;
		}
		RespawnKuro();
		Destroy(Kuro.gameObject);
		if (KuroHasKey)
		{
			GameObject newKey = Instantiate(KeyPrefab, KuroHand.position, Quaternion.identity);
			newKey.GetComponent<KeyBehaviour>().pickedUp = true;
		}
	}
	
	public void KillYuuta()
	{
		RespawnYuuta();
		Destroy(Yuuta.gameObject);
	}
	
	public void KillKari()
	{
		RespawnKari();
		Destroy(Kari.gameObject);
	}

	public bool entranceGemsActivated()
	{
		for (int i = 0; i < entranceGems.Length; i++)
		{
			if (!entranceGems[i].GetComponentInChildren<GemBehaviour>().isActivated)
			{
				return false;
			}
		}
		
		return true;
	}
	

	public void CheckGems()
	{
		if (entranceGemsActivated())
		{
			RaiseLavaLevel();
		}
	}

	public void CheckLavaLevel()
	{
		risingBool = lava.GetComponent<Animator>().GetBool("rising");
		if (risingBool)
		{
			RaiseLavaLevel();
		}
		else if (!risingBool)
		{
			LowerLavaLevel();
		}
	}

	public void RaiseLavaLevel()
	{
		//Debug.Log("Raising Lava level");
		lava.GetComponent<Animator>().SetBool("lowering", false);
		lava.GetComponent<Animator>().SetBool("rising", true);
		lavaRaised = true;
	}

	public void LowerLavaLevel()
	{
		//Debug.Log("Lowering Lava level");
		lava.GetComponent<Animator>().SetBool("rising", false);
		lava.GetComponent<Animator>().SetBool("lowering", true);
		lavaRaised = false;
	}
}
