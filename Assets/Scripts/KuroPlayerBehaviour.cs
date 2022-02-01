using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngineInternal.Input;

public class KuroPlayerBehaviour : MonoBehaviour
{
	public enum State
	{
		Moving,
		Jumping,
		Stopped,
		AI
	}
	
	enum AnimationStates
	{
		Idle,
		Walk,
		Jump,
		Landing
	}

	public State state;
	public GameObject Kuro;
	public Rigidbody rb;
	public float speed = 5f;
	public float defaultSpeed;
	public float defaultJumpingSpeed = 5f;
	public bool isGrounded;
	public bool canJump;
	public float jumpForce;
	public float jumpCooldown;
	public bool highPoint = false;
	private Vector3 movementVelocity;
	public Camera mainCamera;
	public CameraFollow cameraFollow;

	public Vector3 mousePosition;
	public bool aiControlled;
	public bool hasKey;

	public float zoomOffset;

	public CharacterManagerV2 characterManager;
	public Animator animator;
	public Vector3 playerDirection;

	public bool focused;
	public float JumpForceGravity;
	
	public FMOD.Studio.EventInstance PlayLandingSound;
	public FMOD.Studio.EventInstance PlayFootstepsSound;
	public FMOD.Studio.EventInstance PlayLeverSound;

	// Use this for initialization
	void Awake ()
	{
		Kuro = GameObject.FindWithTag("Kuro");
		rb = Kuro.GetComponent<Rigidbody>();
		mainCamera = Camera.main;
		cameraFollow = mainCamera.GetComponent<CameraFollow>();
		defaultJumpingSpeed = 5f;
		animator = GetComponent<Animator>();
		characterManager = GameObject.FindObjectOfType<CharacterManagerV2>();
		PlayLandingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Kuro/Jump");
		PlayFootstepsSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Footsteps");
		PlayLeverSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Environment/Lever/Lever");
	}
	
	// Update is called once per frame
	void Update()
	{
		if (!Kuro)
		{
			Kuro = this.gameObject;
			rb = Kuro.GetComponent<Rigidbody>();
			animator = GetComponent<Animator>();
		}
		mainCamera = Camera.main;
		cameraFollow = mainCamera.GetComponent<CameraFollow>();
		characterManager = GameObject.FindObjectOfType<CharacterManagerV2>();

		//Debug.Log(Physics.gravity);
		if (!aiControlled)
		{
			playerDirection = GetInput();
			playerDirection = GetKeyboardInput();

			playerDirection = RotateWithView();

			Move();

			transform.LookAt(transform.position + new Vector3(playerDirection.x, 0, playerDirection.z));

			if (Input.GetButtonDown("Square") || Input.GetKeyDown(KeyCode.Space) && isGrounded)
			{
				highPoint = false;
				rb.velocity = new Vector3(rb.velocity.x, jumpForce, rb.velocity.z);
			}

			// if (!GamePadManager.instance.Controller)
			// {
			// 	Plane playerPlane = new Plane(Vector3.up, transform.position);
			// 	Ray ray = Camera.main.ScreenPointToRay((Input.mousePosition));
			// 	float hitDist = 0.0f;
			// 	
			// 	if (playerPlane.Raycast(ray, out hitDist))
			// 	{
			// 		Vector3 targetPoint = ray.GetPoint(hitDist);
			// 		Quaternion targetRotation = Quaternion.LookRotation(targetPoint - transform.position);
			// 		targetRotation.x = 0;
			// 		targetRotation.z = 0;
			// 		transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, 7f * Time.deltaTime);
			// 	}	
			// }

			if (!isGrounded)
			{
				speed = defaultJumpingSpeed;
			}
			else if (isGrounded)
			{
				speed = defaultSpeed;
			}

			//ANIMATIONS

			if (rb.velocity.y > 0.1f && !highPoint)
			{
				animator.SetInteger("State", 2);
				//Changed animator to Jump.
			}
			if (highPoint)
			{
				//Kuro is in the air and reached the apex.
				animator.SetInteger("State", 3);
				if (animator.GetBool("is_grounded"))
				{
					if (playerDirection.sqrMagnitude < 0)
					{
						// Player is grounded, changing animation to idle.
						animator.SetInteger("State", 0);
					}
					else if (playerDirection.sqrMagnitude >= 0)
					{
						// Player is grounded and running, changing animation to run.
						animator.SetInteger("State", 1);
					}
				}
			}

			if (playerDirection.sqrMagnitude >= 0)
			{
				animator.SetInteger("State", 1);
		        
				if (rb.velocity.y > 0.1f && !highPoint)
				{
					animator.SetInteger("State", 2);
				}
				if (highPoint)
				{
					animator.SetInteger("State", 3);
				}
			}
			
			animator.SetBool("is_grounded", isGrounded);
			animator.SetFloat("direction_magnitude", playerDirection.sqrMagnitude);
		}
		
		if (rb.velocity.y < 0 && highPoint == false)
		{
			highPoint = true;
		}
		
		if (rb.velocity.y < 0)
		{
			rb.velocity += Vector3.up * Physics.gravity.y * (JumpForceGravity - 1) * Time.deltaTime;
		}
		
		animator.SetBool("apex", highPoint);

		animator.SetBool("focused", focused);
	}

	private void Move()
	{
        rb.velocity = new Vector3(playerDirection.x * speed,
                                 rb.velocity.y,
                                 playerDirection.z * speed);
    }

	private Vector3 GetInput()
	{
		Vector3 dir = Vector3.zero;

		dir.x = Input.GetAxis("Horizontal");
		dir.y = 0;
		dir.z = Input.GetAxis("Vertical");

		if (dir.magnitude > 1)
		{
			dir.Normalize();
		}

		return dir;
	}
	
	private Vector3 GetKeyboardInput()
	{
		Vector3 dir = Vector3.zero;

		dir.x = Input.GetAxis("Horizontal");
		dir.y = 0;
		dir.z = Input.GetAxis("Vertical");

		if (dir.magnitude > 1)
		{
			dir.Normalize();
		}

		return dir;
	}
    
	private Vector3 RotateWithView()
	{
		Vector3 dir = characterManager.cameraTransform.TransformDirection(playerDirection);
		dir.Set(dir.x, 0, dir.z);
		return dir.normalized * playerDirection.magnitude;
	}

    private void OnCollisionStay(Collision other)
	{
		if (other.gameObject.CompareTag("Ground") || other.gameObject.CompareTag("Box") || other.gameObject.CompareTag("Platform") || 
		    other.gameObject.CompareTag("Fallen Pillar") || other.gameObject.CompareTag("Bridge"))
		{
			isGrounded = true;
		}
	}

	private void OnCollisionEnter(Collision other)
	{
		if (other.gameObject.CompareTag("Ground") && !other.gameObject.CompareTag("Bridge"))
		{
			if (playerDirection.sqrMagnitude >= 0)
			{
				animator.SetInteger("State", 1);
			}
			else
			{
				animator.SetInteger("State", 0);
			}
		}
	}

	private void OnCollisionExit(Collision other)
	{
		if (other.gameObject.CompareTag("Ground") || other.gameObject.CompareTag("Box") || other.gameObject.CompareTag("Platform") || 
		    other.gameObject.CompareTag("Fallen Pillar") || other.gameObject.CompareTag("Bridge"))
		{
			isGrounded = false;
		}
	}

	public void PlayLandSound()
	{
		PlayLandingSound.start();
	}
	
	public void PlayFootsteps()
	{
		PlayFootstepsSound.start();
	}
    
	public void PlayLever()
	{
		PlayLeverSound.start();
	}
}
