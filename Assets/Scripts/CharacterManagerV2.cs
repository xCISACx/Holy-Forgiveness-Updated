using System.Collections;
using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.AI;

public class CharacterManagerV2 : MonoBehaviour
{
	public static CharacterManagerV2 instance;
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
	public MinimapCameraFollow minimapCameraFollow;
	public CameraFollow cameraFollow;
	public GameObject Kuro;
	public GameObject Yuuta;
	public GameObject Kari;
	//public float kuroDistance;
	//public float yuutaDistance;
	//public float kariDistance;
	//public float maxFollowDistance;
	//public float lookSpeed;
	public bool followMode;

	public NavMeshAgent kuroNavMeshAgent;
	public NavMeshAgent yuutaNavMeshAgent;
	public NavMeshAgent kariNavMeshAgent;
	
	public Transform cameraPivot;
	public float cameraRotationSpeed;
	public Transform cameraTransform;
	public float heading;
	public bool canPressRight = true;
	public bool canPressLeft = true;

	public bool kuroAgentMoving;


	// Use this for initialization
	void Start()
	{
		cameraFollow = FindObjectOfType<CameraFollow>();
		minimapCameraFollow = FindObjectOfType<MinimapCameraFollow>();
		Kuro = GameObject.FindWithTag("Kuro");
		kuroBehaviour = FindObjectOfType<KuroPlayerBehaviour>();
		kuroNavMeshAgent = Kuro.GetComponent<NavMeshAgent>();
		Yuuta = GameObject.FindWithTag("Yuuta");
		yuutaBehaviour = FindObjectOfType<YuutaPlayerBehaviour>();
		yuutaNavMeshAgent = Yuuta.GetComponent<NavMeshAgent>();
		Kari = GameObject.FindWithTag("Kari");
		kariBehaviour = FindObjectOfType<KariPlayerBehaviour>();
		kariNavMeshAgent = Kari.GetComponent<NavMeshAgent>();
	}
	
	void Awake()
	{
		if (instance != null && instance != this)
		{
			Destroy(gameObject);
		} else 
		{
			instance = this;
		}
		
		cameraFollow = FindObjectOfType<CameraFollow>();
		minimapCameraFollow = FindObjectOfType<MinimapCameraFollow>();
		Kuro = GameObject.FindWithTag("Kuro");
		kuroBehaviour = FindObjectOfType<KuroPlayerBehaviour>();
		kuroNavMeshAgent = Kuro.GetComponent<NavMeshAgent>();
		Yuuta = GameObject.FindWithTag("Yuuta");
		yuutaBehaviour = FindObjectOfType<YuutaPlayerBehaviour>();
		yuutaNavMeshAgent = Yuuta.GetComponent<NavMeshAgent>();
		Kari = GameObject.FindWithTag("Kari");
		kariBehaviour = FindObjectOfType<KariPlayerBehaviour>();
		kariNavMeshAgent = Kari.GetComponent<NavMeshAgent>();
	}

	// Update is called once per frame
	void Update()
	{
		if (!Kuro)
		{
			Kuro = FindObjectOfType<KuroPlayerBehaviour>().gameObject;
			kuroBehaviour = FindObjectOfType<KuroPlayerBehaviour>();
			kuroNavMeshAgent = Kuro.GetComponent<NavMeshAgent>();
		}

		if (!Yuuta)
		{
			Yuuta = FindObjectOfType<YuutaPlayerBehaviour>().gameObject;
			yuutaBehaviour = FindObjectOfType<YuutaPlayerBehaviour>();
			yuutaNavMeshAgent = Yuuta.GetComponent<NavMeshAgent>();
		}

		if (!Kari)
		{
			Kari = FindObjectOfType<KariPlayerBehaviour>().gameObject;
			kariBehaviour = FindObjectOfType<KariPlayerBehaviour>();
			kariNavMeshAgent = Kari.GetComponent<NavMeshAgent>();
		}
		
		if (Input.GetButtonDown("Select"))
		{
			followMode = !followMode;
		}

		if (Kuro && kuroBehaviour.isActiveAndEnabled)
		{
			cameraFollow.lastTarget = cameraFollow.target;
			minimapCameraFollow.target = Kuro;
			cameraFollow.target = Kuro;
		}

		if (Yuuta && yuutaBehaviour.isActiveAndEnabled)
		{
			cameraFollow.lastTarget = cameraFollow.target;
			minimapCameraFollow.target = Yuuta;
			cameraFollow.target = Yuuta;
		}

		if (Kari && kariBehaviour.isActiveAndEnabled)
		{
			cameraFollow.lastTarget = cameraFollow.target;
			minimapCameraFollow.target = Kari;
			cameraFollow.target = Kari;
		}

		CharacterCheck();
		CharacterEnabler();
		CharacterSwitcher();
		
		if (followMode)
		{
			PlayerFollow();
		}
		else
		{
			switch (activeScript)
			{
				case Script.KuroScript: //if the enabled character controller script is Kuro's...
					kuroNavMeshAgent.enabled = false;
					yuutaNavMeshAgent.enabled = false;
					kariNavMeshAgent.enabled = false;
					break;

				case Script.YuutaScript:
					kuroNavMeshAgent.enabled = false;
					yuutaNavMeshAgent.enabled = false;
					kariNavMeshAgent.enabled = false;
					break;

				case Script.KariScript:
					kuroNavMeshAgent.enabled = false;
					yuutaNavMeshAgent.enabled = false;
					kariNavMeshAgent.enabled = false;
					break;
			}
		}
		
		cameraPivot.transform.position = cameraFollow.target.transform.position + cameraFollow.offset;
		cameraPivot.rotation = Quaternion.Euler(0, heading, 0);

		RotateCamera();
	}

