using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngineInternal.Input;

public class YuutaPlayerBehaviour : MonoBehaviour
{
	private enum State
	{
		Moving,
		Pushing
	}
	
	public GameObject Yuuta;
	public Rigidbody rb;
	public float speed = 5f;
	public Vector3 movementInput;
	private Vector3 movementVelocity;
	public Animator swordAnimator;
	private Camera mainCamera;
	public Vector3 mousePosition;
	public bool aiControlled;
	public Animator animator;
	
	public float zoomOffset;
	
	public KuroPlayerBehaviour kuroBehaviour;
	public KariPlayerBehaviour kariBehaviour;
	public CharacterManagerV2 characterManager;

    public Vector3 playerDirection;
	public CubeBehaviour cubeBehaviour;
	
	public FMOD.Studio.EventInstance PlayFootstepsSound;

	public bool focused;

    // Use this for initialization
    void Awake ()
	{
		Yuuta = GameObject.FindWithTag("Yuuta");
		rb = Yuuta.GetComponent<Rigidbody>();
		mainCamera = FindObjectOfType<Camera>();
		//swordAnimator = GetComponentInChildren<Animator>();
		
		kuroBehaviour = FindObjectOfType<KuroPlayerBehaviour>();
		kariBehaviour = FindObjectOfType<KariPlayerBehaviour>();
		characterManager = FindObjectOfType<CharacterManagerV2>();
		animator = GetComponent<Animator>();
		PlayFootstepsSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Footsteps");

	}
	
	// Update is called once per frame
	void Update ()
	{
		Yuuta = GameObject.FindWithTag("Yuuta");
		rb = Yuuta.GetComponent<Rigidbody>();
		mainCamera = FindObjectOfType<Camera>();
		characterManager = FindObjectOfType<CharacterManagerV2>();
		animator = GetComponent<Animator>();
		
		if (!aiControlled)
		{
			
			playerDirection = GetInput();
			playerDirection = GetKeyboardInput();

			playerDirection = RotateWithView();

			Move();

			transform.LookAt(transform.position + new Vector3(playerDirection.x, 0, playerDirection.z));
			
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
		}
		animator.SetFloat("direction", playerDirection.sqrMagnitude);
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

        dir.x = Input.GetAxis("LHorizontal");
        dir.y = 0;
        dir.z = Input.GetAxis("LVertical");

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

    public void PlayFootsteps()
	{
		PlayFootstepsSound.start();
	}
}
