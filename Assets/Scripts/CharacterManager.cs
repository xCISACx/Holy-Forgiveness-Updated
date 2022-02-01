using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.AI;

public class CharacterManager : MonoBehaviour {
	
	public enum Character
	{
		Kuro,
		Yuuta,
		Kari
	}

	public enum Script
	{
		KuroScript,
		YuutaScript,
		KariScript
	}

	public Character activeCharacter;
	public Script activeScript;
	public KuroPlayerBehaviour kuroBehaviour;
	public YuutaPlayerBehaviour yuutaBehaviour;
	public KariPlayerBehaviour kariBehaviour;
	public CameraFollow cameraFollow;
	public GameObject Kuro;
	public GameObject Yuuta;
	public GameObject Kari;
	public float kuroDistance;
	public float yuutaDistance;
	public float kariDistance;
	public float maxFollowDistance;
	public float lookSpeed;
	public bool followMode;
	
	public NavMeshPath kuroToYuutaPath;
	

	// Use this for initialization
	void Start ()
	{
		cameraFollow = FindObjectOfType<CameraFollow>();
		Kuro = GameObject.FindWithTag("Kuro");
		kuroBehaviour = FindObjectOfType<KuroPlayerBehaviour>();
		Yuuta = GameObject.FindWithTag("Yuuta");
		yuutaBehaviour = FindObjectOfType<YuutaPlayerBehaviour>();
		Kari = GameObject.FindWithTag("Kari");	
		kariBehaviour = FindObjectOfType<KariPlayerBehaviour>();
	}
	
	// Update is called once per frame
	void Update () 
	{
		if (Input.GetButtonDown("Select"))
		{
			followMode = !followMode;
		}
		
		if (kuroBehaviour.isActiveAndEnabled)
		{
			cameraFollow.target = Kuro;
		}
		if (yuutaBehaviour.isActiveAndEnabled)
		{
			cameraFollow.target = Yuuta;
		}
		if (kariBehaviour.isActiveAndEnabled)
		{
			cameraFollow.target = Kari;
		}
		
		CharacterCheck();
		CharacterEnabler();
		CharacterSwitcher();
		if (followMode)
		{
			PlayerFollow();	
		}
	}

	void CharacterCheck()
	{
		switch (activeCharacter)
		{
			case Character.Kuro:
				activeScript = Script.KuroScript;
				cameraFollow.target = Kuro;
				break;
			
			case Character.Yuuta:
				activeScript = Script.YuutaScript;
				cameraFollow.target = Yuuta;
				break;
			
			case Character.Kari:
				activeScript = Script.KariScript;
				cameraFollow.target = Kari;
				break;
		}
	}

	void CharacterEnabler()
	{
		switch (activeScript)
		{
			case Script.KuroScript:
				kuroBehaviour.enabled = true;
				yuutaBehaviour.enabled = false;
				kariBehaviour.enabled = false;
				Kuro.GetComponent<Rigidbody>().isKinematic = false;
				Yuuta.GetComponent<Rigidbody>().isKinematic = true;
				Kari.GetComponent<Rigidbody>().isKinematic = true;
				yuutaBehaviour.aiControlled = true;
				break;
			
			case Script.YuutaScript:
				kuroBehaviour.enabled = false;
				yuutaBehaviour.enabled = true;
				kariBehaviour.enabled = false;
				Kuro.GetComponent<Rigidbody>().isKinematic = true;
				Yuuta.GetComponent<Rigidbody>().isKinematic = false;
				Kari.GetComponent<Rigidbody>().isKinematic = true;
				break;
			
			case Script.KariScript:
				kuroBehaviour.enabled = false;
				yuutaBehaviour.enabled = false;
				kariBehaviour.enabled = true;
				Kuro.GetComponent<Rigidbody>().isKinematic = true;
				Yuuta.GetComponent<Rigidbody>().isKinematic = true;
				Kari.GetComponent<Rigidbody>().isKinematic = false;
				break;
		}
	}

	void CharacterSwitcher()
	{			
		if (Input.GetButton("X"))
		{
			activeCharacter = Character.Yuuta;
		}

		if (Input.GetButton("Circle"))
		{
			activeCharacter = Character.Kuro;
		}

		if (Input.GetButton("Triangle"))
		{
			activeCharacter = Character.Kari;
		}
	}

