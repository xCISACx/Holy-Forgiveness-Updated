using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngineInternal.Input;

public class KuroPlayerBehaviourCopy : MonoBehaviour
{
	private enum State
	{
		Moving,
		Jumping
	}
	
	enum AnimationStates
	{
		Idle,
		Walk,
		Jump,
		Landing
	}
	
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
	public Animator swordAnimator;
	public Camera mainCamera;
	public CameraFollow cameraFollow;

	public Vector3 mousePosition;
	public bool useController;
	public bool aiControlled;
	public bool hasKey;

	public float zoomOffset;

	public CharacterManagerV2 characterManager;
	public Animator animator;
	public Vector3 playerDirection;

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
	}
	
	// Update is called once per frame
	void Update ()
	{	
		Kuro = GameObject.FindWithTag("Kuro");
		rb = Kuro.GetComponent<Rigidbody>();
		mainCamera = Camera.main;
		cameraFollow = mainCamera.GetComponent<CameraFollow>();
		animator = GetComponent<Animator>();
		characterManager = GameObject.FindObjectOfType<CharacterManagerV2>();
		
		//Debug.Log(Physics.gravity);

		if (!isGrounded)
		{
			speed = defaultJumpingSpeed;
		}
		else if (isGrounded)
		{
			speed = defaultSpeed;
			animator.SetInteger("State", 0);
		}
		//Debug.Log(rb.velocity);
		//Debug.Log(Physics.gravity);
		if (!aiControlled)
		{
			/*if (!isGrounded)
			{
				playerDirection = new Vector3(Input.GetAxis("LHorizontal") * speed, rb.velocity.y, Input.GetAxis("LVertical") * speed);
			}
			else if (isGrounded)
			{
				speed = defaultSpeed;
				playerDirection = new Vector3(Input.GetAxis("LHorizontal") * speed, rb.velocity.y, Input.GetAxis("LVertical") * speed);
			}*/
			
			if (useController)
			{				
				playerDirection = GetInput();

				playerDirection = RotateWithView();
				
				Move();
        
				transform.LookAt(transform.position + new Vector3(playerDirection.x, 0, playerDirection.z));
				
				if (Input.GetButtonDown("Square") && canJump)
				{
					highPoint = false;
					Physics.gravity = new Vector3(0, -14, 0);
					Debug.Log("Pressed Space");
					StartCoroutine(Jump());
				}
				
				if (!isGrounded)
				{
					if (rb.velocity.y < 0 && this.highPoint == false)
					{
						Physics.gravity = new Vector3(0, -30, 0);
						Debug.Log("Reached Jump Apex");
						this.highPoint = true;
						animator.SetInteger("State", 3);
						Debug.Log("changing state to landing");
					}
				}

				//TODO: FIX ANIMATIONS
				/*if ((rb.velocity.x > 0.3f || rb.velocity.x > -0.3f && rb.velocity.x < 0) || 
				    (rb.velocity.z > 0.3f || rb.velocity.z > -0.3f) && (rb.velocity.z < 0))
				{
					animator.SetInteger("State", (int)AnimationStates.Walk);
				}
				else if ((rb.velocity.x < 0.3 || rb.velocity.x > -0.3f && rb.velocity.x < 0) || 
				(rb.velocity.z < 0.3f || rb.velocity.z > -0.3f) && (rb.velocity.z < 0))
				{
					animator.SetInteger("State", (int)AnimationStates.Idle);
				}*/

				/*if (rb.velocity.y > 0.1f && !highPoint)
				{
					animator.SetInteger("State", 2);
					Debug.Log("Changed animator to Jump");
				}
				if (highPoint)
				{
					Debug.Log("Kuro is in the air and reached the apex.");
					animator.SetInteger("State", 3);
				}*/
			}

			if (!useController)
			{
				Plane playerPlane = new Plane(Vector3.up, transform.position);
				Ray ray = Camera.main.ScreenPointToRay((Input.mousePosition));
				float hitDist = 0.0f;

				if (playerPlane.Raycast(ray, out hitDist))
				{
					Vector3 targetPoint = ray.GetPoint(hitDist);
					Quaternion targetRotation = Quaternion.LookRotation(targetPoint - transform.position);
					targetRotation.x = 0;
					targetRotation.z = 0;
					transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, 7f * Time.deltaTime);
				}

				if (Input.GetKeyDown(KeyCode.Space) && canJump)
				{
					highPoint = false;
					Physics.gravity = new Vector3(0, -14, 0);
					Debug.Log("Pressed Space");
					StartCoroutine(Jump());
				}
				if (!isGrounded)
				{
					if (rb.velocity.y < 0 && this.highPoint == false)
					{
						Physics.gravity = new Vector3(0, -50, 0);
						Debug.Log("Reached Jump Apex");
						this.highPoint = true;
					}
				}
			}
		}
		animator.SetBool("is_grounded", isGrounded);
	}

	private IEnumerator Jump()
	{
		rb.velocity = new Vector3(rb.velocity.x, jumpForce, rb.velocity.z);
		canJump = false;
		yield return new WaitForSeconds(jumpCooldown);
		canJump = true;
	}
	
	private void Move()
	{
		rb.velocity = playerDirection * speed;
	}

	private Vector3 GetInput()
	{
		Vector3 dir = Vector3.zero;

		dir.x = Input.GetAxis("LHorizontal");
		dir.y = 0;
		dir.z = Input.GetAxis("LVertical");

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
		if (other.gameObject.CompareTag("Ground") || other.gameObject.CompareTag("Box") || other.gameObject.CompareTag("Platform") || other.gameObject.CompareTag("Fallen Pillar"))
		{
			isGrounded = true;
		}
	}
	
	private void OnCollisionExit(Collision other)
	{
		if (other.gameObject.CompareTag("Ground") || other.gameObject.CompareTag("Box") || other.gameObject.CompareTag("Platform") || other.gameObject.CompareTag("Fallen Pillar"))
		{
			isGrounded = false;
		}
	}
}