	void CharacterCheck()
	{
		switch (activeCharacter)
		{
			case Character.Kuro:
				activeScript = Script.KuroScript;
				minimapCameraFollow.target = Kuro;
				cameraFollow.target = Kuro;
				break;

			case Character.Yuuta:
				activeScript = Script.YuutaScript;
				minimapCameraFollow.target = Yuuta;
				cameraFollow.target = Yuuta;
				break;

			case Character.Kari:
				activeScript = Script.KariScript;
				minimapCameraFollow.target = Kari;
				cameraFollow.target = Kari;
				break;
		}
	}

	void CharacterEnabler()
	{
		switch (activeScript)
		{
			case Script.KuroScript: //if the enabled character controller script is Kuro's...
				kuroBehaviour.aiControlled = false;
				yuutaBehaviour.aiControlled = true;
				kariBehaviour.aiControlled = true;
				
				Yuuta.GetComponent<Rigidbody>().velocity = new Vector3(0, Yuuta.GetComponent<Rigidbody>().velocity.y, 0);
				Kari.GetComponent<Rigidbody>().velocity = new Vector3(0, Kari.GetComponent<Rigidbody>().velocity.y, 0);

				kuroBehaviour.focused = true;
				yuutaBehaviour.focused = false;
				kariBehaviour.focused = false;
				
				//kuroBehaviour.enabled = true;
				//yuutaBehaviour.enabled = false;
				//kariBehaviour.enabled = false;
				
				//Kuro.GetComponent<Rigidbody>().isKinematic = false;
				//Yuuta.GetComponent<Rigidbody>().isKinematic = true;
				//Kari.GetComponent<Rigidbody>().isKinematic = true;
				break;

			case Script.YuutaScript:
				
				kuroBehaviour.aiControlled = true;
				yuutaBehaviour.aiControlled = false;
				kariBehaviour.aiControlled = true;
				
				kuroNavMeshAgent.enabled = true;
				yuutaNavMeshAgent.enabled = false;
				kariNavMeshAgent.enabled = true;
				
				Kuro.GetComponent<AIMove>().enabled = true;
				Yuuta.GetComponent<AIMove>().enabled = false;
				Kari.GetComponent<AIMove>().enabled = true;
				
				Kuro.GetComponent<Rigidbody>().velocity = new Vector3(0, Kuro.GetComponent<Rigidbody>().velocity.y, 0);
				Kari.GetComponent<Rigidbody>().velocity = new Vector3(0, Kari.GetComponent<Rigidbody>().velocity.y, 0);
				
				kuroBehaviour.focused = false;
				yuutaBehaviour.focused = true;
				kariBehaviour.focused = false;
				
				//Kuro.GetComponent<Rigidbody>().isKinematic = true;
				//Yuuta.GetComponent<Rigidbody>().isKinematic = false;
				//Kari.GetComponent<Rigidbody>().isKinematic = true;
				break;

			case Script.KariScript:
				
				kariBehaviour.aiControlled = false;
				kuroBehaviour.aiControlled = true;
				yuutaBehaviour.aiControlled = true;
				
				kuroNavMeshAgent.enabled = true;
				yuutaNavMeshAgent.enabled = true;
				kariNavMeshAgent.enabled = false;

				Kuro.GetComponent<AIMove>().enabled = true;
				Yuuta.GetComponent<AIMove>().enabled = true;
				Kari.GetComponent<AIMove>().enabled = false;
				
				Kuro.GetComponent<Rigidbody>().velocity = new Vector3(0, Kuro.GetComponent<Rigidbody>().velocity.y, 0);
				Yuuta.GetComponent<Rigidbody>().velocity = new Vector3(0, Yuuta.GetComponent<Rigidbody>().velocity.y, 0);
				
				kuroBehaviour.focused = false;
				yuutaBehaviour.focused = false;
				kariBehaviour.focused = true;
				
				//Kuro.GetComponent<Rigidbody>().isKinematic = true;
				//Yuuta.GetComponent<Rigidbody>().isKinematic = true;
				//Kari.GetComponent<Rigidbody>().isKinematic = false;
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
		if (!kuroBehaviour.aiControlled)
		{
			var Active = Kuro;
			var Follower1 = Yuuta;
			var Follower2 = Kari;
			
			if(Vector3.Distance(Yuuta.transform.position, Kuro.transform.position) >= Vector3.Distance(Kari.transform.position, Kuro.transform.position))
			{
				Follower1 = Kari;
				Follower2 = Yuuta;
			}

			//Debug.Log("Follower 1: " + Follower1 + ", Follower 2: " + Follower2);
			
			var Follower1AIMove = Follower1.GetComponent<AIMove>();
			Follower1AIMove.destination = Active.transform;
			var Follower2AIMove = Follower2.GetComponent<AIMove>();
			Follower2AIMove.destination = Follower1.transform;

			Follower1.GetComponent<CapsuleCollider>().enabled = true;
			Follower2.GetComponent<CapsuleCollider>().enabled = true;
			kuroNavMeshAgent.enabled = false;
			yuutaNavMeshAgent.enabled = true;
			kariNavMeshAgent.enabled = true;
			Active.GetComponent<AIMove>().enabled = false;
			Follower1.GetComponent<AIMove>().enabled = true;
			Follower2.GetComponent<AIMove>().enabled = true;
		}
		
		if (!yuutaBehaviour.aiControlled)
		{
			var Active = Yuuta;
			var Follower1 = Kuro;
			var Follower2 = Kari;
			
			if(Vector3.Distance(Follower1.transform.position, Active.transform.position) >= Vector3.Distance(Follower2.transform.position, Active.transform.position))
			{
				Follower1 = Kari;
				Follower2 = Kuro;
			}
			
			//Debug.Log("Follower 1: " + Follower1 + ", Follower 2: " + Follower2);

			var Follower1AIMove = Follower1.GetComponent<AIMove>();
			Follower1AIMove.destination = Active.transform;
			var Follower2AIMove = Follower2.GetComponent<AIMove>();
			Follower2AIMove.destination = Follower1.transform;
			
			Follower1.GetComponent<CapsuleCollider>().enabled = true;
			Follower2.GetComponent<CapsuleCollider>().enabled = true;
			kuroNavMeshAgent.enabled = true;
			yuutaNavMeshAgent.enabled = false;
			kariNavMeshAgent.enabled = true;
			Active.GetComponent<AIMove>().enabled = false;
			Follower1.GetComponent<AIMove>().enabled = true;
			Follower2.GetComponent<AIMove>().enabled = true;
		}
		
		if (!kariBehaviour.aiControlled)
		{
			var Active = Kari;
			var Follower1 = Kuro;
			var Follower2 = Yuuta;
			
			if(Vector3.Distance(Follower1.transform.position, Active.transform.position) >= Vector3.Distance(Follower2.transform.position, Active.transform.position))
			{
				Follower1 = Yuuta;
				Follower2 = Kuro;
			}

			var Follower1AIMove = Follower1.GetComponent<AIMove>();
			Follower1AIMove.destination = Active.transform;
			var Follower2AIMove = Follower2.GetComponent<AIMove>();
			Follower2AIMove.destination = Follower1.transform;
			
			Follower1.GetComponent<CapsuleCollider>().enabled = true;
			Follower2.GetComponent<CapsuleCollider>().enabled = true;
			kuroNavMeshAgent.enabled = true;
			yuutaNavMeshAgent.enabled = true;
			kariNavMeshAgent.enabled = false;
			Active.GetComponent<AIMove>().enabled = false;
			Follower1.GetComponent<AIMove>().enabled = true;
			Follower2.GetComponent<AIMove>().enabled = true;
		}
	}
	void RotateCamera()
	{
		if (Input.GetAxisRaw("D-Pad X") > 0.1f && canPressRight)
		{
			StartCoroutine(DPadRight());
		}
		
		if (Input.GetAxisRaw("D-Pad X") < -0.1f && canPressLeft)
		{
			StartCoroutine(DPadLeft());
		}

		if (Input.GetKeyDown(KeyCode.Q))
		{
			StartCoroutine(DPadLeft());
		}
		
		if (Input.GetKeyDown(KeyCode.E))
		{
			StartCoroutine(DPadRight());
		}
	}

	IEnumerator DPadRight()
	{
		//Debug.Log("Pressing D-Pad right");
		heading += 90;
		canPressRight = false;
		yield return new WaitForSeconds(0.5f);
		canPressRight = true;
	}

	IEnumerator DPadLeft()
	{
		//Debug.Log("Pressing D-Pad right");
		heading += 90;
		canPressLeft = false;
		yield return new WaitForSeconds(0.5f);
		canPressLeft = true;
	}
}