	void PlayerFollow()
	{
		NavMeshAgent kuroNavMeshAgent = FindObjectOfType<KuroPlayerBehaviour>().GetComponent<NavMeshAgent>();
		
		
		if (kuroBehaviour.enabled)
		{
			var Active = Kuro;
			var Follower1 = Yuuta;
			var Follower2 = Kari;
			
			//FOLLOWER 1
			yuutaDistance = Vector3.Distance(Active.transform.position, Follower1.transform.position); //Yuuta follows Kuro
			if (yuutaDistance > maxFollowDistance)
			{
				var dir = Active.transform.position - Follower1.transform.position;
				Follower1.transform.position = Vector3.MoveTowards(Follower1.transform.position, Active.transform.position,
					yuutaBehaviour.speed * Time.deltaTime);
				Follower1.transform.rotation = Quaternion.Slerp(Follower1.transform.rotation, Quaternion.LookRotation(dir),
					lookSpeed * Time.deltaTime);
			}

			//FOLLOWER 2
			kariDistance = Vector3.Distance(Follower1.transform.position, Follower2.transform.position); //Kari follows Kuro
			if (kariDistance > maxFollowDistance)
			{
				var dir = Follower1.transform.position - Follower2.transform.position;
				Follower2.transform.position = Vector3.MoveTowards(Follower2.transform.position, Follower1.transform.position,
					kariBehaviour.speed * Time.deltaTime);
				Follower2.transform.rotation = Quaternion.Slerp(Follower2.transform.rotation, Quaternion.LookRotation(dir),
					lookSpeed * Time.deltaTime);
			}
		}

		if (yuutaBehaviour.enabled) //if the player is controlling Yuuta
		{
			var Active = Yuuta;
			var Follower1 = Kuro;
			var Follower2 = Kari;

			kuroNavMeshAgent.destination = Active.transform.position;
			kuroNavMeshAgent.updateRotation = true;

			/*kuroDistance = Vector3.Distance(Active.transform.position, Follower1.transform.position); //Kuro follows Yuuta
			if (kuroDistance > maxFollowDistance)
			{
				var dir = Active.transform.position - Follower1.transform.position;
				Follower1.transform.position = Vector3.MoveTowards(Follower1.transform.position, Active.transform.position,
					kuroBehaviour.speed * Time.deltaTime);
				Follower1.transform.rotation = Quaternion.Slerp(Follower1.transform.rotation, Quaternion.LookRotation(dir),
					lookSpeed * Time.deltaTime);
			}

			kariDistance = Vector3.Distance(Follower2.transform.position, Follower1.transform.position); //Kari follows Yuuta
			if (kariDistance > maxFollowDistance)
			{
				var dir = Follower1.transform.position - Follower2.transform.position;
				Follower2.transform.position = Vector3.MoveTowards(Follower2.transform.position, Follower1.transform.position,
					kariBehaviour.speed * Time.deltaTime);
				Follower2.transform.rotation = Quaternion.Slerp(Follower2.transform.rotation, Quaternion.LookRotation(dir),
					lookSpeed * Time.deltaTime);
			}*/
		}

		if (kariBehaviour.enabled) //if the player is controlling Kari
		{
			var Active = Kari;
			var Follower1 = Yuuta;
			var Follower2 = Kuro;
			
			yuutaDistance = Vector3.Distance(Active.transform.position, Follower1.transform.position); //Yuuta follows Kari
			if (yuutaDistance > maxFollowDistance)
			{
				var dir = Active.transform.position - Follower1.transform.position;
				Follower1.transform.position = Vector3.MoveTowards(Follower1.transform.position, Active.transform.position,
					yuutaBehaviour.speed * Time.deltaTime);
				Follower1.transform.rotation = Quaternion.Slerp(Follower1.transform.rotation, Quaternion.LookRotation(dir),
					lookSpeed * Time.deltaTime);
			}

			kuroDistance = Vector3.Distance(Follower2.transform.position, Follower1.transform.position); //Kuro follows Yuuta
			if (kuroDistance > maxFollowDistance)
			{
				var dir = Follower1.transform.position - Follower2.transform.position;
				Follower2.transform.position = Vector3.MoveTowards(Follower2.transform.position, Follower1.transform.position,
					kuroBehaviour.speed * Time.deltaTime);
				Follower2.transform.rotation = Quaternion.Slerp(Follower2.transform.rotation, Quaternion.LookRotation(dir),
					lookSpeed * Time.deltaTime);
			}
		}
	}
}
