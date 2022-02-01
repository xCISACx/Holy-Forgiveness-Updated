using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngineInternal.Input;

public class KariPlayerBehaviour : MonoBehaviour
{
	private enum State
	{
		Moving,
		Shooting
	}
	
	public GameObject Kari;
	public Rigidbody rb;
	public float speed = 5f;
	public Vector3 movementInput;
	private Vector3 movementVelocity;
	public Camera mainCamera;
	public Vector3 mousePosition;
	public bool useController;
	public bool aiControlled;
	public GameObject projectile;
	public GameObject firePoint;
	public float firingForce;
	public bool canShoot;
	public float shootingCooldown;
	public float timeToDestroy;
	public Vector3 projectileOffset;
	
	public float zoomOffset;
	
	public YuutaPlayerBehaviour yuutaBehaviour;
	public KuroPlayerBehaviour kuroBehaviour;
	public CharacterManagerV2 characterManager;

	public GameObject DirectionIndicator;
	public Vector3 playerDirection;
	public Vector3 lookDirection;
	
	public FMOD.Studio.EventInstance PlayBowDrawingSound;
	public FMOD.Studio.EventInstance PlayShootingSound;
	public bool canPlayBowDrawingSound;
	public ProjectileBehaviour projectileBehaviour;

	public bool focused;

	// Use this for initialization
	void Awake ()
	{
		Kari = GameObject.FindWithTag("Kari");
		rb = Kari.GetComponent<Rigidbody>();
		mainCamera = Camera.main;
		firePoint = GameObject.Find("FirePoint");
		DirectionIndicator = GameObject.FindWithTag("DirectionIndicator");
		yuutaBehaviour = FindObjectOfType<YuutaPlayerBehaviour>();
		kuroBehaviour = FindObjectOfType<KuroPlayerBehaviour>();
		characterManager = FindObjectOfType<CharacterManagerV2>();
		PlayBowDrawingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Kari/Bow Drawing");
		PlayShootingSound = FMODUnity.RuntimeManager.CreateInstance("event:/SFX/Characters/Kari/Bow Shooting");
	}

	// Update is called once per frame
	void Update ()
	{
		if (!Kari)
		{
			Kari = this.gameObject;
			rb = Kari.GetComponent<Rigidbody>();
			firePoint = GameObject.Find("FirePoint");
			characterManager = FindObjectOfType<CharacterManagerV2>();
		}
		mainCamera = Camera.main;
		projectileOffset = transform.forward * 2;
		DirectionIndicator = GameObject.FindWithTag("DirectionIndicator");

		if (!aiControlled)
		{
			playerDirection = GetInput();
			playerDirection = GetKeyboardInput();

			playerDirection = RotateWithView();

			Move();

			transform.LookAt(transform.position + new Vector3(playerDirection.x, 0, playerDirection.z));

			if (!GamePadManager.instance.Controller)
			{
				if (playerDirection.sqrMagnitude < 0.1f && Input.GetMouseButton(0))
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
				}
			}

			if (canShoot && Input.GetButton("R1"))
			{
				lookDirection = Vector3.zero;
				lookDirection = new Vector3(Input.GetAxisRaw ("RHorizontal"), 0, Input.GetAxisRaw ("RVertical"));

				if (lookDirection.sqrMagnitude > 0.1f)
				{
					transform.rotation = Quaternion.LookRotation(lookDirection);
					transform.rotation *= Quaternion.Euler(mainCamera.transform.parent.localEulerAngles);
				}
				
				DirectionIndicator.GetComponent<MeshRenderer>().enabled = true;
				if (canPlayBowDrawingSound) PlayBowDrawingSound.start();
				canPlayBowDrawingSound = false;
			}
			
			if (Input.GetButtonUp("R1") || Input.GetMouseButtonUp(0))
			{
				canPlayBowDrawingSound = true;
				PlayBowDrawingSound.stop(FMOD.Studio.STOP_MODE.ALLOWFADEOUT);
				StartCoroutine(Shoot());
				DirectionIndicator.GetComponent<MeshRenderer>().enabled = false;
			}
		}
	}

	public IEnumerator Shoot()
	{
		PlayShootingSound.start();
		
		GameObject newProjectile =  Instantiate(projectile, firePoint.transform.position + projectileOffset, Kari.transform.rotation * Quaternion.Euler(0, -90, 0));
		newProjectile.GetComponent<Rigidbody>().velocity = Kari.transform.forward * firingForce;
		canShoot = false;
		yield return new WaitForSeconds(shootingCooldown);
		canShoot = true;
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
}
